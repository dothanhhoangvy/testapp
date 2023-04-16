import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:testcapstone/pages/dashboard.dart';
import 'package:testcapstone/pages/home.dart';
import 'package:testcapstone/pages/location.dart';
import 'package:testcapstone/pages/update.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});
  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  // StreamSubscription<ReceivedAction> notificationsActionStreamSubscription;
  @override
  void initState() {
    super.initState();

    AwesomeNotifications().isNotificationAllowed().then(
      (isAllowed) {
        if (!isAllowed) {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Allow Notifications'),
              content:
                  const Text('Our app would like to send you notifications'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Don\'t Allow',
                    style: TextStyle(color: Colors.grey, fontSize: 18.sp),
                  ),
                ),
                TextButton(
                  onPressed: () => AwesomeNotifications()
                      .requestPermissionToSendNotifications()
                      .then((_) => Navigator.pop(context)),
                  child: Text(
                    'Allow',
                    style: TextStyle(
                      color: Colors.teal,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          );
        }
      },
    );
  }

  int _currentIndex = 0;
  final List tabss = [
    const HomePage(),
    const LocationPage(),
    const DashboardPage(),
    const UpdatePage()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: tabss[_currentIndex],
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: GNav(
          backgroundColor: Colors.black,
          hoverColor: const Color.fromARGB(255, 255, 255, 255),
          tabBorderRadius: 10.w,
          tabActiveBorder: Border.all(color: Colors.white, width: 1.w),
          color: Colors.white,
          activeColor: Colors.white,
          tabBackgroundColor: const Color.fromARGB(255, 80, 80, 80),
          gap: 8,
          padding: const EdgeInsets.all(24).r,
          selectedIndex: _currentIndex,
          onTabChange: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          tabs: const [
            GButton(
              icon: Icons.home_outlined,
              text: "Home",
            ),
            GButton(
              icon: Icons.location_on_outlined,
              text: "Location",
            ),
            GButton(
              icon: Icons.speed_outlined,
              text: "Dashboard",
            ),
            GButton(
              icon: Icons.autorenew_outlined,
              text: "Update",
            ),
          ],
        ),
      ),
    );
  }
}
