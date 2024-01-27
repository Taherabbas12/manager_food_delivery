import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'view/dashbord.dart';
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
        });
  }
}
