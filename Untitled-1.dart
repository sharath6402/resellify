import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'dataStore/handelLocalStorageData.dart';
// import 'package:resellify1/chatpage.dart';

// import 'product_detail.dart';
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

class chatpage extends StatefulWidget {
  final String receiverName;
  final String chatid;
  final String pid;
  const chatpage(
      {Key? key,
      required this.receiverName,
      required this.chatid,
      required this.pid})
      : super(key: key);
  @override
  State<chatpage> createState() => _histState();
}

class _histState extends State<chatpage> {
  List<Product> _products = [];
  dynamic senderName = "";

  List<Map<String, dynamic>> chatData = [];
  final TextEditingController _messageController = TextEditingController();
  // changes  to be made

  Future<void> fetchData() async {
    print(widget.chatid);
    print("===============sender");
    print(senderName);
    final url = 'http://localhost/api/phpBackEnd/src/get_message.php';
    print(widget.chatid);
    final response =
        await http.post(Uri.parse(url), body: {'cid': widget.chatid});
    print(widget.chatid);
    print('Response Body: ${response.body}');

    if (response.statusCode == 200) {
      List<dynamic> decodedResponse = jsonDecode(response.body);
      setState(() {
        chatData = List<Map<String, dynamic>>.from(decodedResponse);
      });
    } else {
      print('Failed to fetch data: ${response.statusCode}');
    }
  }

  Future<void> getDataSenderName() async {
    try {
      dynamic userId = await getLocalFataByKey("userId");
      final response = await http.get(Uri.parse(
        "http://localhost/api/phpBackEnd/src/user.php?route=get-user-data&userId=$userId",
      ));
      var data = jsonDecode(response.body);
      print(data["data"][0]["name"]);

      senderName = data["data"]?[0]?["name"] ?? "";
    } catch (err) {
      print(err);
    }
  }

  Future<void> sendMessage(String message, String sender) async {
    final url = 'http://localhost/api/phpBackEnd/src/insert_message.php';
    final response = await http.post(Uri.parse(url),
        body: {'message': message, 'sender': sender, 'cid': widget.chatid});
    print(response.statusCode);
    if (response.statusCode == 200) {
      print('Message sent successfully');
      setState(() {
        // Update the chatData with the new message
        chatData.add({'sender': sender, 'message': message});
      });
    } else {
      print('Failed to send message: ${response.statusCode}');
    }
  }

// not using this method in future
  Future<List<Product>> fetchProducts(String prodid) async {
    final url = 'http://192.168.1.41/dashboard/apiconnection/get_products.php';
    final response = await http.post(Uri.parse(url), body: {
      'prodid': int.parse(prodid),
    });

    if (response.statusCode == 200) {
      List<dynamic> decodedResponse = jsonDecode(response.body);
      List<Product> products = decodedResponse
          .map((item) => Product(
                productName: item['productname'],
                productPic: item['productimage'],
                productDescription: item['productdescription'],
              ))
          .toList();
      print(products);

      return products;
    } else {
      print('Failed to fetch products: ${response.statusCode}');
      return [];
    }
  }

  // @override
  // void initState() {
  //   super.initState();
  //   fetchData();
  // }
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    // Fetch data initially and then set up a timer to fetch data periodically
    fetchData();
    getDataSenderName();
    _timer = Timer.periodic(Duration(seconds: 10), (Timer timer) {
      fetchData(); // Fetch data every 10 seconds (adjust the interval as needed)
    });
    // fetchProducts(pid.toString()).then((products) {
    //   if (products.isNotEmpty) {
    //     setState(() {
    //       _products = products;
    //     });
    //   }
    // });
  }

  @override
  void dispose() {
    super.dispose();
    _timer?.cancel(); // Cancel the timer when the widget is disposed
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
                      child: Text(widget.receiverName),
                    ),
                  ],
                ),
              ),
              // FilledCardExample(product: _products.first),
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
                // changes start
                child: Padding(
                    padding: EdgeInsets.only(left: 15),
                    child: TextFormField(
                      controller: _messageController,
                      decoration: InputDecoration(
                          hintText: '   Type Here....',
                          border: InputBorder.none,
                          fillColor: Colors.white),
                    )),
              ),
              IconButton(
                icon: Icon(Icons.send, color: Color(0xFF140A8C)),
                onPressed: () {
                  // here login user name
                  sendMessage(_messageController.text, "Shashank P");
                  _messageController.clear();
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
//here login person name should
    bool isSenderSharath = sender == 'Shashank P';
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
