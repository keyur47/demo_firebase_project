import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo_firebase_project/model/QR_Data_model.dart';
import 'package:demo_firebase_project/model/user_data_model.dart';
import 'package:flutter/foundation.dart';
import 'const.dart';

CollectionReference QrHistoryData = kFirebaseStore.collection('QrHistoryData');
CollectionReference ListData = kFirebaseStore.collection('ListData');


class Firestore {
  Future<List<UserDataModel>> getData() async {
    Query query = FirebaseFirestore.instance.collection("ListData");
    return await query.get().then((data) {
      try {
        var tempList = <UserDataModel>[].toList();
        final docsnapshot = data.docs;
        for (var snapshot in docsnapshot) {
          if (snapshot.exists) {
            var map = snapshot.data() as Map<String, dynamic>;
            map['id'] = snapshot.id;
            if (kDebugMode) {}
            tempList.add(UserDataModel.fromJson(map));
          }
        }
        // tempList.sort((a, b) => a.time!.compareTo(b.time!));
        tempList.sort((a, b) {
          var A = a.time;
          var B = b.time;
          return -A!.compareTo(B!);
        });
        return tempList;
      } catch (e) {
        print("Error ${e.toString()}");
        return [];
      }
    });
  }

  Future<List<QRDataModel>> getQRData() async {
    Query query = FirebaseFirestore.instance.collection("QrHistoryData");
    return await query.get().then((data) {
      try {
        var tempList = <QRDataModel>[].toList();
        final docsnapshot = data.docs;
        for (var snapshot in docsnapshot) {
          if (snapshot.exists) {
            var map = snapshot.data() as Map<String, dynamic>;
            map['id'] = snapshot.id;
            if (kDebugMode) {}
            tempList.add(QRDataModel.fromJson(map));
          }
        }
        tempList.sort((a, b) {
          var A = a.time;
          var B = b.time;
          return -A!.compareTo(B!);
        });
        return tempList;
      } catch (e) {
        print("Error ${e.toString()}");
        return [];
      }
    });
  }
}
