import 'dart:developer';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo_firebase_project/utils/app_color.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class AddStudent extends StatefulWidget {
  const AddStudent({Key? key}) : super(key: key);

  @override
  _AddStudentState createState() => _AddStudentState();
}

class _AddStudentState extends State<AddStudent> {
  final _formkey = GlobalKey<FormState>();

  var name = "";
  var subtitle = "";
  Map imageProfile = {};
  ImagePicker pick = ImagePicker();
  XFile? imageFile;
  String? imagePath;
  final nameController = TextEditingController();
  final subtitleController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    subtitleController.dispose();
    super.dispose();
  }

  clearText() {
    nameController.clear();
    subtitleController.clear();
  }

  CollectionReference students =
      FirebaseFirestore.instance.collection("students");

  Future<void> addUser() {
    return students
        .add({'name': name,'subtitle': subtitle,})
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to Add user: $error"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        // leading: GestureDetector(
        //     onTap: (){
        //       Get.back();
        //     },
        //     child: const Icon(Icons.arrow_back,color: Colors.white,)),
        backgroundColor: AppColors.darkBlue,
        title: const Text("Add New Details",style: TextStyle(color: Colors.white),),
      ),
      body: Form(
        key: _formkey,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 30),
          child: ListView(
            children: [
              const SizedBox(
                height: 20,
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                child: TextFormField(
                  autofocus: false,
                  decoration: const InputDecoration(

                      hintText: "TITLE",
                      hintStyle: TextStyle(fontSize: 16),
                      border: OutlineInputBorder(),
                      errorStyle: TextStyle(color: Colors.red, fontSize: 14)),
                  controller: nameController,
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
                  decoration: const InputDecoration(
                      hintText: "SUBTITLE",
                      hintStyle: TextStyle(fontSize: 16),
                      border: OutlineInputBorder(),
                      errorStyle: TextStyle(color: Colors.red, fontSize: 14)),
                  controller: subtitleController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please Enter Name";
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    onTap: () {
                      if (_formkey.currentState!.validate()) {
                        setState(() {
                          name = nameController.text;
                          subtitle = subtitleController.text;
                          addUser();
                          clearText();
                          Get.back();
                        });
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
                        color: Colors.red,
                      ),
                      child: const Padding(
                        padding: EdgeInsets.only(top: 3),
                        child: Text(
                          "Register",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w300,
                              color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      clearText();
                    },
                    child: Container(
                      height: 34,
                      width: 80,
                      decoration: BoxDecoration(
                        border: Border.all(width: 2),
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(5),
                            topRight: Radius.circular(5),
                            bottomLeft: Radius.circular(5),
                            bottomRight: Radius.circular(5)),
                        color: Colors.amberAccent,
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
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
  _getFromGallery() async {
    try {
      XFile? image = await pick.pickImage(
        source: ImageSource.gallery,
      );
      if (image != null) {
        if (kDebugMode) {
          setState(() {
            log("message-------${image.path}");
            imagePath = image.path;
            log("--------------${imagePath}");
          });
          print("--------------${imageFile?.path}");
        }
      }
    } catch (e) {
      log("error--->${e.toString()}");
    }
  }

}
