import "dart:convert";
import 'package:http/http.dart' as http;

import "package:flutter/material.dart";
import "package:resellify/home.dart";

import "dataStore/handelLocalStorageData.dart";
// import "package:google_fonts/google_fonts.dart";

class userDetails extends StatefulWidget {
  const userDetails({Key? key}) : super(key: key);
  @override
  State<userDetails> createState() => _userState();
}

class _userState extends State<userDetails> {
  dynamic name = "";
  dynamic email = "";
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
      dynamic userId = await getLocalFataByKey("userId");
      final response = await http.get(Uri.parse(
        "http://localhost/api/phpBackEnd/src/user.php?route=get-user-data&userId=$userId",
      ));
      var data = jsonDecode(response.body);
      print(data["data"][0]["name"]);

      setState(() {
        name = data["data"]?[0]?["name"] ?? "name";
        email = data?["data"]?[0]?["email"] ?? "email";
      });
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
    print(name);
    print(email);

    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            body: Container(
          color: Color(0xFFDAEAFD),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 20, left: 20),
                child: Row(
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              // shashanks error is due to this
                              builder: (context) => const MyApp1(),
                            ),
                          );
                        },
                        icon: Icon(
                          Icons.arrow_back,
                          color: Color(0XFF140A8C),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "ReSellify",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0,
                          ),
                          // style:style1
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.zero,
                child: Container(
                  height: 100,
                  child: Align(
                    alignment: Alignment.center,
                    child: SizedBox(
                      width: double.infinity,
                      child: IconButton(
                        icon: Icon(
                          Icons.account_circle,
                          color: Colors.deepPurpleAccent,
                        ),
                        iconSize: 100,
                        onPressed: () {},
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 20),
                child: Column(
                  children: [
                    Align(
                        alignment: Alignment.center,
                        child: TextButton(
                            onPressed: () {},
                            child: Text(name,
                                style: TextStyle(color: Colors.indigoAccent)))),
                    Align(
                      alignment: Alignment.center,
                      child: TextButton(
                          onPressed: () {},
                          child: Text(
                            email,
                            style: TextStyle(color: Colors.indigoAccent),
                          )),
                    ),
                    ListView(
                      shrinkWrap: true,
                    ),
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: Container(
                        color: Color(0XFFD9D9D9),
                        child: Padding(
                            padding: EdgeInsets.only(top: 5, bottom: 5),
                            child: ListTile(
                              leading: Icon(
                                Icons.favorite,
                                color: Color(0XFF140A8C),
                                size: 40,
                              ),
                              title: TextButton(
                                onPressed: () {
                                  Navigator.popAndPushNamed(context, '/cart');
                                },
                                child: Text("MY INTEREST"),
                              ),
                              trailing: IconButton(
                                onPressed: () {
                                  Navigator.popAndPushNamed(context, '/cart');
                                },
                                icon: Icon(
                                  Icons.chevron_right,
                                  color: Color(0XFF140A8C),
                                ),
                              ),
                            )),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: Container(
                        color: Color(0XFFD9D9D9),
                        child: Padding(
                            padding: EdgeInsets.only(top: 5, bottom: 5),
                            child: ListTile(
                              leading: Icon(
                                Icons.shopping_bag,
                                color: Color(0XFF140A8C),
                                size: 40,
                              ),
                              title: TextButton(
                                onPressed: () {
                                  Navigator.popAndPushNamed(
                                      context, '/MyProduct');
                                },
                                child: Text("MY PRODUCTS"),
                              ),
                              trailing: IconButton(
                                onPressed: () {
                                  Navigator.popAndPushNamed(
                                      context, '/MyProduct');
                                },
                                icon: Icon(
                                  Icons.chevron_right,
                                  color: Color(0XFF140A8C),
                                ),
                              ),
                            )),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: Container(
                        color: Color(0XFFD9D9D9),
                        child: Padding(
                            padding: EdgeInsets.only(top: 5, bottom: 5),
                            child: ListTile(
                              leading: Icon(
                                Icons.message_outlined,
                                color: Color(0XFF140A8C),
                                size: 40,
                              ),
                              title: TextButton(
                                onPressed: () {
                                  Navigator.popAndPushNamed(
                                      context, '/newChat');
                                },
                                child: Text("MY CHATS"),
                              ),
                              trailing: IconButton(
                                onPressed: () {
                                  Navigator.popAndPushNamed(
                                      context, '/newChat');
                                },
                                icon: Icon(
                                  Icons.chevron_right,
                                  color: Color(0XFF140A8C),
                                ),
                              ),
                            )),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: Container(
                        color: Color(0XFFD9D9D9),
                        child: Padding(
                            padding: EdgeInsets.only(top: 5, bottom: 5),
                            child: ListTile(
                              leading: Icon(
                                Icons.logout_outlined,
                                color: Color(0XFF140A8C),
                                size: 40,
                              ),
                              title: TextButton(
                                onPressed: () {
                                  Navigator.popAndPushNamed(context, '/lo');
                                },
                                child: Text("LOG OUT"),
                              ),
                              trailing: IconButton(
                                onPressed: () {
                                  Navigator.popAndPushNamed(context, '/lo');
                                },
                                icon: Icon(
                                  Icons.chevron_right,
                                  color: Color(0XFF140A8C),
                                ),
                              ),
                            )),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        )));
  }
}
