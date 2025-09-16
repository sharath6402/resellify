import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resellify/dataStore/handelLocalStorageData.dart';
import "dart:async";

import 'dataStore/basic.dart';
import 'home.dart';
import 'login.dart';
import 'package:http/http.dart' as http;

class SplashScreen extends StatefulWidget {
  // const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool isInitialRender = true;
  void authMe(context) async {
    final basicModel = Provider.of<BasicModel>(context);
    try {
      dynamic token = await getLocalData();
      print(token);

      if (token == null || token == "") {
        return;
      }
      http.Response result = await http.post(
          Uri.parse(
              "http://localhost/api/phpBackEnd/src/user.php?route=auth-me"),
          body: jsonEncode({
            "token": token
            // "eyJhbGdvIjoiSFMyNTYiLCJ0eXBlIjoiSFdUIiwiZXhwaXJlIjoxNjg5OTYyNDk3fQ==.eyJpZCI6MTB9.NTE4YjExYTE4ZmNhOWM2NDk3YjNhMDk2ZWVjNDA3OGU4MzZhZmFhYTU0ZGI2NjRiNGNlNmY2YTI5ZWMwM2MyNw=="

            // "otp": int.parse(pin_sub),
          }),
          headers: {
            'Content-Type': 'application/json',
            "Accept": "application/json",
            "Access-Control_Allow_Origin": "*"
          });

      print("result===>");
      print(result.body);
      final data = jsonDecode(result.body);
      // nt userId, String name, String phoneNumber,
      // String profileImage, String address, String userType, String email,
      // dynamic token, bool isLogIn)
      basicModel.setUserDetails(
          data["data"]["data"]["id"],
          data["data"]["data"]["name"],
          data["data"]["data"]["phoneNumber"],
          data["data"]["data"]["profileImage"],
          data["data"]["data"]["address"],
          data["data"]["data"]["email"],
          true);
      print(data["data"]["data"]["email"]);
      print(basicModel.getUserDetails());
      isInitialRender = false;

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => MyApp1()),
      );
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    BasicModel basicModel = Provider.of<BasicModel>(context, listen: false);
    bool isLogIn = basicModel.isUserLogedIn();

    Timer(const Duration(milliseconds: 1800),
        (() => {navigateToLoginPage(isLogIn)}));
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (isInitialRender) {
      authMe(context);
    }
  }

  void navigateToLoginPage(isLogIn) {
    // final basicModel = Provider.of<BasicModel>(context);
    if (isLogIn) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => MyApp1()),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => login()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // Timer(Duration(seconds: 100800),navigateToLoginPage);
    AssetImage logoAsset = AssetImage("images/logo.jpeg");
    Image image = Image(
      image: logoAsset,
    );

    // print(basicModel.isLogIn);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // theme: new ThemeData(scaffoldBackgroundColor: cont Color(0xFFDAEAFD)),
      home: Scaffold(
        backgroundColor: Color(0xFFDAEAFD),
        body: Center(
          child: Container(
            height: 400,
            child: image,
          ),
        ),
      ),
    );
  }
}

class splash2 extends StatefulWidget {
  const splash2({Key? key}) : super(key: key);

  @override
  State<splash2> createState() => _splash2();
}

class _splash2 extends State<splash2> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(milliseconds: 1800), navigateToLoginPage);
  }

  void navigateToLoginPage() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => MyApp1()),
    );
  }

  @override
  Widget build(BuildContext context) {
    AssetImage resellify1Assest = AssetImage("images/resellify.jpeg");
    Image image3 = Image(
      image: resellify1Assest,
    );
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          backgroundColor: Color(0xFFDAEAFD),
          body: Center(
            child: image3,
          ),
        ));
  }
}
