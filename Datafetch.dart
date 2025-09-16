import 'dart:async';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lottie/lottie.dart';
import 'package:resellify/dataStore/handelLocalStorageData.dart';
// import 'package:resellify1/try1.dart';
import 'dart:convert';

import 'chatting (1).dart';

class DataFetchingScreen extends StatefulWidget {
  const DataFetchingScreen({Key? key}) : super(key: key);

  @override
  State<DataFetchingScreen> createState() => _DataFetchingScreenState();
}

class Product1 {
  final String recname;
  final String productid;
  final String sellerid;
  final String userid;
  final String chatroom;

  Product1({
    required this.recname,
    required this.productid,
    required this.sellerid,
    required this.userid,
    required this.chatroom,
  });
}

class _DataFetchingScreenState extends State<DataFetchingScreen> {
  List<Product1> products = [];

  Timer? _timer;
  @override
  void initState() {
    super.initState();
    // _timer = Timer.periodic(Duration(seconds: 10), (Timer timer) {
    //   fetchData();
    // });

    fetchData(); // Fetch data every 10 seconds (adjust the interval as needed)
  }

// here user id name should be changed
  dynamic userid = "";
  Future<void> fetchData() async {
    final url = 'http://localhost/api/phpBackEnd/src/get_chats.php';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      List<dynamic> decodedResponse = jsonDecode(response.body);

      print(decodedResponse);

      List<Product1> products = [];

      for (var i = 0; i < decodedResponse.length; i++) {
        dynamic row = decodedResponse[i];
        dynamic firstPartyId = row["firstparty"];
        dynamic secondPartyId = row["secondparty"];
        String recname = "";

        if (firstPartyId == await getLocalFataByKey("userId")) {
          recname = row['secondpartyname'];
        } else if (secondPartyId == await getLocalFataByKey("userId")) {
          recname = row['firstpartyname'];
        }

        if (recname.isNotEmpty) {
          products.add(Product1(
            recname: recname,
            productid: row['productid'].toString(),
            sellerid: row['sellerid'].toString(),
            userid: row['firstpartyid'].toString(),
            chatroom: row['chatroomid'].toString(),
          ));
        }
      }

      setState(() {
        this.products = products;
      });

      print(products);
      for (int i = 0; i < products.length; i++) {
        print(products[i].recname);
      }
    } else {
      print('Failed to fetch products: ${response.statusCode}');
    }
  }

// CircularProgressIndicator()
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: products.isEmpty
          ? Center(child: Lottie.asset("images/notfound.json"))
          : chatting1(products: products),
    );
  }
}

class chatting1 extends StatelessWidget {
  final List<Product1> products;

  const chatting1({Key? key, required this.products}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorSchemeSeed: const Color(0xff6750a4),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Color(0xFFDAEAFD),
        body: Container(
          color: Color(0xFFDAEAFD),
          child: ListView(
            shrinkWrap: true,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 20, left: 10, right: 10),
                child: Row(
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(
                          Icons.arrow_back,
                          color: Color(0XFF1E1592),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text("ReSellify"),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: Container(
                  color: Color(0xFFD9D9D9),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      TextButton(onPressed: () {}, child: Text("ALL CHATS")),
                      // TextButton(onPressed: () {}, child: Text("BUYING")),
                      // TextButton(onPressed: () {}, child: Text("SELLING")),
                    ],
                  ),
                ),
              ),
              ListView.builder(
                shrinkWrap: true,
                itemCount: products.length,
                itemBuilder: (context, index) {
                  return FilledCardExample(
                    receiverName: products[index].recname,
                    chatroomid: products[index].chatroom,
                    pid1: products[index].productid,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class FilledCardExample extends StatelessWidget {
  final String receiverName;
  final String chatroomid;
  final String pid1;
  const FilledCardExample(
      {Key? key,
      required this.receiverName,
      required this.chatroomid,
      required this.pid1})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        clipBehavior: Clip.hardEdge,
        child: InkWell(
          splashColor: Colors.blue.withAlpha(30),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                // shashanks error is due to this
                builder: (context) => chatpage(
                  receiverName: receiverName,
                  chatid: chatroomid,
                  pid: pid1,
                ),
              ),
            );
          },
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.person_2),
                title: Text(
                  receiverName.toUpperCase(),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.black,
                  ),
                ),
                subtitle: Text('CHECK FOR NEW MESSAGES......!'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
