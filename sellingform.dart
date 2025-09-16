import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lottie/lottie.dart';

class shoppingcartp extends StatefulWidget {
  dynamic productId = "";
  shoppingcartp({Key? key, required this.productId}) : super(key: key);
  @override
  State<shoppingcartp> createState() => _shoppingcartp();
}

class _shoppingcartp extends State<shoppingcartp> {
  @override
  Widget build(BuildContext context) {
    print("widget.productId============>");
    print(widget.productId);

    void accept() async {
      try {
        final response = await http.post(Uri.parse(
          "http://localhost/api/phpBackEnd/src/product.php?route=change-product-status&status=SOLD&productId=${widget.productId}",
        ));
        var data = jsonDecode(response.body);
        print(data["data"]);

        if (data["status"] == 'failure') {
          Fluttertoast.showToast(
              msg: data["message"],
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM_LEFT,
              timeInSecForIosWeb: 2,
              backgroundColor: Color.fromARGB(255, 235, 121, 106),
              textColor: Color.fromARGB(255, 255, 255, 255),
              webBgColor: "linear-gradient(to right, #f06449, #e62739)",
              fontSize: 13);
          return;
        } else {
          Fluttertoast.showToast(
              msg: data["message"],
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM_LEFT,
              timeInSecForIosWeb: 2,
              backgroundColor: Colors.blueAccent[200],
              textColor: const Color.fromARGB(255, 255, 255, 255),
              webBgColor: "linear-gradient(to right, #00b09b, #96c93d)",
              fontSize: 13);
        }
        // ignore: use_build_context_synchronously
        Navigator.pop(context);
      } catch (e) {
        print(e);
      }
    }

    void reject() async {
      try {
        final response = await http.post(Uri.parse(
          "http://localhost/api/phpBackEnd/src/product.php?route=change-product-status&status=CANCEL&productId=${widget.productId}",
        ));
        var data = jsonDecode(response.body);
        print(data["data"]);

        if (data["status"] == 'failure') {
          Fluttertoast.showToast(
              msg: data["message"],
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM_LEFT,
              timeInSecForIosWeb: 2,
              backgroundColor: Color.fromARGB(255, 235, 121, 106),
              textColor: Color.fromARGB(255, 255, 255, 255),
              webBgColor: "linear-gradient(to right, #f06449, #e62739)",
              fontSize: 13);
          return;
        } else {
          Fluttertoast.showToast(
              msg: data["message"],
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM_LEFT,
              timeInSecForIosWeb: 2,
              backgroundColor: Colors.blueAccent[200],
              textColor: const Color.fromARGB(255, 255, 255, 255),
              webBgColor: "linear-gradient(to right, #00b09b, #96c93d)",
              fontSize: 13);
        }
        // ignore: use_build_context_synchronously
        Navigator.pop(context);
      } catch (e) {
        print(e);
      }
    }

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          body: Container(
            color: Color(0xFFDAEAFD),
            child: Column(children: [
              Row(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(
                          Icons.arrow_back,
                          color: Color(0xFF140A8C),
                        )),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    "ReSellify",
                    // style: GoogleFonts.coustard(
                    //   fontSize: 32.0,
                    //   // fontWeight: FontWeight.bold,
                    //   color: Color(0xFF140A8C),
                    // ),
                  ),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Align(
                alignment: Alignment.center,
                child: Text("FEEDBACK PLEASE !!"),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                height: 300,
                child: Align(child: Lottie.asset("images/feedback.json")),
              ),
              Container(
                padding:
                    EdgeInsets.only(top: 20, bottom: 20, left: 10, right: 10),
                color: Color(0xFFA9D6FF),
                child: TextField(
                  maxLines: 3,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Feedback',
                  ),
                ),
              ),
              Container(
                padding:
                    EdgeInsets.only(top: 20, bottom: 20, left: 10, right: 10),
                color: Color(0xFFA9D6FF),
                child: TextField(
                  maxLines: 3,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Reason to remove product',
                  ),
                ),
              ),
            ]),
          ),
          bottomNavigationBar: BottomAppBar(
            color: Color(0xFFBFC1DB),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Padding(
                  padding: EdgeInsets.all(20),
                  child: TextButton(
                    onPressed: () {
                      reject();
                    },
                    child: Text("CANCEL PRODUCT"),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(20),
                  child: TextButton(
                    onPressed: () {
                      accept();
                    },
                    child: Text("PRODUCT SOLD"),
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
