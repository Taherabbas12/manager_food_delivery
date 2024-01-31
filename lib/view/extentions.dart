import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../colors_app.dart';

Widget textInput(String label, TextEditingController controller,
    {bool password = false, double w = 400}) {
  return Container(
    alignment: Alignment.center,
    padding: const EdgeInsets.symmetric(horizontal: 15),
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: myColor2,
        border: Border.all(color: Colors.black.withOpacity(0.2))),
    width: w,
    height: 60,
    child: TextField(
      obscureText: password,
      controller: controller,
      decoration: InputDecoration(hintText: label, border: InputBorder.none),
    ),
  );
}

Widget textInputNumber(String label, TextEditingController controller,
    {bool password = false, double w = 400}) {
  return Container(
    alignment: Alignment.center,
    padding: const EdgeInsets.symmetric(horizontal: 15),
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: myColor2,
        border: Border.all(color: Colors.black.withOpacity(0.2))),
    width: w,
    height: 60,
    child: TextField(
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      obscureText: password,
      controller: controller,
      decoration: InputDecoration(hintText: label, border: InputBorder.none),
    ),
  );
}
