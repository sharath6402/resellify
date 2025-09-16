// // ignore_for_file: prefer_const_constructors

// import 'dart:io';
// import 'package:dotted_border/dotted_border.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker_plus/image_picker_plus.dart';

// class ImageUploadForm extends StatefulWidget {
//   const ImageUploadForm({super.key});

//   @override
//   State<ImageUploadForm> createState() => _ImageUploadFormState();
// }

// class _ImageUploadFormState extends State<ImageUploadForm> {
//   // late List<File> _images = [];
//   late final List<String> _images = [
//     "https://images.pexels.com/photos/90946/pexels-photo-90946.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
//     "https://images.pexels.com/photos/4099828/pexels-photo-4099828.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
//   ];
//   late List<dynamic> imagesContainer = [];

//   void takeImage() async {
//     // ImagePickerPlus uploadedImage = ImagePickerPlus(context);

//     // SelectedImagesDetails? image =
//     //     await uploadedImage.pickImage(source: ImageSource.camera);
//     // setState(() {
//     //   if (image != null) _images.add(image as File);
//     // });
//     // print(image);
//   }

//   void chooseImage() async {
//     // ImagePickerPlus uploadedImage = ImagePickerPlus(context);

//     // SelectedImagesDetails? image =
//     //     await uploadedImage.pickImage(source: ImageSource.gallery);
//     // setState(() {
//     //   if (image != null) _images.add(image as File);
//     // });
//     // print(image);
//   }

//   @override
//   Widget build(BuildContext context) {
//     for (int i = 0; i < _images.length; i++) {
//       // set
//       imagesContainer.add(_images[i]);
//     }
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: Scaffold(
//         backgroundColor: const Color(0xFFDAEAFD),
//         body: ListView(children: [
//           Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Column(
//               children: [
//                 // top nav
//                 Container(
//                   margin: const EdgeInsets.only(
//                     bottom: 25,
//                   ),
//                   child: Row(
//                     children: [
//                       IconButton(
//                         onPressed: () {},
//                         icon: const Icon(Icons.keyboard_backspace),
//                       ),
//                       Container(
//                         margin: const EdgeInsets.only(left: 5),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: const [
//                             Text(
//                               "Upload Images Of Product",
//                               style: TextStyle(fontSize: 18),
//                             ),
//                             Text(
//                               "./car",
//                               style: TextStyle(
//                                 fontSize: 16,
//                                 color: Colors.black54,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 DottedBorder(
//                   color: Colors.black54,
//                   strokeWidth: 1,
//                   dashPattern: const [5, 5, 5, 5],
//                   child: Container(
//                     width: double.infinity,
//                     height: 200,
//                     padding: const EdgeInsets.symmetric(vertical: 50),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           crossAxisAlignment: CrossAxisAlignment.center,
//                           children: const [
//                             Text("Take A Image From"),
//                             SizedBox(
//                               width: 20,
//                             ),
//                             Icon(Icons.camera_alt_outlined),
//                           ],
//                         ),
//                         Container(
//                           margin: const EdgeInsets.symmetric(vertical: 10),
//                           child: const Text(
//                             "or",
//                             style: TextStyle(
//                               color: Colors.black54,
//                             ),
//                           ),
//                         ),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           crossAxisAlignment: CrossAxisAlignment.center,
//                           children: const [
//                             Text(
//                               "Choose A Image From",
//                             ),
//                             SizedBox(
//                               width: 20,
//                             ),
//                             Icon(Icons.folder),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//                 Container(
//                   margin: const EdgeInsets.symmetric(
//                     vertical: 20,
//                   ),
//                   child: Column(
//                     children: [
//                       Container(
//                         margin: const EdgeInsets.only(bottom: 10),
//                         width: double.infinity,
//                         height: 150,
//                         decoration: BoxDecoration(
//                           border: Border.all(
//                             color: Colors.black,
//                           ),
//                         ),
//                         child: const Icon(
//                           Icons.camera_alt_outlined,
//                           size: 50,
//                         ),
//                       ),
//                       Container(
//                         width: double.infinity,
//                         height: 200,
//                         decoration: BoxDecoration(
//                           border: Border.all(
//                             color: Colors.black,
//                           ),
//                         ),
//                         child: const Icon(
//                           Icons.camera_alt_outlined,
//                           size: 50,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 Container(
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.end,
//                     children: [
//                       MouseRegion(
//                         cursor: SystemMouseCursors.click,
//                         child: GestureDetector(
//                           onTap: () {
//                             print("cancel");
//                           },
//                           child: const Text(
//                             'Cancel',
//                             style: TextStyle(color: Colors.red),
//                           ),
//                         ),
//                       ),
//                       const SizedBox(
//                         width: 20.0,
//                         height: 20,
//                       ),
//                       Container(
//                         width: 150,
//                         height: 50,
//                         child: ElevatedButton(
//                           style: ButtonStyle(
//                             backgroundColor: MaterialStateProperty.all(
//                               const Color.fromRGBO(169, 214, 255, 1),
//                             ),
//                           ),
//                           onPressed: () {},
//                           child: const Text(
//                             'Save',
//                             style: TextStyle(
//                               color: Color.fromRGBO(30, 20, 146, 1),
//                               fontSize: 18,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 )
//               ],
//             ),
//           ),
//         ]),
//       ),
//     );
//   }
// }
