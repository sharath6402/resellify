import 'dart:convert';

import "package:flutter/material.dart";
import 'package:http/http.dart' as http;

import 'dataStore/handelLocalStorageData.dart';

class categorydisp extends StatefulWidget {
  const categorydisp({Key? key}) : super(key: key);
  @override
  State<categorydisp> createState() => _categorydisp();
}

class _categorydisp extends State<categorydisp> {
  List<Widget> categoryWidget = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      getData();
    });
  }

  void getData() async {
    try {
      print("fetching data");
      final response = await http.get(Uri.parse(
        "http://localhost/api/phpBackEnd/src/product.php?route=get-unique-category-list",
      ));
      print(response);
      var data = jsonDecode(response.body);
      print(data["data"]);

      setState(() {
        // category = data["data"]?[0]?["category"] ?? [];
      });
      for (var cat in data["data"]) {
        categoryWidget.add(
          Padding(
            padding: EdgeInsets.zero,
            child: Container(
              child: Align(
                alignment: Alignment.center,
                child: SizedBox(
                  width: double.infinity,
                  child: Column(
                    children: [
                      IconButton(
                        icon: Icon(
                          Icons.category_outlined,
                          color: Color(0xFF140A8C),
                        ),
                        iconSize: 30,
                        onPressed: () async {
                          Navigator.pushNamed(context, '/result', arguments: {
                            "searchText": cat?["category"],
                            "userId": await getLocalFataByKey("userID")
                          });
                        },
                      ),
                      Text(
                        cat?["category"] ?? " ",
                        style: TextStyle(
                            // fontSize: 18.0,
                            // fontWeight: FontWeight.w400,
                            ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      }
    } catch (err) {
      print(err);
    }
  }

  // final TextStyle style1 = GoogleFonts.coustard(
  //   fontSize: 32.0,
  //   // fontWeight: FontWeight.bold,
  //   color: Color(0xFF140A8C),
  // );

  @override
  Widget build(BuildContext context) {
    print(categoryWidget);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
          height: 800,
          color: Color(0xFFDAEAFD),
          child: SingleChildScrollView(
            child: Column(children: [
              Padding(
                padding: EdgeInsets.only(top: 20, left: 20),
                child: Row(
                  children: [
                    IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(Icons.arrow_back)),
                    Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: Text(
                        "ReSellify",
                        // style: style1,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                  padding: EdgeInsets.only(top: 20, left: 5, right: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        "ALL CATEGORIES",
                        style: TextStyle(
                          color: Color(0XFF1140A8C),
                          fontSize: 18,
                        ),
                      ),
                    ],
                  )),
              GridView.count(
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(20),
                  crossAxisSpacing: 15,
                  mainAxisSpacing: 15,
                  crossAxisCount: 2,
                  children: [...categoryWidget]),
            ]),
          ),
        ),
      ),
    );
  }
}
