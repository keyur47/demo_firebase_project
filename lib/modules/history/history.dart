import 'package:demo_firebase_project/modules/controller/controller.dart';
import 'package:demo_firebase_project/utils/app_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class History extends StatelessWidget {
  final Controller _addQrController = Get.find();
  static const routeName = '/History';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('QR Scanned History'),
          elevation: 0,
        ),
        body: Column(
          children: [
            SizedBox(height: 10,),
            Expanded(
              child: Obx(
                    () => _addQrController.isLoader.value
                    ? const Center(
                  child: CircularProgressIndicator(),
                )
                    : RawScrollbar(
                      interactive: false,
                      thickness: 10,
                      thumbColor: Colors.transparent,
                      radius: const Radius.circular(12),
                      child: ListView.builder(
                      itemCount: _addQrController.QrdataList.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(left: 10,right: 10,bottom: 10),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(width: 2),
                              color: AppColors.grey[200],
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Column(
                                children: [
                                  Text(
                                    _addQrController.QrdataList[index].url??'',
                                    style: const TextStyle(fontSize: 22,color: Colors.lightBlue, decoration: TextDecoration.underline,),
                                  ),
                                  Text(
                                    dateTimeformat(_addQrController.QrdataList[index].time!.toDate()),
                                    style: const TextStyle(fontSize: 18,color: Colors.red),
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                    ),
              ),
            ),
          ],
        ));
  }

  dateTimeformat(DateTime date) {
    final DateFormat formatter = DateFormat('yyyy-MM-dd hh:mm');
    final String formatted = formatter.format(date);
    // print("-----------$formatted");
    return formatted;
  }
}



















// import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
// import 'package:demo_firebase_project/utils/app_color.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:sizer/sizer.dart';
// import 'package:intl/intl.dart';
//
//
// class Historys extends StatefulWidget {
//   const Historys({Key? key}) : super(key: key);
//
//   @override
//   State<Historys> createState() => _HistorysState();
// }
//
// class _HistorysState extends State<Historys> {
//   // String scanBarcode = '';
//   // String barcodeScanRes = '';
//   // String datetime = "";
//   //
//   // @override
//   // void initState() {
//   //   super.initState();
//   // }
//   //
//   // CollectionReference qrCode = FirebaseFirestore.instance.collection("qrcode");
//   //
//   // Future<void> addUser() {
//   //   return qrCode
//   //       .add({
//   //     'code': barcodeScanRes,
//   //     'date': DateFormat("hh:mm a yyyy-MM-dd").format(DateTime.now())
//   //   })
//   //       .then((value) => print("User Added code"))
//   //       .catchError((error) => print("Failed to Add user code: $error"));
//   // }
//   //
//   // Future<void> scanBarcodeNormal() async {
//   //   try {
//   //     barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
//   //         '#ff6666', 'Cancel', true, ScanMode.BARCODE);
//   //     print(barcodeScanRes);
//   //   } on PlatformException {
//   //     barcodeScanRes = 'Failed to get platform version.';
//   //   }
//   //   if (!mounted) return;
//   //   setState(() {
//   //     scanBarcode = barcodeScanRes;
//   //     addUser();
//   //     print("object${barcodeScanRes}");
//   //   });
//   // }
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: AppColors.darkBlue,
//         title: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children:  const [
//             Text("QR Code",style: TextStyle(color: Colors.white),),
//           ],
//         ),
//       ),
//       body: History(),
//       // floatingActionButton: FloatingActionButton(
//       //   splashColor: Colors.transparent,
//       //   backgroundColor: AppColors.darkBlue,
//       //   child: Icon(Icons.qr_code,size: 30,),
//       //   onPressed: () {
//       //    scanBarcodeNormal();
//       //   },
//       // ),
//     );
//   }
// }
//
//
//
//
//
//
// class History extends StatefulWidget {
//   const History({Key? key}) : super(key: key);
//
//   @override
//   _HistoryState createState() => _HistoryState();
// }
//
// class _HistoryState extends State<History> {
//   final Stream<QuerySnapshot> qrCodeStream =
//   FirebaseFirestore.instance.collection("qrcode").snapshots();
//
//   CollectionReference qrCode =
//   FirebaseFirestore.instance.collection("qrcode");
//
//   Future<void> deleteUser(id) {
//     print("User Deleted $id");
//     return qrCode
//         .doc(id)
//         .delete()
//         .then((value) => print("User Deleted"))
//         .catchError((error) => print("Failed to Delete user: $error"));
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder<QuerySnapshot>(
//       stream: qrCodeStream,
//       builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
//         if (snapshot.hasError) {
//           print("Something went worng1");
//         }
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return const Center(child: CircularProgressIndicator());
//         }
//
//         final List storedocs = [];
//         snapshot.data!.docs.map((DocumentSnapshot document) {
//           Map a = document.data() as Map<String, dynamic>;
//           storedocs.add(a);
//           a['id'] = document.id;
//           print(document.id);
//           print(storedocs);
//         }).toList();
//
//         return Container(
//           margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
//           child: SingleChildScrollView(
//             scrollDirection: Axis.vertical,
//             child: RefreshIndicator(
//               onRefresh: () async {
//                 await Future.delayed(const Duration(seconds: 1));
//               },
//               child: Column(
//                 children: [
//                   for (var i = 0; i < storedocs.length; i++) ...[
//                     Padding(
//                       padding:  EdgeInsets.only(top: 1.5.h,right: 3.w,left: 3.w),
//                       child: Column(
//                         children: [
//                           Container(
//                             decoration: BoxDecoration(
//                                 color: AppColor.backgroundColor,
//                                 border: Border.all(width: 1),
//                               borderRadius: BorderRadius.circular(10)
//                             ),
//                             child: ListTile(
//                               title: Text(
//                                 storedocs[i]['code'],
//                                 style: const TextStyle(
//                                     fontSize: 18, fontWeight: FontWeight.bold),
//                               ),
//                               subtitle: Text(
//                                 storedocs[i]['date'],
//                                 style: const TextStyle(
//                                     fontSize: 18, fontWeight: FontWeight.bold),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     )
//                   ],
//                   SizedBox(height: 1.5.h,)
//                 ],
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
///sgfgdfgdgdfgdf