import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../colors_app.dart';
import '../urls.dart';
import 'view_food.dart';

class AllCategory extends StatelessWidget {
  const AllCategory({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(backgroundColor: myColor, foregroundColor: Colors.white),
        body: FutureBuilder(
          future: Dio().get(
            URLS.categoryView,
          ),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              print(snapshot.data);
              Map data = jsonDecode(snapshot.data!.data);
              if (data['status'] == 'success') {
                return SingleChildScrollView(
                  child: Wrap(
                    children: List.generate(
                        data['data'].length,
                        (index) => InkWell(
                              borderRadius: BorderRadius.circular(5),
                              hoverColor: myColor.withOpacity(0.6),
                              onTap: () {
                                //
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ViewFood(
                                          idCategory: data['data'][index]
                                              ['id']),
                                    ));
                              },
                              child: Container(
                                margin: const EdgeInsets.all(5),
                                alignment: Alignment.bottomCenter,
                                width: 200,
                                height: 200,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    boxShadow: const [
                                      BoxShadow(
                                          blurRadius: 2,
                                          spreadRadius: 2,
                                          color: Color.fromARGB(
                                              255, 179, 179, 179))
                                    ],
                                    image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: NetworkImage(
                                            '${URLS.URL}${data['data'][index]['image']}'))),
                                child: Container(
                                    height: 40,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.only(
                                            bottomLeft: Radius.circular(5),
                                            bottomRight: Radius.circular(5)),
                                        color: myColor.withOpacity(0.7)),
                                    child: Text(data['data'][index]['name'],
                                        style: const TextStyle(
                                            fontSize: 20,
                                            color: Colors.white))),
                              ),
                            )),
                  ),
                );
              } else {
                return const Center(child: Text('لم يتم أضافة انواع بعد'));
              }
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ));
  }
}
