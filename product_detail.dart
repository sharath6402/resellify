// ignore_for_file: prefer_const_constructors
import 'dart:convert';
import 'dart:io';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:resellify/dataStore/handelLocalStorageData.dart';

import 'Datafetch.dart';
import 'api.dart';
import 'chathist.dart';

// import 'home.dart';
// import 'login.dart';

// void main() => runApp(product());
class product extends StatefulWidget {
  // ignore: prefer_typing_uninitialized_variables

  product({Key? key}) : super(key: key);

  @override
  State<product> createState() => _product();
}

class _product extends State<product> {
  dynamic initialData = {
    "id": "",
    "productName": "",
    "yearOfPurchase": "",
    "description": "",
    "model": "",
    "kmDriven": "",
    "price": "",
    "noOfOwner": "",
    "location": "",
    "images": "",
    "userId": "",
    "createdAt": "",
    "updatedAt": "",
    "category": "",
    "status": ""
  };
  dynamic productData = {
    "id": "",
    "productName": "",
    "yearOfPurchase": "",
    "description": "",
    "model": "",
    "kmDriven": "",
    "price": "",
    "noOfOwner": "",
    "location": "",
    "images": "",
    "userId": "",
    "createdAt": "",
    "updatedAt": "",
    "category": "",
    "status": ""
  };
  List<dynamic> productImages = [];
  dynamic cartCount = "0";
  bool isAlreadyInCart = false;
  bool checkForIsAlreadyInCart = false;
  dynamic productId = "";
  dynamic userId = "";
  bool isVisited = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Get the arguments and set the state with them
    Map<String, dynamic> arguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    setState(() {
      productId = arguments['productId'];
      userId = arguments['userId'];
    });

    // Call the API methods using the updated productId

    if (!isVisited) {
      incrementProductViewCount();
    }
    fetchData();
    getProductInsight();
    isProductInCart();

    setState(() {
      isVisited = true;
    });
  }

  void getProductInsight() async {
    setState(() async {
      cartCount = await getInsightsOfAProduct(productId);
    });
  }

  void incrementProductViewCount() async {
    try {
      print("entered");
      Map<String, dynamic> arg =
          ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

      final response = await http.put(Uri.parse(
        "http://localhost/api/phpBackEnd/src/product.php?route=increment-product-view-count&productId=${arg['productId']}",
      ));
      var data = jsonDecode(response.body);
      print("data==================");
      print(data);
      return data;
    } catch (err) {
      print(err);
    }
  }

  void isProductInCart() async {
    bool result = await isProductIsInCart(productId, userId);
    dynamic count = await getInsightsOfAProduct(productId);
    setState(() {
      isAlreadyInCart = result;
      cartCount = count;
      print("is product found");
    });
  }

  void addProductToCart() async {
    print("add product to cart");
    bool result = await addToCart(productId, userId);
    dynamic count = await getInsightsOfAProduct(productId);
    bool isPresent = await isProductIsInCart(productId, userId);
    print(result);
    print(count);
    if (result) {
      setState(() {
        cartCount = count;
        isAlreadyInCart = isPresent;
      });
    }
  }

  void removeProductFromCart() async {
    bool result = await removeFromCart(productId, userId);
    dynamic count = await getInsightsOfAProduct(productId);
    bool isPresent = await isProductIsInCart(productId, userId);
    print(result);
    if (result) {
      setState(() {
        isAlreadyInCart = isPresent;
        cartCount = count;
      });
    }
  }

  void fetchData() async {
    try {
      print("fetching data");
      final response = await http.get(Uri.parse(
        "http://localhost/api/phpBackEnd/src/product.php?route=get-single-products&productId=$productId",
      ));

      print(response);
      var data = jsonDecode(response.body);
      print("================================================");
      print(data);
      setState(() {
        if (data["data"].length == 1) {
          productData = data?["data"]?[0] ?? initialData;
          productImages = data["data"][0]["images"].split(",");
        }
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    // dynamic arguments = ModalRoute.of(context)!.settings.arguments as dynamic;
    CarouselController buttonCarouselController = CarouselController();

    List<int> list = [1, 2, 3, 4, 5];
    print("arguments");

    print(productId);
    print(userId);
    print(productImages);
    print("=====================================");
    print(getLocalFataByKey("currentProduct"));
    print("=====================================");

    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            body: Container(
                color: Color(0xFFDAEAFD),
                child: Column(children: [
                  Container(
                    child: Column(
                      children: [
                        Stack(children: [
                          CarouselSlider(
                            carouselController: buttonCarouselController,
                            options: CarouselOptions(
                              disableCenter: true,
                              // autoPlay: true,
                              autoPlayAnimationDuration:
                                  Duration(milliseconds: 300),
                            ),
                            items: productImages
                                    ?.map((item) => Container(
                                          child: Center(
                                              child: Image.network(
                                            item,
                                            // fit: BoxFit.cover,
                                            fit: BoxFit.fill,
                                            width: double.maxFinite,
                                            height: 500.0,
                                          )
                                              //  Icon(
                                              //   Icons.photo_album,
                                              //   color: Color(0xFF140A8C),
                                              // ),
                                              ),
                                          color: Color(0xFFD9D9D9),
                                        ))
                                    ?.toList() ??
                                [],
                          ),
                          Container(
                            alignment: Alignment.topLeft,
                            child: IconButton(
                              onPressed: () {
                                // Navigator.pushNamed(context, '/home');
                                Navigator.pop(context);
                              },
                              icon: Icon(
                                Icons.arrow_back,
                                color: Color(0xFF140A8C),
                              ),
                            ),
                          ),
                          Container(
                            alignment: Alignment.bottomRight,
                            child: IconButton(
                              onPressed: () async {
                                if (isAlreadyInCart) {
                                  removeProductFromCart();
                                  // setState(() {
                                  //   isAlreadyInCart = false;
                                  // });
                                } else {
                                  addProductToCart();
                                  // setState(() {
                                  //   isAlreadyInCart = true;
                                  // });
                                }
                              },
                              // favorite_border
                              icon: (isAlreadyInCart)
                                  ? Icon(
                                      Icons.favorite,
                                      color: Colors.red[900],
                                    )
                                  : Icon(
                                      Icons.favorite_border_outlined,
                                      color: Colors.red[900],
                                    ),
                            ),
                          ),
                        ]),
                        Container(
                          padding: EdgeInsets.symmetric(
                            vertical: 10.0,
                            horizontal: 10.0,
                          ),
                          child: Column(
                            children: [
                              Container(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(
                                        bottom: 8.0,
                                        left: 5.0,
                                      ),
                                      child: Text(
                                        (productData?["productName"])
                                                ?.toUpperCase() ??
                                            " ",
                                        style: TextStyle(
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.w500,
                                          letterSpacing: 1.0,
                                        ),
                                      ),
                                    ),
                                    // Icon(Icons.favorite_border),
                                  ],
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                  bottom: 10.0,
                                  left: 5.0,
                                ),
                                width: double.infinity,
                                child: Text(
                                    // "₹ ${(productData['price'] != Null || productData['price'] != "") ? productData['price'] : ""}",
                                    "₹ ${productData?['price'] ?? ' '}",
                                    style: TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.w700,
                                      letterSpacing: 0.5,
                                    )),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        child: Icon(
                                          Icons.location_pin,
                                          color: Colors.redAccent,
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(
                                          left: 5.0,
                                        ),
                                        child: Text(
                                          productData?["location"] ?? " ",
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(
                                          bottom: 10.0,
                                          top: 10.0,
                                        ),
                                        child: Icon(
                                          Icons.calendar_month,
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(
                                          bottom: 10.0,
                                          top: 10.0,
                                          left: 5.0,
                                        ),
                                        child: Text(
                                            productData?["createdAt"] ?? " "),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 5.0),
                          child: Column(
                            children: [
                              Container(
                                margin: EdgeInsets.only(
                                  bottom: 10.0,
                                ),
                                width: double.infinity,
                                child: Text(
                                  "Details",
                                  style: TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.w500,
                                    letterSpacing: 1.0,
                                  ),
                                ),
                              ),
                              Table(
                                children: [
                                  TableRow(children: [
                                    Padding(
                                      padding: EdgeInsets.all(5.0),
                                      child: Text("Category"),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.all(5.0),
                                      child: Text(
                                          (productData["category"] != Null)
                                              ? productData["category"]
                                              : ""),
                                    )
                                  ]),
                                  TableRow(children: [
                                    Padding(
                                      padding: EdgeInsets.all(5.0),
                                      child: Text("Model"),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.all(5.0),
                                      child: Text((productData["model"] != Null)
                                          ? productData["model"]
                                          : ""),
                                    ),
                                  ]),
                                  TableRow(children: [
                                    Padding(
                                      padding: EdgeInsets.all(5.0),
                                      child: Text("Year Of Purchase"),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.all(5.0),
                                      child: Text(
                                        (productData["yearOfPurchase"] != Null)
                                            ? productData["yearOfPurchase"]
                                                .toString()
                                            : "",
                                      ),
                                    ),
                                  ]),
                                  TableRow(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.all(5.0),
                                        child: Text("Verified"),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.all(5.0),
                                        child: Container(
                                          padding: EdgeInsets.all(5.0),
                                          alignment: Alignment.center,
                                          color: (productData["status"] ==
                                                  'VERIFIED')
                                              ? Colors.green
                                              : Colors.red,
                                          child: Text(
                                            (productData["status"] ==
                                                    'VERIFIED')
                                                ? "VERIFIED"
                                                : "NOT VERIFIED",
                                            style: TextStyle(
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  TableRow(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.all(5.0),
                                        child: Text("Description"),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.all(5.0),
                                        child: Text(
                                          (productData["description"] != Null)
                                              ? productData["description"]
                                                  .toString()
                                                  .substring(
                                                      0,
                                                      productData["description"]
                                                                  ?.length <
                                                              100
                                                          ? productData[
                                                                  "description"]
                                                              .length
                                                          : 100)
                                              : "",
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ])),
            bottomNavigationBar: BottomAppBar(
              color: Color(0xFFBFC1DB),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Padding(
                    padding: EdgeInsets.all(20),
                    child: TextButton(
                      onPressed: () async {
                        print(productData["userId"]);
                        String userId =
                            await getLocalFataByKey("userId") as String;
                        print(await getLocalFataByKey("userId"));
                        // Navigator.pushNamed(context, '/chatp');
                        if (productData["userId"].toString() == userId) {
                          Fluttertoast.showToast(
                              msg: "You can't initiate chat",
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
                        } else {
                          final response = await http.post(Uri.parse(
                            "http://localhost/api/phpBackEnd/src/product.php?route=initiate-chat&userId=$userId&productId=${productData['id']}",
                          ));
                          var data = jsonDecode(response.body);
                          print(data["data"]);

                          if (data["status"] == "sucess") {
                            Fluttertoast.showToast(
                                msg: "sucessfully initiated chat",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM_LEFT,
                                timeInSecForIosWeb: 2,
                                backgroundColor: Colors.blueAccent[200],
                                textColor:
                                    const Color.fromARGB(255, 255, 255, 255),
                                webBgColor:
                                    "linear-gradient(to right, #00b09b, #96c93d)",
                                fontSize: 13);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => DataFetchingScreen()),
                            );
                          }
                          Fluttertoast.showToast(
                              msg: "Failed to initiate chat",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM_LEFT,
                              timeInSecForIosWeb: 2,
                              backgroundColor:
                                  Color.fromARGB(255, 235, 121, 106),
                              textColor: Color.fromARGB(255, 255, 255, 255),
                              webBgColor:
                                  "linear-gradient(to right, #f06449, #e62739)",
                              fontSize: 13);
                        }
                      },
                      child: Text("CHAT NOW"),
                    ),
                  ),
                ],
              ),
            )));
  }
}
