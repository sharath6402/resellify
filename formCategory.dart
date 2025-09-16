import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:resellify/topNav.dart';

import 'Category.dart';

// import 'SellingForm/Catogory.dart';

class FormCategory extends StatelessWidget {
  const FormCategory({super.key});

  @override
  Widget build(BuildContext context) {
    // final width = MediaQuery.of(context).size.width;
    // TextStyle style1;
    // TextStyle style1 = GoogleFonts.coustard(
    //   fontSize:32.0,
    //   // fontWeight:FontWeight.bold,
    //   color: Color(0xFF140A8C),
    // );
    return MaterialApp(

      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: const Color(0xFFDAEAFD),
        body: Container(
            child: Column(
              children: [

                    Padding(padding: EdgeInsets.all(20),
                     child:Row(
                       children: [
                         Align(
                           alignment: Alignment.topLeft,
                           child: IconButton(
                             onPressed: (){
                               Navigator.pop(context);
                             },
                             icon: Icon(Icons.arrow_back,color: Color(0XFF1E1592),),
                           ),
                         ),
                         Padding(padding: EdgeInsets.only(left: 10),
                         child:Align(
                           alignment: Alignment.topLeft,
                           child: Text("ReSellify",
                               // style:  style1
                           ),
                         ) ,)

                         ,
                         // Padding(
                         //   padding: EdgeInsets.only(top: 16),
                         // ),


                       ],
                     )
                    ),




                Expanded(
                  child: CategoryCard(),
                )
              ],
            )),
        // child: const topNav(),
      ),
    );
  }
}
