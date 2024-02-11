import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../colors_app.dart';
import '../urls.dart';

class AllFood extends StatelessWidget {
  const AllFood({super.key});

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
                return Wrap(
                  children: List.generate(
                      data['data'].length,
                      (index) => GridTile(
                            child: Container(
                              width: 200,
                              height: 200,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: NetworkImage(
                                          '${URLS.URL}${data['data'][index]['image']}'))),
                            ),
                          )),
                );
              } else {
                return Center(child: Text('لم يتم أضافة انواع بعد'));
              }
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ));
  }
}
