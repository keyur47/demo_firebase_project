import 'dart:developer';
import 'package:demo_firebase_project/model/QR_Data_model.dart';
import 'package:demo_firebase_project/model/user_data_model.dart';
import 'package:demo_firebase_project/modules/firestorerepository/firebase_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:get/get.dart';

class Controller extends GetxController {
  ScrollController scrollController = ScrollController();
  TextEditingController titleController = TextEditingController();
  TextEditingController linkController = TextEditingController();
  Firestore firestoreRepository = Firestore();
  RxString barcodeScanRes = ''.obs;
  RxString scanBarcode = ''.obs;
  RxString barcode = ''.obs;
  RxBool isLoader = false.obs;
  RxList<UserDataModel> dataList = <UserDataModel>[].obs;
  RxList<QRDataModel> QrdataList = <QRDataModel>[].obs;

  @override
  onInit() {
    allData();
    allQRData();
    super.onInit();
  }

  Future<void> setHistoryData() async {
    String docId = ListData.doc().id;
    await ListData.doc(docId).set({
      'title': titleController.text,
      'url': linkController.text,
      'time': DateTime.now(),
    });
  }


  Future<void> setQrHistoryData() async {
    String docId = ListData.doc().id;
    await QrHistoryData.doc(docId).set({
      'url': scanBarcode.value,
      'time': DateTime.now(),
    });
  }


  Future<void> allData() async {
    try {
      isLoader.value = true;
      dataList.value = await firestoreRepository.getData();
      isLoader.value = false;
    } catch (error) {
      isLoader.value = false;
      log("Error ${error.toString()}");
    }
  }


  Future<void> allQRData() async {
    try {
      isLoader.value = true;
      QrdataList.value = await firestoreRepository.getQRData();
      isLoader.value = false;
    } catch (error) {
      isLoader.value = false;
      log("Error ${error.toString()}");
    }
  }


  Future<void> scanQR() async {
    String barcodeScanRes;
    try {
      barcodeScanRes =
      await FlutterBarcodeScanner.scanBarcode('#ff6666', 'Cancel', true, ScanMode.QR);
      print(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }
    barcode.value = barcodeScanRes;
    bool isckeck = dataList.any((element) => element.url!.contains(barcode));
    log('=======>>>>$isckeck');
    if (isckeck) {
      Get.snackbar('Success', 'Successfully Scanned QR-Code!', backgroundColor: Colors.teal);
      setQrHistoryData();
    } else {
      Get.snackbar(
        'error',
        'URL not valid',
        backgroundColor: Colors.teal[200],
      );
    }
    scanBarcode.value = barcodeScanRes;
  }
}

// import 'dart:developer';
//
// import 'package:demo_xr/firebase_repository.dart';
// import 'package:demo_xr/model/QR_Data_model.dart';
// import 'package:demo_xr/model/user_data_model.dart';
// import 'package:demo_xr/utils/firebase_route.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
// import 'package:get/get.dart';
//
// class AddQrController extends GetxController {
//   TextEditingController titleController = TextEditingController();
//   TextEditingController urlController = TextEditingController();
//   FirestoreRepository repository = FirestoreRepository();
//   RxBool isLoader = false.obs;
//   RxList<UserModel> dataList = <UserModel>[].obs;
//   RxList<QRModel> QrdataList = <QRModel>[].obs;
//   RxString scanBarcode = ''.obs;
//   RxString barcode = ''.obs;
//
//   @override
//   onInit() {
//     fetchAllData();
//     fetchAllQRData();
//     super.onInit();
//   }
//
//   Future<void> setDataHistory() async {
//     String docId = forListData.doc().id;
//     await forListData.doc(docId).set({
//       'title': titleController.text,
//       'url': urlController.text,
//       'time': DateTime.now(),
//     });
//   }
//
//   Future<void> fetchAllData() async {
//     try {
//       isLoader.value = true;
//       dataList.value = await repository.getData();
//       isLoader.value = false;
//     } catch (error) {
//       isLoader.value = false;
//       log("Error ${error.toString()}");
//     }
//   }
//
//   Future<void> fetchAllQRData() async {
//     try {
//       isLoader.value = true;
//       QrdataList.value = await repository.getQRData();
//       isLoader.value = false;
//     } catch (error) {
//       isLoader.value = false;
//       log("Error ${error.toString()}");
//     }
//   }
//
//   ///temoprary
//   Future<void> setQrHistoryData() async {
//     String docId = forListData.doc().id;
//     await forQrHistoryData.doc(docId).set({
//       'url': scanBarcode.value,
//       'time': DateTime.now(),
//     });
//   }
//
//   Future<void> scanQR() async {
//     String barcodeScanRes;
//     // Platform messages may fail, so we use a try/catch PlatformException.
//     try {
//       barcodeScanRes =
//       await FlutterBarcodeScanner.scanBarcode('#ff6666', 'Cancel', true, ScanMode.QR);
//       print(barcodeScanRes);
//     } on PlatformException {
//       barcodeScanRes = 'Failed to get platform version.';
//     }
//     barcode.value = barcodeScanRes;
//     bool isckeck = dataList.any((element) => element.url!.contains(barcode));
//     log('=======>>>>$isckeck');
//     if (isckeck) {
//       Get.snackbar('Success', 'Successfully Scanned QR-Code!', backgroundColor: Colors.green);
//       setQrHistoryData();
//     } else {
//       Get.snackbar(
//         'error',
//         'URL not valid',
//         backgroundColor: Colors.red,
//       );
//     }
//     scanBarcode.value = barcodeScanRes;
//     // setQrHistoryData();
//   }
// }
