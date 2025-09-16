import 'package:flutter/material.dart';
import 'package:resellify/src/common_widgets/dropDownField.dart';
import 'package:resellify/src/common_widgets/textField.dart';
import 'package:resellify/src/common_widgets/textFieldType.dart';

class FinalUploadForm extends StatefulWidget {
  const FinalUploadForm({super.key});
  @override
  State<FinalUploadForm> createState() => _SelectedCategoryState();
}

class _SelectedCategoryState extends State<FinalUploadForm> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: const Color(0xFFDAEAFD),
        body: ListView(children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // top bar of form
                Container(
                  margin: const EdgeInsets.only(
                    bottom: 25,
                  ),
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.keyboard_backspace),
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 5),
                        child: const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Fill below details",
                              style: TextStyle(fontSize: 18),
                            ),
                            Text(
                              "./car",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.black54,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                Container(
                  width: double.infinity,
                  // child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(bottom: 10),
                            padding: const EdgeInsets.all(5),
                            // decoration: BoxDecoration(
                            //   border: Border.all(color: Colors.black87),
                            // ),
                            child: Text("data :"),
                          ),
                          Container(
                            margin: const EdgeInsets.only(bottom: 10),
                            padding: const EdgeInsets.all(5),
                            // decoration: BoxDecoration(
                            //   border: Border.all(color: Colors.black87),
                            // ),
                            child: Text("data"),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(bottom: 10),
                            padding: const EdgeInsets.all(5),
                            // decoration: BoxDecoration(
                            //   border: Border.all(color: Colors.black87),
                            // ),
                            child: Text("data :"),
                          ),
                          Container(
                            margin: const EdgeInsets.only(bottom: 10),
                            padding: const EdgeInsets.all(5),
                            // decoration: BoxDecoration(
                            //   border: Border.all(color: Colors.black87),
                            // ),
                            child: Text("data"),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(bottom: 10),
                            padding: const EdgeInsets.all(5),
                            // decoration: BoxDecoration(
                            //   border: Border.all(color: Colors.black87),
                            // ),
                            child: Text("data :"),
                          ),
                          Container(
                            margin: const EdgeInsets.only(bottom: 10),
                            padding: const EdgeInsets.all(5),
                            // decoration: BoxDecoration(
                            //   border: Border.all(color: Colors.black87),
                            // ),
                            child: Text("data"),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(bottom: 10),
                            padding: const EdgeInsets.all(5),
                            // decoration: BoxDecoration(
                            //   border: Border.all(color: Colors.black87),
                            // ),
                            child: Text("data :"),
                          ),
                          Container(
                            margin: const EdgeInsets.only(bottom: 10),
                            padding: const EdgeInsets.all(5),
                            // decoration: BoxDecoration(
                            //   border: Border.all(color: Colors.black87),
                            // ),
                            child: Text("data"),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(bottom: 10),
                            padding: const EdgeInsets.all(5),
                            // decoration: BoxDecoration(
                            //   border: Border.all(color: Colors.black87),
                            // ),
                            child: Text("data :"),
                          ),
                          Container(
                            margin: const EdgeInsets.only(bottom: 10),
                            padding: const EdgeInsets.all(5),
                            // decoration: BoxDecoration(
                            //   border: Border.all(color: Colors.black87),
                            // ),
                            child: Text("data"),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(bottom: 10),
                            padding: const EdgeInsets.all(5),
                            child: Text("Uploaded Image"),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(bottom: 10),
                            width: double.infinity,
                            height: 150,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.black,
                              ),
                            ),
                            child: const Icon(
                              Icons.camera_alt_outlined,
                              size: 50,
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(bottom: 10),
                            width: double.infinity,
                            height: 150,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.black,
                              ),
                            ),
                            child: const Icon(
                              Icons.camera_alt_outlined,
                              size: 50,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                  // ),
                ),
                // bottom submit button+ cancle
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: GestureDetector(
                          onTap: () {
                            print("cancel");
                          },
                          child: const Text(
                            'Cancel',
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                        height: 20,
                      ),
                      Container(
                        width: 150,
                        height: 50,
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                              const Color.fromRGBO(169, 214, 255, 1),
                            ),
                          ),
                          onPressed: () {},
                          child: const Text(
                            'Submit',
                            style: TextStyle(
                              color: Color.fromRGBO(30, 20, 146, 1),
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
