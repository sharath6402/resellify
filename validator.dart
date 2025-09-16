import "dart:async";
import "dart:convert";

import 'package:http/http.dart' as http;
import "package:flutter/material.dart";
import "package:resellify/product_detail.dart";
import "package:resellify/sellingform.dart";
import "package:resellify/validator_form.dart";

import "dataStore/handelLocalStorageData.dart";
// import "package:google_fonts/google_fonts.dart";

class validator extends StatefulWidget {
  const validator({Key? key}) : super(key: key);
  @override
  State<validator> createState() => _validator();
}

class _validator extends State<validator> {
  List<dynamic> productsList = [];
  List<Widget> productsListWidget = [];
  Timer? _timer;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    getchData();
  }

  @override
  void initState() {
    super.initState();
    // Fetch data initially and then set up a timer to fetch data periodically
    getchData();
    _timer = Timer.periodic(Duration(seconds: 2), (Timer timer) {
      getchData(); // Fetch data every 10 seconds (adjust the interval as needed)
    });
  }

  @override
  void dispose() {
    super.dispose();
    _timer?.cancel(); // Cancel the timer when the widget is disposed
  }

  void getchData() async {
    try {
      print("fetching data");
      final response = await http.get(Uri.parse(
        "http://localhost/api/phpBackEnd/src/product.php?route=validator",
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
                                    child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      product?["productName"].toUpperCase() ??
                                          "",
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () async {
                                        Navigator.pushNamed(
                                            context, '/myValidation',
                                            arguments: {
                                              "productId": product?["id"]
                                            });
                                      },
                                      icon: Icon(Icons.more_vert),
                                    ),
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
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.currency_rupee,
                                        color: Color(0xFF140A8C),
                                      ),
                                      SizedBox(width: 2.0, height: 2.0),
                                      Text(product?["price"].toString() ?? " ")
                                    ],
                                  ),
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
        body: Container(
            color: Color(0xFFDAEAFD),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 20, right: 20),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Row(
                        children: [
                          IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: Icon(
                                Icons.arrow_back,
                                color: Color(0xFF140A8C),
                              )),
                          SizedBox(
                            width: 20,
                          ),
                          Text(
                            "Products to be validated",
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.w500,
                            ),
                            // style: GoogleFonts.coustard(
                            //   fontSize: 32.0,
                            //   // fontWeight: FontWeight.bold,
                            //   color: Color(0xFF140A8C),
                            // ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  ...productsListWidget,
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
                ],
              ),
            )),
      ),
      routes: {
        "/myValidation": (context) => const Vform(),
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
