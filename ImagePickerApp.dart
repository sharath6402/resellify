import 'dart:typed_data';
import 'dart:convert';
import 'dart:html' as html;
import 'package:http/http.dart' as http;
import 'package:dotted_border/dotted_border.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
import 'package:resellify/SelectedCategoryDetailsForm.dart';
import 'package:resellify/dataStore/handelLocalStorageData.dart';
import 'package:resellify/myProduct.dart';

import 'home.dart';

// void main() {
//   runApp(ImagePickerApp());
// }

class ImagePickerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/home': (context) => MyApp1(),
      },
      home: Scaffold(
        body: MyGridView(),
      ),
    );
  }
}

class MyGridView extends StatefulWidget {
  @override
  _MyGridViewState createState() => _MyGridViewState();
}

class _MyGridViewState extends State<MyGridView> {
  List<Uint8List> _imageDataList = [];
  List<String> _imageType = [];
  List<String> _fileNames = [];
  List<dynamic> _uploadedImages = [];

  Future() async {
    print(getLocalFataByKey("id"));
  }

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   getUploadedImages();
  // }

  void getUploadedImages() async {
    try {
      // SelectedCategoryDetailsForm.producId.toString()
      http.Response result = await http.post(
          Uri.parse(
              "http://localhost/api/phpBackEnd/src/product.php?route=get-uploaded-images&token=${await getLocalData()}&id=${SelectedCategoryDetailsForm.producId.toString()}"),
          headers: {
            'Content-Type': 'application/json',
            "Accept": "application/json",
            "Access-Control_Allow_Origin": "*"
          });
      print(result);
      dynamic responseMap = jsonDecode(result.body);

      print(responseMap["data"]);
      setState(() {
        _uploadedImages = responseMap["data"];
      });
    } catch (er) {
      print(er);
    }
  }

  void _pickImage() async {
    final html.FileUploadInputElement input = html.FileUploadInputElement();
    input.accept = 'image/*';
    input.click();

    input.onChange.listen((e) {
      final html.File file = input.files!.first;
      final html.FileReader reader = html.FileReader();

      reader.onLoadEnd.listen((e) {
        uploadImage(
            Base64Decoder().convert(reader.result.toString().split(',').last),
            file.name);
        // setState(() {
        //   _imageDataList.add(Base64Decoder()
        //       .convert(reader.result.toString().split(',').last));
        //   _fileNames.add(file.name);
        // });
      });

      reader.readAsDataUrl(file);
    });
  }

  void uploadImage(imageData, filename) async {
    // print(await getLocalData(imageData, filename));
    try {
      // SelectedCategoryDetailsForm.producId.toString()
      var request = http.MultipartRequest(
        'POST',
        Uri.parse(
            "http://localhost/api/phpBackEnd/src/product.php?route=step-two&token=${await getLocalData()}&id=${SelectedCategoryDetailsForm.producId.toString()}"),
      );
      // request.fields['token'] = ;
      // request.fields['id'] =;
      request.files.add(
        http.MultipartFile.fromBytes(
          'images',
          imageData,
          filename: filename,
        ),
      );
      dynamic response = await request.send();
      print(response);

      if (response != null) {
        Fluttertoast.showToast(
            msg: "Uploaded sucess full",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM_LEFT,
            timeInSecForIosWeb: 2,
            backgroundColor: Colors.blueAccent[200],
            textColor: const Color.fromARGB(255, 255, 255, 255),
            webBgColor: "linear-gradient(to right, #00b09b, #96c93d)",
            fontSize: 13);

        // Navigator.pushNamed(context, '/home');
        _imageDataList = [];
        _imageType = [];
        _fileNames = [];
        getUploadedImages();
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    //bro elli add listview and place other details
    print("SelectedCategoryDetailsForm.producId");
    print(SelectedCategoryDetailsForm.producId);
    return GestureDetector(
      child: ListView(
        children: [
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(
                        bottom: 10,
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
                                  "Upload Images",
                                  style: TextStyle(fontSize: 18),
                                ),
                                // Text(
                                //   "",
                                //   style: TextStyle(
                                //     fontSize: 16,
                                //     color: Colors.black54,
                                //   ),
                                // ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(10.0),
                      child: DottedBorder(
                        color: Colors.black54,
                        strokeWidth: 1,
                        dashPattern: const [5, 5, 5, 5],
                        child: Container(
                            width: double.infinity,
                            height: 200,
                            padding: const EdgeInsets.symmetric(vertical: 50),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("Upload your product image"),
                                IconButton(
                                  onPressed: _pickImage,
                                  icon: const Icon(Icons.upload_file),
                                ),
                              ],
                            )),
                      ),
                    ),
                  ],
                ),
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.all(10.0),
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                        const Color.fromRGBO(169, 214, 255, 1),
                      ),
                    ),
                    onPressed: () => {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          // shashanks error is due to this
                          builder: (context) => const myproduct(),
                        ),
                      ),
                      // Navigator.pushNamed(context, '/MyProduct'),
                    },
                    child: const Text(
                      "Submit",
                      style: TextStyle(
                        color: Color.fromRGBO(30, 20, 146, 1),
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 400.0,
                  // margin: const EdgeInsets.all(10.0),
                  child: GridView.count(
                    crossAxisCount: _uploadedImages.length > 0 ? 2 : 1,
                    crossAxisSpacing: 3.0,
                    mainAxisSpacing: 3.0,
                    // padding: EdgeInsets.all(8.0),
                    children: List.generate(
                      _uploadedImages.length > 0 ? _uploadedImages.length : 1,
                      (index) {
                        return Center(
                          child: Container(
                            decoration:
                                BoxDecoration(border: Border.all(width: 1.0)),
                            // color: _imageDataList.length ==0? Color.fromARGB(255, 217, 224, 228),
                            child: _uploadedImages.length > index
                                ? Image.network(
                                    _uploadedImages?[index]['url'] as String,
                                    fit: BoxFit.fill,
                                    width: double.infinity,
                                    height: 200.0,
                                  )
                                // Image.memory(
                                //     _imageDataList[index],
                                //     // height: 100,
                                //     // width: 150,
                                //   )
                                : const Text(
                                    "No image Uploaded",
                                    style: TextStyle(fontSize: 18),
                                  ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
      onTap: () => {null},
    );
  }
}
