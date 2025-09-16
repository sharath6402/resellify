// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lottie/lottie.dart';
import 'package:pinput/pinput.dart';
import './login.dart';

class MyVerify extends StatefulWidget {
  const MyVerify({Key? key}) : super(key: key);

  @override
  State<MyVerify> createState() => _MyVerifyState();
}

class _MyVerifyState extends State<MyVerify> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: TextStyle(
          fontSize: 20, color: Color(0XFF1E3C57), fontWeight: FontWeight.w600),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.deepPurple),
        borderRadius: BorderRadius.circular(20),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: Color.fromRGBO(114, 178, 238, 1)),
      borderRadius: BorderRadius.circular(8),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration?.copyWith(
        color: Color.fromRGBO(234, 239, 243, 1),
      ),
    );
    AssetImage resellAssest = AssetImage("images/resellify12.jpeg");
    var pin_sub = "";
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            body: Container(
                color: Color(0xFFDAEAFD),
                alignment: Alignment.center,
                child: Column(children: [
                  Padding(
                      padding: EdgeInsets.only(top: 10, left: 10),
                      child: Container(
                        height: 230,
                        child: Align(
                          alignment: Alignment.topCenter,
                          child: Lottie.asset("images/password.json"),
                        ),
                      )),
                  Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: EdgeInsets.only(top: 20),
                      child: Text(
                        "OTP is sent",
                        style:
                            TextStyle(fontSize: 20, color: Color(0XFF1E3C57)),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 30),
                    child: Container(
                      // height: 480,
                      width: double.infinity,

                      child: Column(
                        children: [
                          Padding(
                              padding: EdgeInsets.only(top: 30, left: 20),
                              child: Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  "Login to get started",
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Color(0XFF140A8C),
                                  ),
                                ),
                              )),
                          Padding(
                            padding: EdgeInsets.only(top: 100),
                            child: Pinput(
                              length: 6,
                              defaultPinTheme: defaultPinTheme,
                              focusedPinTheme: focusedPinTheme,
                              submittedPinTheme: submittedPinTheme,
                              showCursor: true,
                              onCompleted: (pin) {
                                pin_sub = pin;
                                print(pin_sub);
                              },
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 30, right: 20),
                            child: TextButton(
                              onPressed: () {
                                Navigator.pushNamed(context, '/lo');
                              },
                              child: Align(
                                alignment: Alignment.topRight,
                                child: Text(
                                  "Try Other Way",
                                  style: TextStyle(fontSize: 20),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            width: double.infinity,
                            padding: EdgeInsets.only(
                                top: 80, bottom: 30, left: 20, right: 20),
                            color: Color(0xFFA9D6FF),
                            child: OutlinedButton(
                              onPressed: () async {
                                try {
                                  PhoneAuthCredential credential =
                                      PhoneAuthProvider.credential(
                                          verificationId: login.verify,
                                          smsCode: pin_sub);
                                  await auth.signInWithCredential(credential);
                                  Fluttertoast.showToast(
                                      msg: "correct OTP",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.BOTTOM_LEFT,
                                      timeInSecForIosWeb: 2,
                                      backgroundColor: Colors.blueAccent[200],
                                      textColor: Colors.black,
                                      fontSize: 13);
                                  Navigator.pushNamedAndRemoveUntil(context,
                                      '/welcomepage', (route) => false);
                                } catch (e) {
                                  Fluttertoast.showToast(
                                      msg: "wrong OTP",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.BOTTOM_LEFT,
                                      timeInSecForIosWeb: 2,
                                      backgroundColor: Colors.blueAccent[200],
                                      textColor: Colors.black,
                                      fontSize: 13);
                                }
                              },
                              style: OutlinedButton.styleFrom(
                                side: BorderSide(
                                    width: 1, color: Color(0xFF0A8575)),
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(20),
                                child: Text("CONTINUE"),
                              ),
                            ),
                          ),
                        ],
                      ),
                      decoration: BoxDecoration(
                        color: Color(0XFFA9D6FF),
                        // border: Border.all(
                        //   width: 1,
                        // ),
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  )
                ]))));
  }
}
