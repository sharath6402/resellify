// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:resellify/dataStore/handelLocalStorageData.dart';
import 'dataStore/basic.dart';
import 'login.dart';
import 'package:http/http.dart' as http;

class welcome extends StatefulWidget {
  const welcome({Key? key}) : super(key: key);

  @override
  State<welcome> createState() => _welcome();
}

class _welcome extends State<welcome> {
  TextEditingController fname = TextEditingController();
  TextEditingController lname = TextEditingController();
  TextEditingController address = TextEditingController();
  var phone1 = login.phonenumber;

  // final CollectionReference _usercart =
  //     FirebaseFirestore.instance.collection('usercart');

  @override
  Widget build(BuildContext context) {
    AssetImage reselAssest = AssetImage("images/resellify2.jpeg");
    Map<String, dynamic> arguments =
        ModalRoute.of(context)!.settings.arguments as dynamic;
    Image image2 = Image(
      image: reselAssest,
    );

    final basicModel = Provider.of<BasicModel>(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Color(0xFFDAEAFD),
        body: ListView(
          children: [
            Align(
              alignment: Alignment.topRight,
              child: TextButton(
                onPressed: () {
                  print(phone1);
                  // Perform button action
                },
                style: ButtonStyle(
                    // backgroundColor: MaterialStateProperty.all(Colors.grey),
                    ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'Skip',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: image2,
            ),
            // Spacer(),
            SizedBox(
              height: 40,
            ),
            Container(
                color: Color(0xFFA9D6FF),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 10, top: 10),
                      child: Align(
                          alignment: Alignment.center,
                          child: Container(
                            height: 50,
                            child: Lottie.asset('images/welcome.json'),
                          )),
                    ),

                    // Spacer(),
                    Container(
                      padding: EdgeInsets.only(
                          top: 50, bottom: 20, left: 10, right: 10),
                      color: Color(0xFFA9D6FF),
                      child: TextField(
                        controller: fname,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'FIRST NAME',
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(
                          top: 20, bottom: 20, left: 10, right: 10),
                      color: Color(0xFFA9D6FF),
                      child: TextField(
                        controller: lname,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'LAST NAME',
                        ),
                      ),
                    ),

                    Container(
                      padding: EdgeInsets.only(
                          top: 20, bottom: 20, left: 10, right: 10),
                      color: Color(0xFFA9D6FF),
                      child: TextField(
                        controller: address,
                        maxLines: 5,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'ADDRESS',
                        ),
                      ),
                    ),

                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.only(top: 20, left: 10, right: 10),
                      color: Color(0xFFA9D6FF),
                      child: OutlinedButton(
                        onPressed: () async {
                          // addUserDetails(
                          //     address.text, fname.text, lname.text, phone1);
                          var addressData = address.text;
                          print(address.text);
                          try {
                            http.Response result = await http.post(
                                Uri.parse(
                                    "http://localhost/api/phpBackEnd/src/user.php?route=save-user-data"),
                                body: jsonEncode({
                                  "email": arguments["email"],
                                  "id": arguments["id"],
                                  "token": arguments["token"],
                                  "name": "${fname.text} ${lname.text}",
                                  "address": "$addressData"
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

                            Navigator.pushNamedAndRemoveUntil(
                                context, '/home', (rute) => false);

                            // await auth.signInWithCredential(credential);
                            // print();
                            // print("dfgdfgdfgfgfgfg=========");

                            if (data["status"] == "failure") {
                              print("failure");
                              Fluttertoast.showToast(
                                  msg: data["message"],
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM_LEFT,
                                  timeInSecForIosWeb: 2,
                                  backgroundColor:
                                      Color.fromARGB(255, 235, 121, 106),
                                  textColor: Color.fromARGB(255, 255, 255, 255),
                                  webBgColor:
                                      "linear-gradient(to right, #f06449, #e62739)",
                                  fontSize: 13);
                              return;
                            }
                            // print("dfgdfgdfgfgfgfg=========");
                            dynamic name = "${fname.text} ${lname.text}";
                            // print("dfgdfgdfgfgfgfg=========");
                            dynamic address = data["data"]["data"]["address"];
                            basicModel.setUserDetails(
                                arguments["id"],
                                name,
                                null,
                                address,
                                "User",
                                arguments["email"],
                                true);
                            Fluttertoast.showToast(
                                msg: data["message"],
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM_LEFT,
                                timeInSecForIosWeb: 2,
                                backgroundColor: Colors.blueAccent[200],
                                textColor:
                                    const Color.fromARGB(255, 255, 255, 255),
                                webBgColor:
                                    "linear-gradient(to right, #00b09b, #96c93d)",
                                fontSize: 13);
                            return;
                          } on Exception catch (_) {
                            print("exception");
                            Navigator.pushNamedAndRemoveUntil(
                                context, '/home', (rute) => false);
                          }

                          Navigator.pushNamedAndRemoveUntil(
                              context, '/home', (rute) => false);
                        },
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(width: 1, color: Color(0xFF0A8575)),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(20),
                          child: Text("CONTINUE"),
                        ),
                      ),
                    ),
                  ],
                ))
          ],
        ),
      ),
    );
  }

  Future addUserDetails(
      String address1, String fname1, String lname1, String phone2) async {
    await FirebaseFirestore.instance.collection("user_details").add({
      "Address": address1,
      "First_Name": fname1,
      "Last_Name": lname1,
      "Phone_number": phone2
    });
    // await FirebaseFirestore.instance.collection("user_cart").add({
    //   "user": fname1,
    //   "product1": "",
    //   "product2": "",
    //   "product3": "",
    //   "product4": "",
    //   "product5": "",
    // });
  }

  @override
  void dispose() {
    fname.dispose();
    lname.dispose();
    address.dispose();
    super.dispose();
  }
}
