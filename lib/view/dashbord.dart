import 'package:flutter/material.dart';
import 'package:manager_food_delivery/colors_app.dart';

class Dashbord extends StatelessWidget {
  Dashbord({super.key});

  List<ViewDashbord> views = [
    ViewDashbord('اضافة اكلات', 'addFood'),
    ViewDashbord('الطلبات', 'requests'),
    ViewDashbord('تم توصيلها', 'addFood'),
    ViewDashbord('جميع الاكلات', 'addFood'),
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
                onTap: () {},
                child: Container(
                  alignment: Alignment.center,
                  width: 200,
                  height: 150,
                  decoration: BoxDecoration(
                      color: myColor.withOpacity(0.85),
                      borderRadius: BorderRadius.circular(15)),
                  child: Text(
                    i.name,
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

class ViewDashbord {
  String name, value;
  ViewDashbord(this.name, this.value);
}
