// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatefulWidget {
//   @override
//   _MyAppState createState() => _MyAppState();
// }

// class _MyAppState extends State<MyApp> {
//   File? _imageFile;

//   Future<void> _openCamera() async {
//     final imagePicker = ImagePicker();
//     final pickedImage = await imagePicker.pickImage(source: ImageSource.camera);

//     setState(() {
//       _imageFile = File(pickedImage!.path);
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: Text('Camera Preview'),
//         ),
//         body: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               if (_imageFile != null)
//                 Image.file(
//                   _imageFile!,
//                   width: 300,
//                   height: 300,
//                 ),
//               ElevatedButton(
//                 onPressed: _openCamera,
//                 child: Text('Open Camera'),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
