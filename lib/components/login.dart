import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:testcapstone/components/bottomnavbar.dart';

import '../NetworkHandler.dart';

const imgsupergraphic = "assets/supergraphic.svg";
const imglogo = "assets/boschsymbol.svg";
const imglogo1 = "assets/hcmutelogo.png";

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _showPass = false;
  TextEditingController _userController = TextEditingController();
  TextEditingController _passController = TextEditingController();
  String? errorText;
  bool validate = false;
  bool circular = false;
  final storage = new FlutterSecureStorage();
  NetworkHandler networkHandler = NetworkHandler();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(0.0).r,
              child: SizedBox(
                width: double.infinity,
                height: 40.h,
                child: SvgPicture.asset(
                  imgsupergraphic,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 100, 30, 100).r,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SvgPicture.asset(
                    imglogo,
                    width: 150.h,
                  ),
                  Image.asset(
                    imglogo1,
                    width: 50.h,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(30, 0, 30, 0).r,
              child: TextField(
                style: TextStyle(fontSize: 15.sp, color: Colors.black),
                controller: _userController,
                decoration: InputDecoration(
                    labelText: "USERNAME",
                    errorText: validate ? null : errorText,
                    labelStyle: TextStyle(
                        color: const Color(0xff888888), fontSize: 15.sp)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 40).r,
              child: Stack(
                alignment: AlignmentDirectional.centerEnd,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(30, 0, 30, 0).r,
                    child: TextField(
                      style: TextStyle(fontSize: 15.sp, color: Colors.black),
                      controller: _passController,
                      obscureText: !_showPass,
                      decoration: InputDecoration(
                          labelText: "PASSWORD",
                          errorText: validate ? null : errorText,
                          labelStyle: TextStyle(
                              color: const Color(0xff888888), fontSize: 15.sp)),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(30, 0, 30, 0).r,
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          _showPass = !_showPass;
                        });
                      },
                      child: Text(
                        _showPass ? "HIDE" : "SHOW",
                        style: TextStyle(
                            color: Colors.blue,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  )
                ],
              ),
            ),
            // Padding(
            //   padding: const EdgeInsets.fromLTRB(30, 50, 30, 0).r,
            //   child: SizedBox(
            //       width: double.infinity,
            //       height: 40.r,
            //       child: ElevatedButton(
            //           style: ElevatedButton.styleFrom(
            //               backgroundColor: Colors.blue,
            //               foregroundColor: Colors.white,
            //               shape: RoundedRectangleBorder(
            //                   borderRadius:
            //                       BorderRadius.all(Radius.circular(12.r)))),
            //           onPressed: onSigninClicked,
            //           child: circular
            //               ? const CircularProgressIndicator(color: Colors.white,)
            //               : const Text("SIGN IN"))),
            // ),
            InkWell(
                  onTap: () async {
                    setState(() {
                      circular = true;
                    });

                    //Login Logic start here
                    Map<String, String> data = {
                      "username": _userController.text,
                      "password": _passController.text,
                    };
                    var response =
                        await networkHandler.post("/user/login", data);

                    if (response.statusCode == 200 ||
                        response.statusCode == 201) {
                      Map<String, dynamic> output = json.decode(response.body);
                      print(output["token"]);
                      await storage.write(key: "token", value: output["token"]);
                      setState(() {
                        validate = true;
                        circular = false;
                      });
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MainPage(),
                          ),
                          (route) => false);
                    } else {
                      String output = json.decode(response.body);
                      setState(() {
                        validate = false;
                        errorText = "Invalid Username or Password";
                        circular = false;
                      });
                    }

                    // login logic End here
                  },
                  child: Container(
                    width: 150.w,
                    height: 50.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10).r,
                      color: Colors.blue.shade200,
                    ),
                    child: Center(
                      child: circular
                          ? CircularProgressIndicator(color: Colors.white,)
                          : Text(
                              "Sign In",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18.sp,
                                fontWeight: FontWeight.bold,
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

  // checkUser() async{
  //   if(_userController.text.length==0){
  //     setState(() {
  //       circular=false;
  //       validate=false;
  //       errorText="Invalid Username";
  //     });
  //   }
  //   else{
  //     var response = await networHandler.get("/user/checkusername/${_userController.text}");
  //     if(response['Status']){
  //     setState(() {
  //       validate=false;
  //       errorText="Username already";
  //     });
  //     }
  //     else{
  //     setState(() {
  //       validate=true;

  //     });
  //     }
  //   }
  // }

//   void onSigninClicked() async {
//     setState(() {
//       circular = true;
//     });

//     //Login Logic start here
//     Map<String, String> data = {
//       "username": _userController.text,
//       "password": _passController.text,
//     };
//     var response = await networkHandler.post("/user/login", data);

//     if (response.statusCode == 200 || response.statusCode == 201) {
//       Map<String, dynamic> output = json.decode(response.body);
//       print(output["token"]);
//       await storage.write(key: "token", value: output["token"]);
//       setState(() {
//         validate = true;
//         circular = false;
//       });
//       Navigator.pushAndRemoveUntil(
//           context,
//           MaterialPageRoute(
//             builder: (context) => const MainPage(),
//           ),
//           (route) => false);
//     } else {
//       String output = json.decode(response.body);
//       setState(() {
//         validate = false;
//         errorText = output;
//         circular = false;
//       });
//     }
//   }
 }
