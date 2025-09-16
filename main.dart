// ignore_for_file: prefer_const_constructors

import "dart:js";

import 'package:flutter/material.dart';
import "package:provider/provider.dart";
import "package:resellify/SelectedCategoryDetailsForm.dart";
import 'package:resellify/ImagePickerApp.dart';
import "package:resellify/validator_form.dart";

import "./UserDetail.dart";
import "./categorydisp.dart";
import "./chathist.dart";

import "./formCategory.dart";
// import "formData.dart";
import "./home.dart";
import "./product_detail.dart";
import "./search.dart";
import "./login.dart";
import "./pinputdemo.dart";
import "./search_results.dart";
import "./shoppingcart.dart";
import "./welcome.dart";
// ignore: unused_import
import "Datafetch.dart";
import "chat.dart";
import "dataStore/basic.dart";

import "./Category.dart";

import "./splashscreen.dart";
import "location.dart";
import "myProduct.dart";
import "otpPage.dart";
import "validator.dart";

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyApp();
}

class _MyApp extends State<MyApp> {
  // const _MyAppState({super.key});

  void initState() {
    super.initState();
    print("===========refresh=================");
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => BasicModel(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Builder(
          builder: (BuildContext context) {
            // return SplashScreen();
            return MyApp1();
          },
        ),
        routes: {
          '/ImagePickerApp': (context) => ImagePickerApp(),
          '/welcomepage': (context) => welcome(),
          '/splash2page': (context) => splash2(),
          '/home': (context) => MyApp1(),
          '/details': (context) => product(),
          '/selling': (context) => CategoryCard(),
          '/categoryForm': (context) => FormCategory(),
          '/newChat': (context) => DataFetchingScreen(),
          '/user': (context) => userDetails(),
          "/search": (context) => search(),
          "/result": (context) => result(),
          "/cat": (context) => categorydisp(),
          "/cart": (context) => myCarts(),
          "/pin": (context) => MyVerify(),
          "/VerifyOtpByEmail": (context) => VerifyOtpByEmail(),
          "/lo": (context) => login(),
          "/selectedCategoryDetailsForm": (context) =>
              SelectedCategoryDetailsForm(),
          "/LocationForm": (context) => LocationForm(),
          "/MyProduct": (context) => myproduct(),
          "/validator": (context) => validator(),
          "/myValidation": (context) => const Vform(),
        },
      ),
    );
  }
}
