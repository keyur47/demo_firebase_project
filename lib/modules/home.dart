import 'package:demo_firebase_project/modules/controller/controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'addqr/addqrdatascreen.dart';
import 'history/history.dart';

class HomePage extends StatelessWidget {
  final Controller _addQrController = Get.put(Controller());

  static const routeName = '/HomePage';

  HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('QRCODE SCAN'),
            GestureDetector(onTap: () {
              _addQrController.scanQR();
            },
                child: Icon(Icons.camera_alt))
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: ()async{
          _addQrController.allQRData();
          Get.toNamed(History.routeName);
        },
        child: Icon(Icons.history),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 170,
              child: ElevatedButton(
                onPressed: () async {
                  _addQrController.isLoader.value
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : _addQrController.allData();
                  Get.to(AddQrDataScreen(
                    title: 'ADD QR',
                  ));
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'ADD QR',
                      style: TextStyle(fontSize: 23),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Icon(
                      Icons.qr_code,
                    )
                  ],
                ),
                style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                      side: const BorderSide(color: Colors.black),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:demo_firebase_project/modules/controller/controller.dart';
// import 'package:demo_firebase_project/modules/history/history.dart';
// import 'package:demo_firebase_project/modules/homepage/addqrdatascreen.dart';
// import 'package:demo_firebase_project/utils/app_color.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
// import 'package:get/get.dart';
// import 'package:sizer/sizer.dart';
// import 'package:intl/intl.dart';
//
// class MyHomePage extends StatefulWidget {
//    MyHomePage({Key? key}) : super(key: key);
//
//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }
//
// class _MyHomePageState extends State<MyHomePage> {
//
//
//   Controller controller = Get.put(Controller());
//
//   // String scanBarcode = '';
//   // String barcodeScanRes = '';
//   // String datetime = "";
//   // // CollectionReference qrCode = FirebaseFirestore.instance.collection("qrcode");
//   // // Future<void> addUser() {
//   // //   return qrCode
//   // //       .add({
//   // //     'code': barcodeScanRes,
//   // //     'date': DateFormat("hh:mm a yyyy-MM-dd").format(DateTime.now())
//   // //   })
//   // //       .then((value) => print("User Added code"))
//   // //       .catchError((error) => print("Failed to Add user code: $error"));
//   // // }
//   // //
//   // // Future<void> scanBarcodeNormal() async {
//   // //   try {
//   // //     barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
//   // //         '#ff6666', 'Cancel', true, ScanMode.BARCODE);
//   // //     print(barcodeScanRes);
//   // //   } on PlatformException {
//   // //     barcodeScanRes = 'Failed to get platform version.';
//   // //   }
//   // //   if (!mounted) return;
//   // //   setState(() {
//   // //     scanBarcode = barcodeScanRes;
//   // //     addUser();
//   // //     print("object${barcodeScanRes}");
//   // //   });
//   // // }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColor.backgroundColor,
//       appBar: AppBar(
//         title: Text("Demo App"),
//         backgroundColor: AppColors.darkBlue,
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             item(text: "Scan Me",icon: Icons.qr_code,onTap: (){controller.scanBarcodeNormal();}),
//             item(text: "History",icon: Icons.history,onTap: (){Get.to(Historyscreen());}),
//             item(text: "Details",icon: Icons.person,onTap: (){Get.to(AddQrScreen());}),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget item({required String text,required IconData icon,required GestureTapCallback onTap}) {
//     return Column(
//       children: [
//         GestureDetector(
//           onTap: onTap,
//           child: Container(
//             height: 6.h,
//             width: 42.w,
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(5.w),
//             color: AppColors.darkBlue,
//             ),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Text(text,style: TextStyle(fontSize: 22,color: Colors.white,fontWeight: FontWeight.w500),),
//                 SizedBox(width: 2.w,),
//                 Icon(icon,color: Colors.white,)
//               ],
//             ),
//           ),
//         ),
//         SizedBox(height: 2.h,)
//       ],
//     );
//   }
// }
// //padding: EdgeInsets.only(left: 3.w, right: 3.w, top: 0.5.h, bottom: 0.5.h),
//
//
//

///fwefwefwef

// import 'package:demo_firebase_project/modules/controller/controller.dart';
// import 'package:demo_firebase_project/modules/homepage/addqrdatascreen.dart';
// import 'package:demo_firebase_project/modules/history/history.dart';
// import 'package:demo_firebase_project/utils/app_color.dart';
// import 'package:bottom_navy_bar/bottom_navy_bar.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// class MyHomePage extends StatefulWidget {
//   const MyHomePage({Key? key}) : super(key: key);
//   static const routeName = '/myhomepage_screen';
//
//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }
//
// class _MyHomePageState extends State<MyHomePage> {
//   Controller controller = Get.put(Controller());
//
//   int _currentIndex = 0;
//
//   @override
//   void initState() {
//     super.initState();
//     controller.pageController = PageController();
//   }
//
//   @override
//   void dispose() {
//     controller.pageController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SizedBox.expand(
//         child: PageView(
//           controller: controller.pageController,
//           onPageChanged: (index) {
//             setState(() => _currentIndex = index);
//           },
//           children: <Widget>[
//             const Historys(),
//             const HomePage(),
//           ],
//         ),
//       ),
//       bottomNavigationBar: BottomNavyBar(
//         backgroundColor:AppColors.darkBlue,
//         selectedIndex: _currentIndex,
//         onItemSelected: (index) {
//           setState(() => _currentIndex = index);
//           controller.pageController.jumpToPage(index);
//         },
//         items: <BottomNavyBarItem>[
//           BottomNavyBarItem(
//             title: const Text('History'),
//             icon: const Icon(Icons.history),
//             activeColor: AppColor.backgroundColor,
//           ),
//           BottomNavyBarItem(
//             title: const Text('List'),
//             icon: const Icon(Icons.list),
//             activeColor: AppColor.backgroundColor,
//           ),
//         ],
//       ),
//     );
//   }
// }
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
// // import 'package:demo_firebase_project/modules/homepage/addqrdatascreen.dart';
// // import 'package:demo_firebase_project/modules/scan/scan.dart';
// // import 'package:demo_firebase_project/utils/app_color.dart';
// // import 'package:flutter/material.dart';
// // import 'package:get/get.dart';
// // import 'package:sizer/sizer.dart';
// //
// // import 'history/history.dart';
// //
// // class TabBarApp extends StatefulWidget {
// //   // static const routeName = '/tabbar_screen';
// //
// //   @override
// //   _TabBarAppState createState() => _TabBarAppState();
// // }
// //
// // class _TabBarAppState extends State<TabBarApp> {
// //   int currentTab = 0;
// //
// //   final List<Widget> screens = [Historys(),HomePage()];
// //
// //   final PageStorageBucket bucket = PageStorageBucket();
// //   Widget currentScreen = Historys();
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return SafeArea(
// //       child: Scaffold(
// //         body: PageStorage(
// //           bucket: bucket,
// //           child: currentScreen,
// //         ),
// //         floatingActionButton: FloatingActionButton(
// //           backgroundColor: AppColors.darkBlue,
// //           child: const Icon(Icons.qr_code),
// //           onPressed: () {
// //             Get.to(Scan());
// //           },
// //         ),
// //         floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
// //         bottomNavigationBar: BottomAppBar(
// //           color: AppColors.darkBlue,
// //           shape: const CircularNotchedRectangle(),
// //           notchMargin: 10,
// //           child: Container(
// //             height: 60,
// //             child: Padding(
// //               padding: EdgeInsets.only(left: 6.w,right: 6.w),
// //               child: Row(
// //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //                 children: [
// //                   Row(
// //                     crossAxisAlignment: CrossAxisAlignment.start,
// //                     children: [
// //                       MaterialButton(
// //                         onPressed: () {
// //                           setState(() {
// //                             currentScreen = Historys();
// //                             currentTab = 0;
// //                           });
// //                         },
// //                         child: Column(
// //                           mainAxisAlignment: MainAxisAlignment.center,
// //                           children: [
// //                             Icon(
// //                               Icons.people_alt_rounded,
// //                               color: currentTab == 0 ? AppColor.backgroundColor : AppColors.green,
// //                             ),
// //                             Text(
// //                               "History",
// //                               style: TextStyle(
// //                                 color: currentTab == 0 ?AppColor.backgroundColor : AppColors.green,
// //                               ),
// //                             ),
// //                           ],
// //                         ),
// //                       ),
// //                     ],
// //                   ),
// //                   Row(
// //                     crossAxisAlignment: CrossAxisAlignment.start,
// //                     children: [
// //                       MaterialButton(
// //                         onPressed: () {
// //                           setState(() {
// //                             currentScreen = HomePage();
// //                             currentTab = 1;
// //                           });
// //                         },
// //                         child: Column(
// //                           mainAxisAlignment: MainAxisAlignment.center,
// //                           children: [
// //                             Icon(
// //                               Icons.supervised_user_circle_sharp,
// //                               color: currentTab == 1 ? AppColor.backgroundColor : AppColors.green,
// //                             ),
// //                             Text(
// //                               "Details",
// //                               style: TextStyle(
// //                                 color: currentTab == 1 ?AppColor.backgroundColor : AppColors.green,
// //                               ),
// //                             ),
// //                           ],
// //                         ),
// //                       ),
// //                     ],
// //                   ),
// //                 ],
// //               ),
// //             ),
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// // }
// //
