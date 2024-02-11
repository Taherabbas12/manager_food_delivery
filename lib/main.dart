import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'view/add_food.dart';
import 'view/all_category.dart';
import 'view/dashbord.dart';
import 'view/delivery.dart';
import 'view/requests.dart';
import 'view/sign_in.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        textDirection: TextDirection.rtl,
        routes: {
          '/': (p0) => SignIn(),
          'Dashbord': (p0) => Dashbord(),
          // '/': (p0) => Dashbord(),
          'AddFood': (p0) => AddFood(),
          'Requests': (p0) => Requests(),
          'Delivery': (p0) => Delivery(),
          'AllFood': (p0) => AllCategory(),
        });
  }
}
