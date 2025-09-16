import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:resellify/dataStore/basic.dart';

import 'otpPage.dart';

// import 'product_detail.dart';

class chatpage12 extends StatefulWidget {
  const chatpage12({Key? key}) : super(key: key);

  @override
  State<chatpage12> createState() => _histState();
}

class Product {
  final String productName;
  final String productPic;
  final String productDescription;

  Product({
    required this.productName,
    required this.productPic,
    required this.productDescription,
  });
}

class _histState extends State<chatpage12> {
  List<Product> _products = [];
  // Map<int, String> chat1 = {
  //   0: "hi, sir can i get a reduction in price",
  //   1: "sure sir",
  //   2: "we will help you with that",
  //   3: "I will get in touch with you, sir",
  // };
  List<Map<String, dynamic>> chatData = [];
  Future<void> fetchData() async {
    const url = 'http://localhost/api/phpBackEnd/src/temp.php';
    // final url = 'http://192.168.1.41/dashboard/apiconnection/getdata.php';
    final response = await http.get(Uri.parse(url));

    print(response);
    var data = jsonDecode(response.body);
    print(data);

    // if (response.statusCode == 200) {
    //   List<dynamic> decodedResponse = jsonDecode(response.body);
    setState(() {
      chatData = List<Map<String, dynamic>>.from(data);
    });
    // } else {
    //   print('Failed to fetch data: ${response.statusCode}');
    // }
  }

  Future<List<Product>> fetchProducts() async {
    final url = 'http://localhost/api/phpBackEnd/src/get_products.php?pid=10';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      List<dynamic> decodedResponse = jsonDecode(response.body);
      List<Product> products = decodedResponse
          .map((item) => Product(
                productName: item['productName'],
                productPic: item['images'],
                productDescription: item['description'],
              ))
          .toList();

      return products;
    } else {
      print('Failed to fetch products: ${response.statusCode}');
      return [];
    }
  }

  @override
  void initState() {
    super.initState();
    fetchData();
    fetchProducts().then((products) {
      if (products.isNotEmpty) {
        setState(() {
          _products = products;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
          color: Color(0XFFDAEAFD),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 20, left: 20),
                child: Row(
                  children: [
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
                    Align(
                      alignment: Alignment.topLeft,
                      child: Icon(Icons.person, color: Colors.indigoAccent),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 20),
                      child: Text("Person1"),
                    ),
                  ],
                ),
              ),
              FilledCardExample(product: _products.first),
              Expanded(
                child: ListView.builder(
                  itemCount: chatData.length,
                  itemBuilder: (context, index) {
                    return chatdemo(
                      index: index,
                      chatMap: chatData,
                    );
                  },
                ),
              )
            ],
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          color: Color(0xFFBFC1DB),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                      hintText: '   Type Here....',
                      border: InputBorder.none,
                      fillColor: Colors.white),
                ),
              ),
              IconButton(
                icon: Icon(Icons.send, color: Color(0xFF140A8C)),
                onPressed: () {
                  // return Container();
                },
              ),
            ],
          ),
        ),
      ),
      routes: {
        // '/details': (context) => product(),
      },
    );
  }
}

class chatdemo extends StatelessWidget {
  final int index;
  final List<Map<String, dynamic>> chatMap;

  const chatdemo({
    Key? key,
    required this.index,
    required this.chatMap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final sender = chatMap[index]['sender'] ?? '';
    final message = chatMap[index]['message'] ?? '';
    BasicModel basicModel = BasicModel();
    print("$sender , ${basicModel.getUserId()}");
    print(sender == 10);
    // bool isSenderSharath = sender == basicModel.getUserId();
    // bool isSenderSharath = sender == VerifyOtpByEmail.id;
    bool isSenderSharath = sender == '10';
    TextAlign alignment = isSenderSharath ? TextAlign.right : TextAlign.left;

    return Container(
      alignment: isSenderSharath ? Alignment.centerRight : Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Text(
          message,
          textAlign: alignment,
          style: TextStyle(color: Color(0XFF2C1AFF)),
        ),
      ),
    );
  }
}

class FilledCardExample extends StatelessWidget {
  final Product product; // Accept the product as input

  const FilledCardExample({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: [
        // ignore: unnecessary_null_comparison
        if (product != null)
          Center(
            child: Card(
              clipBehavior: Clip.hardEdge,
              child: InkWell(
                splashColor: Colors.blue.withAlpha(30),
                onTap: () {
                  // Navigator.pushNamed(context, '/details');
                },
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    ListTile(
                      leading: SizedBox(
                        width: 150.0,
                        height: 112.0,
                        child: Image.network(product.productPic),
                      ),
                      title: Text(product.productName),
                      subtitle: Text(product.productDescription),
                    ),
                  ],
                ),
              ),
            ),
          )
        else
          Center(
            child: Text('No product available'), // Placeholder for no product
          ),
      ],
    );
  }
}
