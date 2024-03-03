import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manager_food_delivery/colors_app.dart';

import 'dashbord.dart';

class StartApp extends StatelessWidget {
  StartApp({super.key});

  List<ViewDashbord> views = [
    ViewDashbord('مطعم بلاد الشام', ''),
    ViewDashbord('مطعم بلاد الشام', ''),
    ViewDashbord('مطعم غفران', 'SignIn'),
    ViewDashbord('مطعم النافورة', ''),
    ViewDashbord('مطعم بركات الزهراء', ''),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Wrap(
          runSpacing: 15,
          spacing: 15,
          children: [
            for (ViewDashbord i in views)
              InkWell(
                borderRadius: BorderRadius.circular(15),
                hoverColor: Colors.black,
                onTap: () {
                  if (i.value.isNotEmpty) {
                    Get.toNamed(i.value);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('سيتم أضافة المطعم قريبا')));
                  }
                },
                child: Container(
                  alignment: Alignment.center,
                  width: 200,
                  height: 150,
                  decoration: BoxDecoration(
                      color: myColor.withOpacity(0.85),
                      borderRadius: BorderRadius.circular(15)),
                  child: Text(
                    i.name,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.white.withOpacity(1)),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
