import 'package:demo_firebase_project/modules/controller/controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class AddButton extends StatelessWidget {
   AddButton({Key? key}) : super(key: key);
  final Controller _addQrController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ADD DETAILS"),
        elevation: 0,
      ),
    body: Column(children: [
      SizedBox(height: 20,),
      customTextField(controller: _addQrController.titleController, text: 'Title'),
      customTextField(controller: _addQrController.linkController, text: 'Url'),
      SizedBox(
        child: ElevatedButton(
          onPressed: () async {
            if (_addQrController.titleController.text.isEmpty &&
                _addQrController.linkController.text.isEmpty) {
              Get.snackbar('ERROR⚠️', 'Field is empty please add ',
                  backgroundColor: Colors.white);
            } else {
              await _addQrController.setHistoryData();
              _addQrController.allData();
              Get.back();
              _addQrController.titleController.clear();
              _addQrController.linkController.clear();
              print('${_addQrController.allData()}');
            }
          },
          child: const Text(
            'SUBMIT',
            style: TextStyle(
              fontSize: 20,
            ),
          ),
        ),
      ),
    ],),
    );
  }
  Widget customTextField({TextEditingController? controller, String? text}) {
    String? labelText;
    return Container(
        margin: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
        child: TextField(
          controller: controller,
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            labelText: text,
          ),
        ));
  }

  dateTimeformat(DateTime date) {
    final DateFormat formatter = DateFormat('yyyy-MM-dd hh:mm');
    final String formatted = formatter.format(date);
    // print("-----------$formatted");
    return formatted;
  }
}
