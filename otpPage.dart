// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lottie/lottie.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';
import 'package:resellify/dataStore/basic.dart';
import 'package:resellify/dataStore/handelLocalStorageData.dart';
import './login.dart';
import './dataStore/basic.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class VerifyOtpByEmail extends StatefulWidget {
  static String id = "";

  const VerifyOtpByEmail({Key? key}) : super(key: key);

  @override
  State<VerifyOtpByEmail> createState() => _VerifyOtpByEmailState();
}

class _VerifyOtpByEmailState extends State<VerifyOtpByEmail> {
  @override
  Widget build(BuildContext context) {
    final basicModel = Provider.of<BasicModel>(context);
    Map<String, dynamic> arguments =
        ModalRoute.of(context)!.settings.arguments as dynamic;

    print("otp page");
    print("user type");

    Future<dynamic> submitData(String pin_sub) async {
      print("login.verify");
      print(login.verify);
      print(pin_sub);
      http.Response result = await http.post(
          Uri.parse(
              "http://localhost/api/phpBackEnd/src/user.php?route=verify-otp"),
          body: jsonEncode({
            "email": arguments["email"],
            "otp": pin_sub,
            // "otp": int.parse(pin_sub),
          }),
          headers: {
            'Content-Type': 'application/json',
            "Accept": "application/json",
            "Access-Control_Allow_Origin": "*"
          });
      // Map<String, dynamic> responseMap = jsonDecode(jsonResponse);
      print(result.body);
      final data = jsonDecode(result.body);

      // await auth.signInWithCredential(credential);

      if (data["status"] == "failure") {
        print("failure");
        Fluttertoast.showToast(
            msg: data["message"],
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM_LEFT,
            timeInSecForIosWeb: 2,
            backgroundColor: Color.fromARGB(255, 235, 121, 106),
            textColor: Color.fromARGB(255, 255, 255, 255),
            webBgColor: "linear-gradient(to right, #f06449, #e62739)",
            fontSize: 13);
        return "";
      }

      print(data["data"]["data"]["token"]);
      setLocalData("token", data["data"]["data"]["token"]);

      print(data["data"]["data"]["id"]);
      print("===========================================");
      print(data["data"]["data"]["name"]);
      print(data["data"]["data"]["token"]);
      print(data["data"]["data"]["email"]);

      VerifyOtpByEmail.id = data["data"]["data"]["id"].toString();
      setLocalData("userId", data["data"]["data"]["id"].toString());

      basicModel.setTokenAndLoginFlag(data["data"]["data"]["id"],
          data["data"]["data"]["token"], true, data["data"]["data"]["email"]);

      print("==========================");
      print("now retrieve");

      Fluttertoast.showToast(
          msg: data["message"],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM_LEFT,
          timeInSecForIosWeb: 2,
          backgroundColor: Colors.blueAccent[200],
          textColor: const Color.fromARGB(255, 255, 255, 255),
          webBgColor: "linear-gradient(to right, #00b09b, #96c93d)",
          fontSize: 13);

      print(data["data"]["data"]["name"] != 'NULL' &&
          data["data"]["data"]["name"] != null);
      print("=====================================================");

      if (data["data"]["data"]["email"] == "resellify80@gmail.com") {
        Navigator.pushNamedAndRemoveUntil(
            context, '/validator', (route) => false);
        return "dfs";
      }

      if (data["data"]["data"]["name"] != 'NULL' &&
          data["data"]["data"]["name"] != 'null' &&
          data["data"]["data"]["name"] != null) {
        Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
        return "dfs";
      } else {
        Map<String, dynamic> userData = {
          "email": arguments["email"],
          "id": data["data"]["data"]["id"],
          "token": data["data"]["data"]["token"],
        };
        Navigator.pushNamedAndRemoveUntil(
            context, '/welcomepage', (route) => false,
            arguments: userData);
        return "dfs";
      }
    }

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
        body: ListView(
          children: [
            Container(
              color: Color(0xFFDAEAFD),
              alignment: Alignment.center,
              child: Column(
                children: [
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
                                  submitData(pin_sub);
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
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
