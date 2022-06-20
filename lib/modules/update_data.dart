import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UpdateName extends StatefulWidget {
  UpdateName({required this.id});

  final String id;

  @override
  _UpdateNameState createState() => _UpdateNameState();
}

class _UpdateNameState extends State<UpdateName> {
  final _formkey = GlobalKey<FormState>();

  CollectionReference students =
  FirebaseFirestore.instance.collection("students");

  Future<void> updateUser(id, name, age, country) {
    return students
        .doc(id)
        .update({'name': name, "age": age, "country": country})
        .then((value) => print("User Updated"))
        .catchError((error) => print("Failed to update user:$error"));

    // print("user update");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text("Update"),
      ),
      body: Form(
        key: _formkey,

        // Getting Specific Data by ID
        child: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
          future: FirebaseFirestore.instance
              .collection('students')
              .doc(widget.id)
              .get(),
          builder: (_, snapshot) {
            if (snapshot.hasError) {
              print("Something went wrong");
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }

            var data = snapshot.data!.data();
            var name = data!['name'];
            var age = data['age'];
            var country = data['country'];
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 30),
              child: ListView(
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    child: TextFormField(
                      autofocus: false,
                      initialValue: name,
                      decoration: const InputDecoration(
                          hintText: "Name",
                          hintStyle: TextStyle(fontSize: 16),
                          border: OutlineInputBorder(),
                          errorStyle:
                          TextStyle(color: Colors.red, fontSize: 14)),
                      onChanged: (value) => name = value,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please Enter Name";
                        }
                        return null;
                      },
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    child: TextFormField(
                      autofocus: false,
                      initialValue: age,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                          hintText: "age",
                          hintStyle: TextStyle(fontSize: 16),
                          border: OutlineInputBorder(
                            borderSide:
                            BorderSide(color: Colors.red, width: 50),
                          ),
                          errorStyle:
                          TextStyle(color: Colors.red, fontSize: 14)),
                      onChanged: (value) => age = value,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please Enter Email";
                        } else if (!value.contains('')) {
                          return "please Enter Valid Email";
                        }
                        return null;
                      },
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    child: TextFormField(
                      autofocus: false,
                      initialValue: country,
                      decoration: const InputDecoration(
                          hintText: "country",
                          hintStyle: TextStyle(fontSize: 16),
                          border: OutlineInputBorder(),
                          errorStyle:
                          TextStyle(color: Colors.red, fontSize: 14)),
                      onChanged: (value) => country = value,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please Enter Password";
                        }
                        return null;
                      },
                    ),
                  ),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        GestureDetector(
                          onTap: () {
                            if (_formkey.currentState!.validate()) {
                              updateUser(widget.id, name, age, country);
                              Get.back();
                            }
                          },
                          child: Container(
                            height: 34,
                            width: 100,
                            decoration: BoxDecoration(
                              border: Border.all(width: 2),
                              borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(5),
                                  topRight: Radius.circular(5),
                                  bottomLeft: Radius.circular(5),
                                  bottomRight: Radius.circular(5)),
                              color: Colors.yellow,
                            ),
                            child: const Padding(
                              padding: EdgeInsets.only(top: 3),
                              child: Text(
                                "Update",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.w300,
                                    color: Colors.black),
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: Container(
                            height: 34,
                            width: 100,
                            decoration: BoxDecoration(
                              border: Border.all(width: 2),
                              borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(5),
                                  topRight: Radius.circular(5),
                                  bottomLeft: Radius.circular(5),
                                  bottomRight: Radius.circular(5)),
                              color: Colors.red,
                            ),
                            child: const Padding(
                              padding: EdgeInsets.only(top: 3),
                              child: Text(
                                "Reset",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.w300,
                                    color: Colors.black),
                              ),
                            ),
                          ),
                        ),

                        // ElevatedButton(
                        //   onPressed: () {
                        //     if (_formkey.currentState!.validate()) {
                        //       updateUser(widget.id, name, email, password);
                        //       Get.back();
                        //     }
                        //   },
                        //   child: const Text(
                        //     "Update",
                        //     style: TextStyle(fontSize: 18),
                        //   ),
                        // ),
                        // ElevatedButton(
                        //   onPressed: () {},
                        //   style: ElevatedButton.styleFrom(
                        //       primary: Colors.blueGrey),
                        //   child: const Text(
                        //     "Reset",
                        //     style: TextStyle(fontSize: 18),
                        //   ),
                        // ),
                      ],
                    ),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
