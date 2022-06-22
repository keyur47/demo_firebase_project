import 'package:demo_firebase_project/utils/my_behavior.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'modules/addqr/addqrdatascreen.dart';
import 'modules/addqr/scan_qr_screen.dart';
import 'modules/home.dart';
import 'modules/history/history.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      builder: (context, child) {
        return ScrollConfiguration(
          behavior: MyBehavior(),
          child: child!,
        );
      },
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: HomePage(),
      getPages: [
        GetPage(
          name: '/HomePage',
          page: () => HomePage(),
          transition: Transition.fadeIn,
        ),
        GetPage(
          name: '/ScanQrCodeScreen',
          page: () => const ScanQrCodeScreen(),
          transition: Transition.fadeIn,
        ),
        GetPage(
          name: '/History',
          page: () => History(),
          transition: Transition.fadeIn,
        ),
        GetPage(
          name: '/AddQrScreen',
          page: () => AddQrDataScreen(),
          transition: Transition.fadeIn,
        ),
      ],
    );
  }
}


















// import 'package:demo_firebase_project/utils/app_color.dart';
// import 'package:demo_firebase_project/utils/my_behavior.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get_navigation/src/root/get_material_app.dart';
// import 'package:sizer/sizer.dart';
// import 'modules/home.dart';
//
// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//   runApp(MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   MyApp({Key? key}) : super(key: key);
//
//   final Future<FirebaseApp> _initialization = Firebase.initializeApp();
//
//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder(
//       future: _initialization,
//       builder: (context, snapshot) {
//         if (snapshot.hasError) {
//           print("Something went Wrong");
//         }
//         if (snapshot.connectionState == ConnectionState.done){
//           return   Sizer(
//             builder: (context, orientation, deviceType){
//               return GetMaterialApp(
//                 theme: ThemeData(
//                   primarySwatch: Colors.blue,
//                 ),
//                 debugShowCheckedModeBanner: false,
//                 builder: (context, child) {
//                   return ScrollConfiguration(
//                     behavior: MyBehavior(),
//                     child: child!,
//                   );
//                 },
//                 home:  HomePage(),
//               );
//             });
//         }
//         return const CircularProgressIndicator(color: AppColors.darkBlue,);
//       },
//     );
//   }
// }

///hfhfg






























// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get_navigation/src/root/get_material_app.dart';
// import 'package:profile_data_add_firebase/addqrdatascreen.dart';
//
// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   // await Firebase.initializeApp();
//
//   runApp(const MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);
//
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return GetMaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: const ImageUploads(),
//     );
//   }
// }
