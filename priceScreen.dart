import 'package:flutter/material.dart';
import 'package:resellify/src/common_widgets/dropDownField.dart';
import 'package:resellify/src/common_widgets/textField.dart';
import 'package:resellify/src/common_widgets/textFieldType.dart';

class PriceForm extends StatefulWidget {
  const PriceForm({super.key});
  @override
  State<PriceForm> createState() => _SelectedCategoryState();
}

class _SelectedCategoryState extends State<PriceForm> {
  List<Map<dynamic, dynamic>> formDetails = [
    {
      "tagType": "input",
      "type": InputTypeEnum.float,
      "labelText": "Price",
      "hintText": "Enter amount in ₹",
      "errorText": "",
      "min": 0,
      "initialValue": "",
      "canNegititve": false,
      "isRequired": true,
      "onSubmitted": (value) => {print("number => $value")},
    },
  ];
  final TextEditingController _nameController = TextEditingController(text: "");
  // final TextEditingController _ageController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // here we are getting / retriving parameter
    final category = ModalRoute.of(context)?.settings.arguments;
    print(category);
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
                formDetails[0]["errorText"] = "value";
              })
            },
            type: formDetails[i]["type"],
            initialValue: formDetails[i]["initialValue"] as String,
          ));
          break;
        case "select":
          widgetList.add(
            const customDropDownField(
              labelText: 'Brand/Model',
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
                          onPressed: () {},
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
                            onPressed: () {
                              print("$someNumber");
                              print(
                                "formKey.currentState!.validate()=> ${formKey.currentState!.validate()}",
                              );
                              if (formKey.currentState!.validate()) {
                                formKey.currentState!.save();
                                // Perform form submission or other actions here
                                print(_nameController.selection);
                                print(_nameController.text);
                                print(_nameController.value);
                              }
                            },
                            child: const Text(
                              'Save',
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
          ),
        ]),
      ),
    );
  }
}
