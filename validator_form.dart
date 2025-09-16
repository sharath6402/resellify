import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lottie/lottie.dart';
import 'package:http/http.dart' as http;

class Vform extends StatefulWidget {
  const Vform({Key? key}) : super(key: key);
  @override
  State<Vform> createState() => _Vform();
}

class _Vform extends State<Vform> {
  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> arguments =
        ModalRoute.of(context)!.settings.arguments as dynamic;

    void accept() async {
      try {
        final response = await http.post(Uri.parse(
          "http://localhost/api/phpBackEnd/src/product.php?route=change-product-status&status=VERIFIED&productId=${arguments['productId']}",
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
          "http://localhost/api/phpBackEnd/src/product.php?route=change-product-status&status=CANCEL&productId=${arguments['productId']}",
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
            color: const Color(0xFFDAEAFD),
            child: Column(children: [
              Row(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(
                          Icons.arrow_back,
                          color: Color(0xFF140A8C),
                        )),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  const Text(
                    "ReSellify",
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              const Align(
                alignment: Alignment.center,
                child: Text(
                  "VALIDATION FORM !!",
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                height: 300,
                child: Align(child: Lottie.asset("images/feedback.json")),
              ),
              Container(
                padding: const EdgeInsets.only(
                    top: 20, bottom: 20, left: 10, right: 10),
                color: const Color(0xFFA9D6FF),
                child: const TextField(
                  maxLines: 3,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Comments',
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(
                    top: 20, bottom: 20, left: 10, right: 10),
                color: const Color(0xFFA9D6FF),
                child: const TextField(
                  maxLines: 3,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Reason to reject product',
                  ),
                ),
              ),
            ]),
          ),
          bottomNavigationBar: BottomAppBar(
            color: const Color.fromARGB(255, 229, 229, 234),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: TextButton(
                    onPressed: () {
                      reject();
                    },
                    child: const Text(
                      "REJECT PRODUCT",
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w500,
                        color: Colors.red,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: TextButton(
                    onPressed: () {
                      accept();
                    },
                    child: const Text(
                      "ACCEPT PRODUCT",
                      style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.w500,
                          color: Colors.green),
                    ),
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
