import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo_firebase_project/utils/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';

class Scan extends StatefulWidget {
  @override
  _ScanState createState() => _ScanState();
}

class _ScanState extends State<Scan> {
  String _scanBarcode = '';
  String barcodeScanRes = '';
  String datetime = "";

  @override
  void initState() {
    super.initState();
  }

  CollectionReference qrCode = FirebaseFirestore.instance.collection("qrcode");

  Future<void> addUser() {
    return qrCode
        .add({
          'code': barcodeScanRes,
          'date': DateFormat("hh:mm a yyyy-MM-dd").format(DateTime.now())
        })
        .then((value) => print("User Added code"))
        .catchError((error) => print("Failed to Add user code: $error"));
  }

  Future<void> startBarcodeScanStream() async {
    FlutterBarcodeScanner.getBarcodeStreamReceiver(
            '#ff6666', 'Cancel', true, ScanMode.BARCODE)!
        .listen((barcode) => print(barcode));
  }

  Future<void> scanBarcodeNormal() async {
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.BARCODE);
      print(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }

    if (!mounted) return;
    setState(() {
      _scanBarcode = barcodeScanRes;
      addUser();
      print("object${barcodeScanRes}");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Builder(
        builder: (BuildContext context) {
          return Container(
            alignment: Alignment.center,
            child: Flex(
              direction: Axis.vertical,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    scanBarcodeNormal();
                  },
                  child: Container(
                    child: Image.asset("assets/image/qrcode.jpg",
                        height: 40.h,),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
