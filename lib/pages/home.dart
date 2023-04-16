import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:testcapstone/components/carouSlider.dart';
import 'package:testcapstone/components/flipcard.dart';
import 'package:testcapstone/components/login.dart';

const imglogo12 = "assets/boschsymbol.svg";
const imgTabbar = "assets/supergraphic.svg";
const imgLogout = "assets/logout.svg";

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  Future<void> yesCancelDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
              title: Text(
                "Are you sure?".toUpperCase(),
                style: TextStyle(
                    fontSize: 20.sp,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
              content: const Text("Do you want to log out?"),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(false);
                    },
                    child: const Text("No")),
                TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginPage()),
                      );
                    },
                    child: const Text("Yes"))
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        yesCancelDialog(context);
        return Future.value(false);
      },
      child: Scaffold(
        appBar: AppBar(
          title: SvgPicture.asset(
            imglogo12,
            height: 70.h,
            width: 70.w,
            fit: BoxFit.scaleDown,
          ),
          backgroundColor: Colors.white,
          centerTitle: true,
          actions: <Widget>[
            IconButton(
              hoverColor: Colors.black,
              tooltip: "Log Out",
              onPressed: () {
                yesCancelDialog(context);
              },
              icon: SvgPicture.asset(
                imgLogout,
                height: 24.h,
                color: Colors.black,
              ),
            )
          ],
          bottom: PreferredSize(
              preferredSize: Size.fromHeight(10.h),
              child: SizedBox(
                height: 10.h,
                width: double.infinity,
                child: SvgPicture.asset(
                  imgTabbar,
                  fit: BoxFit.cover,
                ),
              )),
        ),
        // drawer: const NavigationDrawer(),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              const CarouSlider(),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 50, 0, 0).r,
                child: FlipCard(
                    front: Image.asset("assets/ecu1.png"),
                    back: Image.asset("assets/ecu2.png")),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
