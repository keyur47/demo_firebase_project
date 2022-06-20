import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:demo_firebase_project/modules/controller/controller.dart';
import 'package:demo_firebase_project/modules/history/history.dart';
import 'package:demo_firebase_project/modules/homepage/homepage.dart';
import 'package:demo_firebase_project/utils/app_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);
  static const routeName = '/myhomepage_screen';

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Controller controller = Get.put(Controller());

  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    controller.pageController = PageController();
  }

  @override
  void dispose() {
    controller.pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: Text("Bottom Nav Bar")),
      body: SizedBox.expand(
        child: PageView(
          controller: controller.pageController,
          onPageChanged: (index) {
            setState(() => _currentIndex = index);
          },
          children: <Widget>[
            const Historys(),
            const HomePage(),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavyBar(
        backgroundColor:AppColors.darkBlue,
        selectedIndex: _currentIndex,
        onItemSelected: (index) {
          setState(() => _currentIndex = index);
          controller.pageController.jumpToPage(index);
        },
        items: <BottomNavyBarItem>[
          BottomNavyBarItem(
            title: const Text('History'),
            icon: const Icon(Icons.history),
            activeColor: AppColor.backgroundColor,
          ),
          BottomNavyBarItem(
            title: const Text('List'),
            icon: const Icon(Icons.list),
            activeColor: AppColor.backgroundColor,
          ),
        ],
      ),
    );
  }
}








































// import 'package:demo_firebase_project/modules/homepage/homepage.dart';
// import 'package:demo_firebase_project/modules/scan/scan.dart';
// import 'package:demo_firebase_project/utils/app_color.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:sizer/sizer.dart';
//
// import 'history/history.dart';
//
// class TabBarApp extends StatefulWidget {
//   // static const routeName = '/tabbar_screen';
//
//   @override
//   _TabBarAppState createState() => _TabBarAppState();
// }
//
// class _TabBarAppState extends State<TabBarApp> {
//   int currentTab = 0;
//
//   final List<Widget> screens = [Historys(),HomePage()];
//
//   final PageStorageBucket bucket = PageStorageBucket();
//   Widget currentScreen = Historys();
//
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         body: PageStorage(
//           bucket: bucket,
//           child: currentScreen,
//         ),
//         floatingActionButton: FloatingActionButton(
//           backgroundColor: AppColors.darkBlue,
//           child: const Icon(Icons.qr_code),
//           onPressed: () {
//             Get.to(Scan());
//           },
//         ),
//         floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
//         bottomNavigationBar: BottomAppBar(
//           color: AppColors.darkBlue,
//           shape: const CircularNotchedRectangle(),
//           notchMargin: 10,
//           child: Container(
//             height: 60,
//             child: Padding(
//               padding: EdgeInsets.only(left: 6.w,right: 6.w),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Row(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       MaterialButton(
//                         onPressed: () {
//                           setState(() {
//                             currentScreen = Historys();
//                             currentTab = 0;
//                           });
//                         },
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Icon(
//                               Icons.people_alt_rounded,
//                               color: currentTab == 0 ? AppColor.backgroundColor : AppColors.green,
//                             ),
//                             Text(
//                               "History",
//                               style: TextStyle(
//                                 color: currentTab == 0 ?AppColor.backgroundColor : AppColors.green,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                   Row(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       MaterialButton(
//                         onPressed: () {
//                           setState(() {
//                             currentScreen = HomePage();
//                             currentTab = 1;
//                           });
//                         },
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Icon(
//                               Icons.supervised_user_circle_sharp,
//                               color: currentTab == 1 ? AppColor.backgroundColor : AppColors.green,
//                             ),
//                             Text(
//                               "Details",
//                               style: TextStyle(
//                                 color: currentTab == 1 ?AppColor.backgroundColor : AppColors.green,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
//