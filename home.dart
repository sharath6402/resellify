// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:resellify/dataStore/handelLocalStorageData.dart';
import 'package:resellify/product_detail.dart';

import 'otpPage.dart';

final List<String> imgList = [
  "http://localhost/api/phpBackEnd/src/uploads/carosuel pic1.png",
  "http://localhost/api/phpBackEnd/src/uploads/carosuel pic2.png",
];
final List<String> imgLabel = ['', '', '', '', '', ''];
final List<Widget> imageSliders = imgList
        .map((item) => Container(
              child: Container(
                margin: EdgeInsets.all(5.0),
                child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    child: Stack(
                      children: <Widget>[
                        Image.network(
                          item,
                          fit: BoxFit.fill,
                          width: double.infinity,
                          height: 200.0,
                        ),
                        Positioned(
                          bottom: 0.0,
                          left: 0.0,
                          right: 0.0,
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 20.0),
                            child: Text(
                              '${imgLabel?[imgList.indexOf(item)]}',
                              // '${}imgLabel[imgList.indexOf(item)}]',
                              // ' ${imgList.indexOf(item)} ',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    )),
              ),
            ))
        ?.toList() ??
    [];

// String getProductImage

class MyApp1 extends StatefulWidget {
  const MyApp1({Key? key}) : super(key: key);
  @override
  State<MyApp1> createState() => _homeState();
}

class _homeState extends State<MyApp1> {
  List<dynamic> productsList = [];
  List<dynamic> productImages = [];
  Future<void> getData() async {
    try {
      print("user details ==================================>");
      // print(await getLocalFataByKey("userId"));
      print(await getLocalData());
      print("user details ==================================>");
      http.Response result = await http.get(
          Uri.parse(
              "http://localhost/api/phpBackEnd/src/product.php?route=get-all-products"),
          headers: {
            'Content-Type': 'application/json',
            "Accept": "application/json",
            "Access-Control_Allow_Origin": "*"
          });
      print("got");
      dynamic responseMap = jsonDecode(result.body);
      print(responseMap["data"]);
      // final data = jsonDecode(responseMap);
      setState(() {
        productsList = responseMap["data"];
        // productImages = responseMap["data"]["images"];
      });
      print("responseMap===================================");
      print(await getLocalFataByKey("userId"));
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("VerifyOtpByEmail.id=======================================>");
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: Container(
            color: Color(0xFFDAEAFD),
            // height: 400,
            child: ListView(
              shrinkWrap: true,
              children: [
                Padding(
                    padding: EdgeInsets.only(top: 20, left: 10, right: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            "ReSellify",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20.0,
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.topRight,
                          child: IconButton(
                            onPressed: () {
                              Navigator.pushNamed(context, '/user');
                            },
                            icon: Icon(
                              Icons.account_circle,
                              size: 32,
                              color: Colors.teal,
                            ),
                          ),
                        ),
                      ],
                    )),
                Padding(
                    padding: EdgeInsets.all(10),
                    child: GestureDetector(
                      onDoubleTap: () {
                        Navigator.pushNamed(context, '/search');
                      },
                      child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: Color.fromARGB(170, 226, 226, 226),
                          ),
                          child: Row(children: [
                            Expanded(
                              child: TextField(
                                decoration: InputDecoration(
                                    hintText: '   Search..',
                                    border: InputBorder.none,
                                    fillColor: Colors.white),
                              ),
                            ),
                            IconButton(
                              icon:
                                  Icon(Icons.search, color: Color(0xFF140A8C)),
                              onPressed: () {
                                Navigator.pushNamed(context, '/search');
                              },
                            ),
                          ])),
                    )),
                Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: Container(
                    child: CarouselSlider(
                      options: CarouselOptions(
                        autoPlay: true,
                        aspectRatio: 2.0,
                        enlargeCenterPage: true,
                      ),
                      items: imageSliders,
                    ),
                  ),
                ),
                Column(
                  children: [
                    Padding(
                        padding: EdgeInsets.only(top: 10, bottom: 10, left: 20),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            'TOP CATEGORY',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: [
                            IconButton(
                              icon: Icon(
                                Icons.car_repair,
                                color: Colors.black54,
                              ),
                              iconSize: 50,
                              onPressed: () async {
                                Navigator.pushNamed(
                                    context, '/result', arguments: {
                                  "searchText": "Car",
                                  "userId": await getLocalFataByKey("userID")
                                });
                              },
                            ),
                            Text(
                              "Car",
                              style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.w400,
                              ),
                            )
                          ],
                        ),
                        Column(
                          children: [
                            IconButton(
                              icon: Icon(
                                Icons.bike_scooter,
                                color: Colors.black54,
                              ),
                              iconSize: 50,
                              onPressed: () async {
                                Navigator.pushNamed(
                                    context, '/result', arguments: {
                                  "searchText": "BIke",
                                  "userId": await getLocalFataByKey("userID")
                                });
                              },
                            ),
                            Text(
                              "Bike",
                              style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.w400,
                              ),
                            )
                          ],
                        ),
                        Column(
                          children: [
                            IconButton(
                              icon: Icon(
                                Icons.table_bar,
                                color: Colors.black54,
                              ),
                              iconSize: 50,
                              onPressed: () async {
                                Navigator.pushNamed(
                                    context, '/result', arguments: {
                                  "searchText": "Furniture",
                                  "userId": await getLocalFataByKey("userID")
                                });
                              },
                            ),
                            Text(
                              "Furniture",
                              style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.w400,
                              ),
                            )
                          ],
                        ),
                        Column(
                          children: [
                            IconButton(
                              icon: Icon(
                                Icons.book,
                                color: Colors.black54,
                              ),
                              iconSize: 50,
                              onPressed: () async {
                                Navigator.pushNamed(
                                    context, '/result', arguments: {
                                  "searchText": "others",
                                  "userId": await getLocalFataByKey("userID")
                                });
                              },
                            ),
                            Text(
                              "Book",
                              style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.w400,
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                    Padding(
                        padding: EdgeInsets.only(top: 10, bottom: 10, left: 20),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            'NEWLY ADDED',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )),
                  ],
                ),
                GridView.count(
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(20),
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  crossAxisCount: 2,
                  children: productsList.map((pro) {
                    print(pro["images"].split(",")[0]);
                    String imageUrl = pro?["images"]?.split(",")?[0] ?? " ";
                    String productName = pro?['productName']
                            .substring(
                                0,
                                pro?['productName'].length <= 10
                                    ? pro['productName'].length
                                    : 10)
                            .toString() ??
                        "..."; // Provide a default value if productName is null
                    String price = pro?['price']?.toString() ??
                        "0"; // Provide a default value if productName is null

                    return InkWell(
                      onTap: () async {
                        Navigator.pushNamed(context, '/details', arguments: {
                          "productId": pro?["id"],
                          "userId": await getLocalFataByKey("userId"),
                        });
                      },
                      onDoubleTap: () {},
                      customBorder: CircleBorder(
                        eccentricity: BorderSide.strokeAlignOutside,
                      ),
                      child: Stack(
                        children: [
                          Image.network(
                            imageUrl,
                            // fit: BoxFit.cover,
                            fit: BoxFit.fill,
                            width: double.maxFinite,
                            height: 300.0,
                          ),
                          Align(
                            alignment: Alignment.bottomLeft,
                            child: Container(
                              color: Color.fromARGB(255, 231, 248, 255),
                              child: ListTile(
                                leading: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      productName.toUpperCase(),
                                      style: TextStyle(
                                        color: Color.fromARGB(255, 83, 77, 77),
                                        // fontSize: 17.0,
                                        // fontWeight: FontWeight.w400,
                                        // letterSpacing: 1.0,
                                      ),
                                    ),
                                    Text(
                                      "₹${price?.toString() ?? ' '}",
                                      style: TextStyle(
                                        color: Color.fromARGB(255, 83, 77, 77),
                                        // fontSize: 16.0,
                                      ),
                                    ),
                                  ],
                                ),

                                // trailing: Icon(
                                //   // Icons.shopping_cart,
                                //   Icons.shopping_cart_outlined,
                                //   // color: Color.fromARGB(255, 83, 77, 77),
                                //   color: Colors.indigo,
                                // ), // Replace this with your desired trailing widget
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
          bottomNavigationBar: BottomAppBar(
            color: Color(0xFFBFC1DB),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.home,
                      color: Color(0xFF140A8C),
                    )),
                IconButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/cat');
                    },
                    icon: Icon(
                      Icons.category_outlined,
                      color: Color(0xFF140A8C),
                    )),
                IconButton(
                    onPressed: () {
                      Navigator.pushNamed(
                          context, '/selectedCategoryDetailsForm');
                    },
                    icon: Icon(
                      Icons.sell,
                      color: Color(0xFF140A8C),
                    )),
                IconButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/newChat');
                    },
                    icon: Icon(
                      Icons.message,
                      color: Color(0xFF140A8C),
                    )),
                IconButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/cart');
                    },
                    icon: Icon(
                      Icons.shopping_cart,
                      color: Color(0xFF140A8C),
                    )),
              ],
            ),
          ),
        ));
  }
}
