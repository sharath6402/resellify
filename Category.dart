import 'package:flutter/material.dart';

import 'SelectedCategoryDetailsForm.dart';
import 'formData.dart';

class CategoryCard extends StatefulWidget {
  const CategoryCard({Key? key}) : super(key: key);

  @override
  State<CategoryCard> createState() => _CategoryCard();
}

class _CategoryCard extends State<CategoryCard> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: const Color(0xFFDAEAFD),
        body: ListView.builder(
          itemCount: categoryData.length,
          itemBuilder: (context2, index) {
            return Container(
              margin: const EdgeInsets.only(bottom: 10.0),
              child: GestureDetector(
                onTap: () => {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) => SelectedCategoryDetailsForm(
                  //       category: categoryData[index]["title"],
                  //     ),
                  //   ),
                  // )
                  Navigator.of(context).pushNamed(
                    "/selectedCategoryDetailsForm",
                    arguments: {
                      "category": categoryData[index]["title"].toString()
                    },
                  )
                },
                child: ListTile(
                    // onTap: () {
                    //   print("dfdsfds");
                    //   // Navigator.of(context).pushNamed(
                    //   //   "/selectedCategoryDetailsForm",
                    //   //   arguments: {"category": categoryData[index]["title"]},
                    //   // );
                    //   Navigator.pushNamedAndRemoveUntil(
                    //       context, '/home', (rute) => false);
                    //   // Navigator.pushNamed(context, '/selectedCategoryDetailsForm');
                    // },
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
                    trailing: IconButton(
                      onPressed: () => {},
                      icon: const Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.black87,
                      ),
                    )),
              ),
            );
          },
        ),

        // ListView(
        //   children: [
        //
        //   ],
        // ),
      ),

      routes: {
        "/selectedCategoryDetailsForm": (context) =>
            SelectedCategoryDetailsForm(),
        // Other named routes can be defined here
      },
      // child: const topNav(),
    );
  }
}
