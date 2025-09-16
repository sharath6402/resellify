import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class topNav extends StatelessWidget {
  const topNav({super.key});

  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.all(10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            "images/logo.jpeg",
            width: 120.0,
            height: 70.0,
          ),
          Icon(
            Icons.account_circle,
            size: 32,
            color: Colors.teal,
          ),
        ],
      ),
    );
  }
}
