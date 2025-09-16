import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

dynamic getInsightsOfAProduct(productId) async {
  try {
    print("called api flie");
    final response = await http.get(Uri.parse(
      "http://localhost/api/phpBackEnd/src/product.php?route=get-single-products-cart-count&productId=$productId",
    ));
    var data = jsonDecode(response.body);
    // print(object)
    print("from api");
    print(data);
    return data["data"]["cartCount"].toString();
  } catch (e) {
    print(e);
  }
}

dynamic isProductIsInCart(productId, userId) async {
  try {
    print("isProductIsInCart");
    final response = await http.get(Uri.parse(
      "http://localhost/api/phpBackEnd/src/product.php?productId=$productId&userId=$userId&route=is-product-is-in-cart",
    ));
    var data = jsonDecode(response.body);
    // print(object)
    print(data);
    return data["data"]["isPresent"];
  } catch (e) {
    print(e);
  }
}

dynamic addToCart(productId, userId) async {
  try {
    print("called api flie add to cart");
    final response = await http.post(Uri.parse(
      "http://localhost/api/phpBackEnd/src/product.php?route=add-to-cart&productId=$productId&userId=$userId",
    ));
    var data = jsonDecode(response.body);
    print("===========================");
    print(data);
    if (data["status"] == "failure") {
      print("failure");
      Fluttertoast.showToast(
          msg: data["message"],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM_LEFT,
          timeInSecForIosWeb: 2,
          backgroundColor: const Color.fromARGB(255, 235, 121, 106),
          textColor: const Color.fromARGB(255, 255, 255, 255),
          webBgColor: "linear-gradient(to right, #f06449, #e62739)",
          fontSize: 13);
      return false;
    }
    Fluttertoast.showToast(
        msg: data["message"],
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM_LEFT,
        timeInSecForIosWeb: 2,
        backgroundColor: Colors.blueAccent[200],
        textColor: const Color.fromARGB(255, 255, 255, 255),
        webBgColor: "linear-gradient(to right, #00b09b, #96c93d)",
        fontSize: 13);
    return true;
  } catch (e) {
    print(e);
  }
}

dynamic removeFromCart(productId, userId) async {
  try {
    print("called api file add to cart");
    print(productId);
    print(userId);
    final response = await http.delete(Uri.parse(
      "http://localhost/api/phpBackEnd/src/product.php?route=remove-from-cart&productId=$productId&userId=$userId",
    ));
    var data = jsonDecode(response.body);
    print(data);
    if (data["status"] == "failure") {
      print("failure");
      Fluttertoast.showToast(
          msg: data["message"],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM_LEFT,
          timeInSecForIosWeb: 2,
          backgroundColor: const Color.fromARGB(255, 235, 121, 106),
          textColor: const Color.fromARGB(255, 255, 255, 255),
          webBgColor: "linear-gradient(to right, #f06449, #e62739)",
          fontSize: 13);
      return false;
    }
    Fluttertoast.showToast(
        msg: data["message"],
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM_LEFT,
        timeInSecForIosWeb: 2,
        backgroundColor: Colors.blueAccent[200],
        textColor: const Color.fromARGB(255, 255, 255, 255),
        webBgColor: "linear-gradient(to right, #00b09b, #96c93d)",
        fontSize: 13);
    return true;
  } catch (e) {
    print(e);
  }
}
