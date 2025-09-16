// ignore_for_file: prefer_const_constructors

import 'dart:convert';
import 'dart:js_util';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'dataStore/handelLocalStorageData.dart';

class search extends StatefulWidget {
  const search({Key? key}) : super(key: key);
  @override
  State<search> createState() => _searchState();
}

class _searchState extends State<search> {
  bool isSearching = false;
  dynamic userId = "";
  dynamic searchText = [];
  List<dynamic> searchResult = [];
  List<Widget> searchResultWidget = [];
  List<dynamic> trendingResult = [];
  List<Widget> trendingResultWidget = [
    Padding(
      padding: EdgeInsets.only(top: 20, left: 30),
      child: Align(
          alignment: Alignment.topLeft,
          child: Text(
            "Trending ",
            style: TextStyle(
              fontSize: 18.0,
              letterSpacing: 1.0,
              fontWeight: FontWeight.w500,
              color: Colors.blueAccent,
            ),
          )),
    ),
  ];
  List<dynamic> recentResult = [];
  List<Widget> recentResultWidget = [
    Padding(
      padding: EdgeInsets.only(top: 20, left: 30),
      child: Align(
        alignment: Alignment.topLeft,
        child: Text(
          "Recently searched ",
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.w500,
            letterSpacing: 1.0,
            color: Colors.blueAccent,
          ),
        ),
      ),
    ),
  ];

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    print("change dependences");
    searchResultTrendingAndRecent();
  }

  void addToSearchHistory(productId, userId, context) async {
    try {
      final response = await http.post(Uri.parse(
        "http://localhost/api/phpBackEnd/src/product.php?productId=$productId&userId=$userId&route=add-to-search-history",
      ));
      var data = jsonDecode(response.body);
      // print(object)
    } catch (e) {
      print(e);
    }
    Navigator.pushNamed(context, '/details', arguments: {
      "productId": productId,
      "userId": userId,
    });
  }

  void deleteHistory(productId, userId) async {
    try {
      final response = await http.delete(Uri.parse(
        "http://localhost/api/phpBackEnd/src/product.php?productId=$productId&userId=$userId&route=remove-from-search-history",
      ));
      var data = jsonDecode(response.body);
      // print(object)
      searchResultTrendingAndRecent();
    } catch (e) {
      print(e);
    }
  }

  dynamic search(value) async {
    try {
      print("search");
      final response = await http.get(Uri.parse(
        "http://localhost/api/phpBackEnd/src/product.php?search=$value&route=search",
      ));
      var data = jsonDecode(response.body);
      // print(object)
      setState(() {
        searchText = value;
        recentResultWidget = [recentResultWidget[0]];
        trendingResultWidget = [trendingResultWidget[0]];
        searchResult = data?["data"] ?? [];
        searchResultWidget = searchResult
            .map(
              (product) => Padding(
                padding: EdgeInsets.only(
                  top: 5.0,
                ),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: Colors.black12,
                      ),
                    ),
                  ),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: ListTile(
                      title: Text(
                        product?["productName"] ?? " ",
                        style: TextStyle(
                          color: Colors.black87,
                        ),
                      ),
                      subtitle: Text(
                        product?["category"] ?? " ",
                        style: TextStyle(
                          color: Colors.black54,
                        ),
                      ),
                      leading: Container(
                        height: 40.0,
                        width: 40.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                            40.0,
                          ),
                        ),
                        child: ClipOval(
                          child: Image.network(
                            product?["images"]?.split(",")?[0] ?? " ",
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      hoverColor: Colors.blueGrey[100],
                      trailing: const Icon(Icons.search, color: Colors.black54),
                      onTap: () async {
                        addToSearchHistory(product["id"],
                            await getLocalFataByKey("userId"), context);
                      },
                    ),
                  ),
                ),
              ),
            )
            .toList();
      });
    } catch (e) {
      print(e);
    }
  }

  dynamic searchResultTrendingAndRecent() async {
    try {
      print("search");
      dynamic userId = await getLocalFataByKey("userId");
      final response = await http.get(Uri.parse(
        "http://localhost/api/phpBackEnd/src/product.php?route=search-trending&userId=$userId",
      ));
      var data = jsonDecode(response.body);
      setState(() {
        searchResult = [];
        searchResultWidget = [];
        trendingResultWidget = [trendingResultWidget[0]];
        recentResultWidget = [recentResultWidget[0]];
        print("object");
        trendingResult = data?["data"]?["trendingResult"];
        List<Widget> data1 = trendingResult
            .map((product) => Padding(
                  padding: EdgeInsets.only(top: 5.0, left: 5.0),
                  child: Align(
                      alignment: Alignment.topLeft,
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: Colors.black12,
                            ),
                          ),
                        ),
                        child: ListTile(
                          leading: Icon(
                            Icons.trending_up_outlined,
                            color: Colors.black54,
                          ),
                          title: Text(
                            product["productName"],
                            style: TextStyle(
                              color: Colors.black87,
                              fontWeight: FontWeight.w500,
                              letterSpacing: 1.0,
                            ),
                          ),
                          onTap: () async {
                            addToSearchHistory(product["id"],
                                await getLocalFataByKey("userId"), context);
                          },
                        ),
                      )),
                ))
            .toList();
        trendingResultWidget.addAll(data1);
        recentResult = data?["data"]?["recentSearch"];
        List<Widget> data2 = recentResult
            .map((product) => Padding(
                  padding: EdgeInsets.only(top: 5.0, left: 5.0),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Colors.black12,
                          ),
                        ),
                      ),
                      child: ListTile(
                        leading: Icon(
                          Icons.history,
                          color: Colors.black54,
                        ),
                        title: Text(
                          product["productName"],
                          style: TextStyle(
                            color: Colors.black87,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 1.0,
                          ),
                        ),
                        trailing: IconButton(
                          onPressed: () async {
                            deleteHistory(
                              product["id"],
                              await getLocalFataByKey("userId"),
                            );
                          },
                          icon: Icon(Icons.close),
                        ),
                        onTap: () async {
                          addToSearchHistory(product["id"],
                              await getLocalFataByKey("userId"), context);
                        },
                      ),
                    ),

                    // Text(
                    //   product?["productName"] ?? "",
                    //   style: TextStyle(
                    //     color: Colors.black87,
                    //   ),
                    // ),
                  ),
                ))
            .toList();
        recentResultWidget.addAll(data2);
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    print("id");

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
          height: double.infinity,
          color: Color.fromARGB(255, 223, 223, 223),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                    padding: EdgeInsets.only(top: 10, left: 10),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: IconButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/home');
                        },
                        icon: Icon(
                          Icons.close,
                          color: Colors.black,
                        ),
                      ),
                    )),
                Padding(
                  padding: EdgeInsets.only(top: 10, left: 20),
                  child: Row(
                    // shrinkwrap:true,
                    children: [
                      Expanded(
                        child: TextField(
                          onChanged: (value) => {
                            if (value.isNotEmpty)
                              {
                                search(value),
                              }
                            else
                              {searchResultTrendingAndRecent()}
                          },
                          decoration: InputDecoration(
                              hintText: '   Search..',
                              border: InputBorder.none,
                              fillColor: Colors.white),
                        ),
                      ),
                      IconButton(
                          icon: Icon(Icons.search, color: Color(0xFF140A8C)),
                          onPressed: () async {
                            Navigator.pushNamed(context, '/result', arguments: {
                              "searchText": searchText,
                              "userId": getLocalFataByKey("userID")
                            });
                          }),
                      IconButton(
                        icon: Icon(Icons.filter_center_focus_outlined,
                            color: Color(0xFF140A8C)),
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
                ...searchResultWidget,
                ...recentResultWidget,
                ...trendingResultWidget,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
