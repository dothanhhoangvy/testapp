import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:testcapstone/components/logout.dart';
import 'package:testcapstone/location/current_location.dart';

const imgMenu = "assets/list-view-mobile.svg";
const imgTabbar = "assets/supergraphic.svg";
const imgLogout = "assets/logout.svg";

class LocationPage extends StatelessWidget {
  const LocationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "LOCATION",
          style: TextStyle(
              fontSize: 18.sp,
              color: Colors.black,
              fontWeight: FontWeight.bold),
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
      body: const CurrentLocation(),
    );
  }
}
