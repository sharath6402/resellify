import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:resellify/api.dart';
import 'package:resellify/dataStore/basic.dart';
import 'package:resellify/dataStore/handelLocalStorageData.dart';
import 'package:resellify/src/common_widgets/dropDownField.dart';
import 'package:resellify/src/common_widgets/textField.dart';
import 'package:resellify/src/common_widgets/textFieldType.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import './api.dart';

class SelectedCategoryDetailsForm extends StatefulWidget {
  // SelectedCategoryDetailsForm({super.key, required this.category});
  static int producId = 7;
  @override
  State<SelectedCategoryDetailsForm> createState() => _SelectedCategoryState();
}

class _SelectedCategoryState extends State<SelectedCategoryDetailsForm> {
  Map<dynamic, dynamic> productData = {};
  bool isUpdate = false;

  List<Map<dynamic, dynamic>> formDetails = [
    {
      "tagType": "input",
      "labelKey": "category",
      "type": InputTypeEnum.text,
      "labelText": "Product's category",
      "hintText": "Enter which product does the product belongs to",
      "initialValue": "",
      "minlength": 3,
      "maxlength": 20,
      "errorText": "",
      "isRequired": true,
      "onSubmitted": (value) => {print("number => $value")},
    },
    {
      "tagType": "input",
      "labelKey": "Model",
      "type": InputTypeEnum.text,
      "labelText": "Product's Model",
      "hintText": "Enter products model ",
      "initialValue": "",
      "minlength": 3,
      "maxlength": 20,
      "errorText": "",
      "isRequired": true,
      "onSubmitted": (value) => {print("number => $value")},
    },
    {
      "tagType": "input",
      "type": InputTypeEnum.text,
      "labelText": "Title",
      "labelKey": "title",
      "hintText": "Enter Title",
      "initialValue": "",
      "minlength": 3,
      "maxlength": 200,
      "errorText": "",
      "onSubmitted": (value) => {print("title => $value")},
      "isRequired": true,
    },
    {
      "tagType": "input",
      "labelKey": "purchasedYear",
      "type": InputTypeEnum.integer,
      "labelText": "Year Of Purchase",
      "hintText": "Enter Year Of Purchase ",
      "errorText": "",
      "max": DateTime.now().year,
      "min": 1950,
      "initialValue": "",
      "canNegititve": false,
      "isRequired": true,
      "onSubmitted": (value) => {print("number => $value")},
    },
    // {
    //   "tagType": "input",
    //   "labelKey": "kmDriven",
    //   "type": InputTypeEnum.float,
    //   "labelText": "KM Driven",
    //   "hintText": "Enter KM Driven",
    //   "initialValue": "",
    //   "errorText": "",
    //   "canNegititve": false,
    //   "max": 1000,
    //   "min": 1,
    //   "isRequired": false,
    //   "onSubmitted": (value) => {print("KM driven => $value")},
    // },

    {
      "tagType": "input",
      "labelKey": "noOfOwner",
      "type": InputTypeEnum.integer,
      "labelText": "Number Of Owners",
      "hintText": "Enter Number Of Owner",
      "initialValue": "",
      "errorText": "",
      "canNegititve": false,
      "max": 5,
      "min": 1,
      "isRequired": true,
      "onSubmitted": (value) => {print("Number Of Owner => $value")},
    },
    {
      "tagType": "input",
      "type": InputTypeEnum.text,
      "labelKey": "location",
      "labelText": "Location",
      "hintText": "Enter location",
      "initialValue": "",
      "minlength": 3,
      "maxlength": 2000,
      "errorText": "",
      "onSubmitted": (value) => {print("Name => $value")},
      "isRequired": true,
    },
    {
      "tagType": "input",
      "type": InputTypeEnum.float,
      "labelKey": "price",
      "labelText": "Price",
      "hintText": "Enter price",
      "initialValue": "",
      "min": 0,
      "errorText": "",
      "onSubmitted": (value) => {print("Name => $value")},
      "isRequired": true,
    },
    {
      "tagType": "input",
      "type": InputTypeEnum.text,
      "labelKey": "description",
      "labelText": "Description",
      "hintText": "Enter Description",
      "initialValue": "",
      "minlength": 3,
      "maxlength": 2000,
      "errorText": "",
      "onSubmitted": (value) => {print("Name => $value")},
      "isRequired": false,
      "isDesciption": true,
    }
  ];
  final TextEditingController _nameController = TextEditingController(text: "");
  // final TextEditingController _ageController = TextEditingController();

  // customApi cstApi =customApi();
  // fetch()

  BasicModel basicModel = BasicModel();
  // Map<String, dynamic> arguments = {};

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    // fetchData();
  }

  @override
  Widget build(BuildContext context) {
    // here we are getting / retriving parameter
    print("selected cat.");

    final formKey = GlobalKey<FormState>();
    String someNumber = "";

    var widgetList = [];
    for (int i = 0; i < formDetails.length; i++) {
      switch (formDetails[i]["tagType"]) {
        case "input":
          widgetList.add(CustomTextField(
            borderRadious: 10,
            fontSize: 18,
            isDesciption: formDetails[i]['isDesciption'],
            isRequired: formDetails[i]['isRequired'],
            minlength: formDetails[i]['minlength'],
            min: formDetails[i]['min'],
            maxlength: formDetails[i]['maxlength'],
            max: formDetails[i]['max'],
            canNegititve: formDetails[i]['canNegititve'],
            hintText: formDetails[i]['hintText'] as String,
            labelText: formDetails[i]['labelText'] as String,
            errorText: formDetails[i]["errorText"] as String,
            onSubmitted: (value) => {
              print("submitted value $value"),
              setState(() {
                productData[formDetails[i]["labelKey"]] = value["data"];
                formDetails[i]["errorText"] = "value";
              }),
              print(formDetails[0]["labelKey"]),
            },
            type: formDetails[i]["type"],
            initialValue: formDetails[i]["initialValue"] as String,
          ));
          break;
        case "select":
          widgetList.add(
            const customDropDownField(
              labelText: 'category',
              option: ["option1", "option2", "option3"],
              selectedOption: 'option1',
            ),
          );
          break;
        default:
      }
    }

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: const Color(0xFFDAEAFD),
        body: ListView(children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  // top bar of form
                  Container(
                    margin: const EdgeInsets.only(
                      bottom: 25,
                    ),
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(Icons.keyboard_backspace),
                        ),
                        Container(
                          margin: const EdgeInsets.only(left: 5),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text(
                                "Fill below details",
                                style: TextStyle(fontSize: 18),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  ...widgetList,
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
                          width: 20.0,
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
                            onPressed: () async {
                              print("$someNumber");
                              print(
                                "formKey.currentState!.validate()=> ${formKey.currentState!.validate()}",
                              );
                              if (formKey.currentState!.validate()) {
                                formKey.currentState!.save();
                                // Perform form submission or other actions here
                                print("productData====>  $productData");
                                print("create");
                                // dynamic token = await basicModel.getToken();
                                dynamic token = await getLocalData();
                                print(token);
                                // print(token2);
                                http.Response result = await http.post(
                                    Uri.parse(
                                        "http://localhost/api/phpBackEnd/src/product.php?route=step-one"),
                                    body: jsonEncode({
                                      ...productData,
                                      "productName": productData["title"],
                                      "token": token
                                    }),
                                    headers: {
                                      'Content-Type': 'application/json',
                                      "Accept": "application/json",
                                      "Access-Control_Allow_Origin": "*"
                                    });
                                // Map<String, dynamic> responseMap = jsonDecode(jsonResponse);
                                print(result.body);
                                var data = jsonDecode(result.body);
                                print(data);

                                print(data["status"]);
                                print(data["data"]["data"]["id"]);
                                SelectedCategoryDetailsForm.producId =
                                    data["data"]["data"]["id"];
                                if (data["status"] == "sucess") {
                                  Fluttertoast.showToast(
                                      msg: data["message"],
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.BOTTOM_LEFT,
                                      timeInSecForIosWeb: 2,
                                      backgroundColor: Colors.blueAccent[200],
                                      textColor: const Color.fromARGB(
                                          255, 255, 255, 255),
                                      webBgColor:
                                          "linear-gradient(to right, #00b09b, #96c93d)",
                                      fontSize: 13);
                                  // ignore: use_build_context_synchronously
                                  Navigator.pushNamed(
                                    context,
                                    '/ImagePickerApp',
                                  );
                                } else {
                                  Fluttertoast.showToast(
                                      msg: data["message"],
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.BOTTOM_LEFT,
                                      timeInSecForIosWeb: 2,
                                      backgroundColor:
                                          Color.fromARGB(255, 235, 121, 106),
                                      textColor:
                                          Color.fromARGB(255, 255, 255, 255),
                                      webBgColor:
                                          "linear-gradient(to right, #f06449, #e62739)",
                                      fontSize: 13);
                                }
                              }
                            },
                            child: Text(
                              isUpdate ? "Update" : "Save",
                              style: const TextStyle(
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
          ),
        ]),
      ),
    );
  }
}
