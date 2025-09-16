// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'dataStore/handelLocalStorageData.dart';
import 'product_detail.dart';

class result extends StatefulWidget {
  const result({Key? key}) : super(key: key);
  @override
  State<result> createState() => _resultState();
}

class _resultState extends State<result> {
  String searchText = "";
  dynamic userId = "";
  List<dynamic> productsList = [];
  List<Widget> productsListWidget = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    Map<String, dynamic> arguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    setState(() {
      searchText = arguments['searchText'];
      userId = arguments?["userId"] ?? 0;
      print(arguments);
      // searchText = arguments?["searchText"] ?? "";
      // searchText = "ho";
      // userId = arguments?["userId"] ?? "";
      // userId = "10";
      getchData(searchText);
    });
  }

  void getchData(searchData) async {
    try {
      print("fetching data");
      final response = await http.get(Uri.parse(
        "http://localhost/api/phpBackEnd/src/product.php?search=$searchData&route=search",
      ));
      var data = jsonDecode(response.body);
      print(data["data"]);
      setState(() {
        List<Widget> getWidget = [];
        for (Map<String, dynamic> product in data["data"]) {
          print(
              "=========================================================================");
          print(product);
          getWidget.add(
            InkWell(
              onTap: () => {
                Navigator.pushNamed(context, '/details', arguments: {
                  "productId": product["id"],
                  "userId": userId,
                })
              },
              child: Card(
                color: Color(0XFFDAEAFD),
                margin: EdgeInsets.symmetric(vertical: 10.0),
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 2,
                        child: Container(
                            height: 150,
                            child: Image.network(
                              product?["images"].split(',')?[0] ?? "",
                              scale: 1,
                              // fit: BoxFit.cover,
                              fit: BoxFit.fill,
                              width: double.maxFinite,
                              height: 500.0,
                            )),
                      ),
                      Expanded(
                        flex: 3,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 16.0),
                          child: Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  child: Text(
                                    product?["productName"] ?? "",
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 8),
                                Container(
                                  child: Text(
                                    product?["description"] ?? "",
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ),
                                SizedBox(height: 8),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Container(
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.messenger_outline,
                                            color: Color(0xFF140A8C),
                                          ),
                                          Text(product?["chat_count"]
                                                  .toString() ??
                                              " ")
                                        ],
                                      ),
                                    ),
                                    const SizedBox(width: 5.0, height: 5.0),
                                    Container(
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.remove_red_eye,
                                            color: Color(0xFF140A8C),
                                          ),
                                          SizedBox(width: 2.0, height: 2.0),
                                          Text(product?["views"].toString() ??
                                              " ")
                                        ],
                                      ),
                                    ),
                                    const SizedBox(width: 10.0, height: 10.0),
                                    Container(
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.star,
                                            color: Color(0xFF140A8C),
                                          ),
                                          SizedBox(width: 2.0, height: 2.0),
                                          Text(product?["cart_count"]
                                                  .toString() ??
                                              " ")
                                        ],
                                      ),
                                    ),
                                    const SizedBox(width: 10.0, height: 10.0),
                                    Container(
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.currency_rupee,
                                            color: Color(0xFF140A8C),
                                          ),
                                          SizedBox(width: 2.0, height: 2.0),
                                          Text(product?["price"].toString() ??
                                              " ")
                                        ],
                                      ),
                                    ),
                                    const SizedBox(width: 10.0, height: 10.0),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }
        productsListWidget = getWidget;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    print(productsList);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
          height: 800.0,
          color: Color.fromRGBO(218, 234, 253, 1),
          child: ListView(
            children: [
              ListView(shrinkWrap: true, children: [
                Padding(
                    padding: EdgeInsets.only(top: 20, left: 10, right: 10),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              "ReSellify",
                              // style: style1,
                            ),
                          ),
                        ])),
                Padding(
                    padding: EdgeInsets.only(top: 10, left: 20, right: 20),
                    child: Row(
                        // shrinkwrap:true,
                        children: [
                          IconButton(
                            icon: Icon(Icons.arrow_back,
                                color: Color(0xFF140A8C)),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                          Expanded(
                            child: TextField(
                              onChanged: (value) => {
                                print(value),
                                setState(() {
                                  getchData(value);
                                }),
                              },
                              decoration: InputDecoration(
                                hintText:
                                    '   Search Results.... for $searchText',
                                border: InputBorder.none,
                                fillColor: Colors.white,
                              ),
                            ),
                          ),
                          IconButton(
                            icon: Icon(Icons.filter_list,
                                color: Color(0xFF140A8C)),
                            onPressed: () {
                              // return Container();
                            },
                          ),
                        ])),
                SingleChildScrollView(
                  child: Column(
                    children: [...productsListWidget],
                  ),
                )
                // FilledCardExample(productsList),
                // SingleChildScrollView(
                //     scrollDirection: axisDirectionToAxis(AxisDirection.down),
                //     child: Column(
                //       children: [
                //   ],
                // ))
              ]),
            ],
          ),
        ),
      ),
      routes: {
        '/details': (context) => product(),
      },
    );
  }
}
