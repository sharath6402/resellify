// ignore_for_file: prefer_const_constructors

import "dart:convert";

import "package:flutter/material.dart";
import "package:resellify/UserDetail.dart";
import "package:resellify/dataStore/handelLocalStorageData.dart";
import "package:resellify/product_detail.dart";
import "package:resellify/sellingform.dart";
import 'package:http/http.dart' as http;

// import "package:google_fonts/google_fonts.dart";

class myproduct extends StatefulWidget {
  const myproduct({Key? key}) : super(key: key);
  @override
  State<myproduct> createState() => _myproduct();
}

class _myproduct extends State<myproduct> {
  String searchText = "";
  dynamic userId = "";
  List<dynamic> productsList = [];
  List<Widget> productsListWidget = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Map<String, dynamic> arguments =
    //     ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    // setState(() {
    //   // searchText = arguments['searchText'] | "h";
    //   // userId = arguments?["userId"] ?? 0;
    //   print(arguments);
    //   // searchText = arguments?["searchText"] ?? "";
    //   searchText = "ho";
    //   // userId = arguments?["userId"] ?? "";
    //   userId = "10";
    getchData();
    // });
  }

  void getchData() async {
    try {
      dynamic statusData = {
        "CANCEL": {"color": Colors.red},
        "COMPLETED": {"color": Colors.orange},
        "INCOMPLETE": {"color": Colors.yellow},
        "SOLD": {"color": Colors.purple},
        "VERIFIED": {"color": Colors.green}
      };
      dynamic userId = await getLocalFataByKey("userId");
      print("fetching data");
      final response = await http.get(Uri.parse(
        "http://localhost/api/phpBackEnd/src/product.php?&route=get-my-products&userId=$userId",
      ));
      var data = jsonDecode(response.body);
      print(data?["data"]);
      // print(data["data"][1]);
      setState(() {
        List<Widget> getWidget = [];
        for (Map<String, dynamic> product in data?["data"] ?? []) {
          print(
              "=========================================================================");
          print(product);
          getWidget.add(
            InkWell(
              onTap: () async => {
                Navigator.pushNamed(context, '/details', arguments: {
                  "productId": product["id"],
                  "userId": await getLocalFataByKey("userId"),
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
                              product?["images"]?.split(',')?[0] ?? "",
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
                                    child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      product["productName"]
                                              .substring(
                                                  0,
                                                  product["productName"]
                                                              .length <=
                                                          10
                                                      ? product["productName"]
                                                          .length
                                                      : 10)
                                              .toUpperCase() ??
                                          " ",
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        // Navigator.pushNamed(
                                        //     context, '/myprodf');
                                        // Navigator.popAndPushNamed(context, '/user');
                                      },
                                      child: IconButton(
                                        onPressed: () {
                                          print(":dfsdfsdfdfds========");
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              // shashanks error is due to this
                                              builder: (context) =>
                                                  shoppingcartp(
                                                productId: product["id"],
                                              ),
                                            ),
                                          );
                                          // Navigator.pushNamed(
                                          //     context, '/myprodf');
                                          // Navigator.popAndPushNamed(context, '/user');
                                        },
                                        icon: Icon(Icons.more_vert),
                                      ),
                                    )
                                  ],
                                )),
                                SizedBox(height: 8),
                                Container(
                                  child: Text(
                                    product?["description"] ?? "",
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ),
                                SizedBox(height: 8),
                                Container(
                                  // width: double.minPositive,
                                  padding: EdgeInsets.all(5.0),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5.0),
                                    color: statusData[product?["status"]]
                                        ["color"],
                                  ),
                                  child: Text(
                                    product?["status"] ?? "",
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.white,
                                    ),
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
                                          Text(product?["chatCount"]
                                                  ?.toString() ??
                                              "0")
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
                                              "0")
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
                                          const SizedBox(
                                              width: 2.0, height: 2.0),
                                          Text(product?["cart_count"]
                                                  ?.toString() ??
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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            height: 800,
            color: Color(0xFFDAEAFD),
            child: ListView(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 20, right: 20),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Row(
                      children: [
                        IconButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  // shashanks error is due to this
                                  builder: (context) => const userDetails(),
                                ),
                              );
                            },
                            icon: Icon(
                              Icons.arrow_back,
                              color: Color(0xFF140A8C),
                            )),
                        SizedBox(
                          width: 20,
                        ),
                        const Text(
                          "My Products",
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF140A8C),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // Container(
                //   padding: EdgeInsets.only(top: 10),
                //   child: ListView.builder(
                //     shrinkWrap: true,
                //     // scrollDirection:Axis.horizontal,
                //     //when implemented
                //     // itemCount: searchresult.length,
                //     itemCount: 5,
                //     itemBuilder: (context, index) {
                //       return FilledCardExample();
                //     },
                //   ),
                // )

                ...productsListWidget
              ],
            ),
          ),
        ),
      ),
      routes: {
        "/myprodf": (context) => shoppingcartp(
              productId: "",
            ),
        '/details': (context) => product(),
      },
    );
  }
}

// class FilledCardExample extends StatelessWidget {
//   const FilledCardExample({super.key});

//   @override
//   Widget build(BuildContext context) {
//     AssetImage product1 = AssetImage("images/car.jpeg");
//     Image image1 = Image(
//       image: product1,
//     );
//     return ListView(
//       shrinkWrap: true,
//       children: [
//         Center(
//             child: GestureDetector(
//           onTap: () {
//             Navigator.pushNamed(context, '/details');
//           },
//           child: Card(
//             clipBehavior: Clip.hardEdge,
//             child: InkWell(
//               splashColor: Colors.blue.withAlpha(30),
//               onTap: () {
//                 // debugPrint('Card tapped.');
//                 Navigator.pushNamed(context, '/details');
//               },
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: <Widget>[
//                   ListTile(
//                     // shrinkWrap: true,
//                     leading: SizedBox(
//                       width: 150.0,
//                       height: 112.0,
//                       child: Image.asset('images/car.jpeg'),
//                     ),
//                     title: Text('TATA NEXON'),
//                     trailing: IconButton(
//                       onPressed: () {
//                         Navigator.pushNamed(context, '/myprodf');
//                         // Navigator.popAndPushNamed(context, '/user');
//                       },
//                       icon: Icon(Icons.more_vert),
//                     ),
//                     subtitle: Text(
//                         "Registration Year:Jun 2019 Fuel Type:Diesel Kms Driven:69,466 Kms Ownership:First Owner"),
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.end,
//                     children: <Widget>[
//                       Container(
//                         child: Row(
//                           children: [
//                             Icon(
//                               Icons.messenger_outline,
//                               color: Color(0xFF140A8C),
//                             ),
//                             Text("10")
//                           ],
//                         ),
//                       ),
//                       const SizedBox(width: 30),
//                       Container(
//                         child: Row(
//                           children: [
//                             Icon(
//                               Icons.remove_red_eye,
//                               color: Color(0xFF140A8C),
//                             ),
//                             Text("10")
//                           ],
//                         ),
//                       ),
//                       const SizedBox(width: 30),
//                       Container(
//                         child: Row(
//                           children: [
//                             Icon(
//                               Icons.star,
//                               color: Color(0xFF140A8C),
//                             ),
//                             Text("10")
//                           ],
//                         ),
//                       ),
//                       const SizedBox(width: 30),
//                       Container(
//                         child: Row(
//                           children: [
//                             Icon(
//                               Icons.attach_money,
//                               color: Color(0xFF140A8C),
//                             ),
//                             Text("10"),
//                           ],
//                         ),
//                       ),
//                       const SizedBox(width: 30),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ))
//       ],
//     );
//   }
// }
