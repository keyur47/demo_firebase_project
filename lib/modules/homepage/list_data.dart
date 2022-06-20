import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo_firebase_project/utils/app_color.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class ListStudent extends StatefulWidget {
  const ListStudent({Key? key}) : super(key: key);

  @override
  _ListStudentState createState() => _ListStudentState();
}

class _ListStudentState extends State<ListStudent> {
  final Stream<QuerySnapshot> studentsStream =
      FirebaseFirestore.instance.collection("students").snapshots();

  CollectionReference students =
      FirebaseFirestore.instance.collection("students");

  Future<void> deleteUser(id) {
    print("User Deleted $id");
    return students
        .doc(id)
        .delete()
        .then((value) => print("User Deleted"))
        .catchError((error) => print("Failed to Delete user: $error"));
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: studentsStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          print("Something went worng1");
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        final List storedocs = [];
        snapshot.data!.docs.map((DocumentSnapshot document) {
          Map a = document.data() as Map<String, dynamic>;
          storedocs.add(a);
          a['id'] = document.id;
          print(document.id);
          print(storedocs);
        }).toList();

        return Container(
          // margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: RefreshIndicator(
              onRefresh: () async {
                await Future.delayed(const Duration(seconds: 1));
              },
              child: Column(
                children: [
                  for (var i = 0; i < storedocs.length; i++) ...[
                    Padding(
                      padding:  EdgeInsets.only(top: 1.h,right: 3.w,left: 3.w),
                      child: Container(
                        decoration: BoxDecoration(
                            color: AppColor.backgroundColor,
                            border: Border.all(width: 1),
                            borderRadius: BorderRadius.circular(10)
                        ),
                        child: ListTile(
                          title: Text(
                           "${ storedocs[i]['name']}",
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold,color: Colors.black),
                          ),
                          subtitle: Text(
                            "${storedocs[i]['subtitle']}",
                            style: const TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold,color: Colors.grey),
                          ),
                        ),
                      ),
                    ),
                  ],
                  SizedBox(height: 1.5.h,)
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
