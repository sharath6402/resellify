import 'package:flutter/material.dart';
// import 'package:resellify/screen/topNav.dart';

import 'formData.dart';

class CategoryCard extends StatefulWidget {
  const CategoryCard({super.key});

  @override
  State<CategoryCard> createState() => _CategoryCardState();
}

class _CategoryCardState extends State<CategoryCard> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: const Color(0xFFDAEAFD),
        body: ListView.builder(
          itemCount: categoryData.length,
          itemBuilder: (context, index) {
            return GestureDetector(
                child: Container(
              margin: const EdgeInsets.only(bottom: 10.0),
              child: ListTile(
                onTap: () {
                  print("dfdsfds");
                  // Navigator.of(context).pushNamed(
                  //   "/emailpage",
                  //   // arguments: categoryData[index]["title"],
                  // );
                  Navigator.pushNamed(context, '/selectedCategoryDetailsForm');
                },
                tileColor: Colors.white,
                selectedTileColor: Colors.amberAccent,
                // selected: true,
                leading: categoryData[index]["icon"],
                title: Text(
                  categoryData[index]["title"],
                  style: const TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                trailing: const Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.black87,
                ),
              ),
            ));
          },
        ),

        // ListView(
        //   children: [
        //
        //   ],
        // ),
      ),
      // child: const topNav(),
    );
  }
}
