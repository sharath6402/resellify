// import 'dart:async';
// import 'dart:typed_data';
// import 'dart:convert';
// import 'dart:html' as html;
// import 'package:http/http.dart' as http;
// import 'package:flutter/material.dart';
// import 'package:resellify/dataStore/handelLocalStorageData.dart';

// class ImagePickerApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: Scaffold(
//         body: MyGridView(),
//       ),
//     );
//   }
// }

// class MyGridView extends StatefulWidget {
//   @override
//   _MyGridViewState createState() => _MyGridViewState();
// }

// class _MyGridViewState extends State<MyGridView> {
//   List<Uint8List> _imageDataList = [];
//   List<String> _fileNames = [AsyncError];

//   void uploadImage(apiUrl, imagePath, arguments) async {
//     var request = http.MultipartRequest('POST', Uri.parse(apiUrl));

//     // Add the image to the request
//     request.files.add(await http.MultipartFile.fromPath('image', imagePath));

//     // Add other data to the request
//     // request.fields
//     // .addAll({"token": await getLocalData(), "id": arguments["id"]});

//     // Send the request and get the response
//     var response = await request.send();

//     // Get the response body
//     var responseBody = await response.stream.bytesToString();

//     // Handle the response
//     if (response.statusCode == 200) {
//       // Request successful
//       print("Response: $responseBody");
//     } else {
//       // Request failed
//       print("Error: ${response.reasonPhrase}");
//     }
//   }

//   void _pickImage() async {
//     final html.FileUploadInputElement input = html.FileUploadInputElement();
//     input.accept = 'image/*';
//     input.click();

//     input.onChange.listen((e) {
//       print("===================================>");
//       final html.File file = input.files!.first;
//       final html.FileReader reader = html.FileReader();

//       reader.onLoadEnd.listen((e) {
//         print("onload");
//         print(e.type);
//         print(e.target);
//         print(e.path);
//         setState(() async {
//           _imageDataList.add(await Base64Decoder()
//               .convert(reader.result.toString().split(',').last));
//           print("file");
//           print(_imageDataList);
//           _fileNames.add(file.name);
//           print("file");
//           print(file);
//         });
//       });

//       reader.readAsDataUrl(file);
//       print(reader);
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     //bro elli add listview and place other details
//     Map<String, dynamic> arguments =
//         ModalRoute.of(context)!.settings.arguments as dynamic;
//     return GridView.count(
//       crossAxisCount: 3,
//       crossAxisSpacing: 8.0,
//       mainAxisSpacing: 8.0,
//       padding: EdgeInsets.all(8.0),
//       children: List.generate(
//         6,
//         (index) => GestureDetector(
//           onTap: _pickImage,
//           child: Container(
//             color: Colors.blueGrey[200],
//             child: Center(
//               child: _imageDataList.length > index
//                   ? Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Image.memory(
//                           _imageDataList[index],
//                           height: 100,
//                           width: 100,
//                         ),
//                         SizedBox(height: 8),
//                         TextButton(
//                           onPressed: () {},
//                           child: Text(
//                             _fileNames[index],
//                             style: TextStyle(fontSize: 16, color: Colors.black),
//                           ),
//                         ),
//                       ],
//                     )
//                   : Icon(Icons.add_a_photo),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
