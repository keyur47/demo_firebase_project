import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  Profile({required this.name, required this.country, required this.age});

  String? name;
  String? age;
  String? country;

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final Stream<QuerySnapshot> studentsStream =
      FirebaseFirestore.instance.collection("students").snapshots();

  //fore

  final int index = 0;

  CollectionReference students =
      FirebaseFirestore.instance.collection("students");

  Future<void> deleteUser(id) {
    // print("User Deleted $id");
    return students
        .doc(id)
        .delete()
        .then((value) => print("User Deleted"))
        .catchError((error) => print("Failed to Delete user: $error"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 70, left: 130),
            child: CircleAvatar(
              radius: 50,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 180, left: 20, right: 20),
            child: Column(
              children: [
                item(
                  "Name",
                  "${widget.name}",
                ),
                item(
                  "Age",
                  "${widget.age}",
                ),
                item(
                  "Country",
                  "${widget.country}",
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget item(
    String text,
    String userName,
  ) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 20,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            text,
            style: Theme.of(context).textTheme.headline6,
          ),
          const SizedBox(
            height: 5,
          ),
          Container(
            height: 30,
            decoration: BoxDecoration(
                color: Colors.amberAccent,
                border: Border.all(width: 2),
                borderRadius: BorderRadius.circular(10)),
            child: Padding(
              padding: const EdgeInsets.only(right: 5, left: 10, bottom: 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Text(
                      userName,
                      textAlign: TextAlign.start,
                      style: const TextStyle(fontSize: 20, color: Colors.black),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
