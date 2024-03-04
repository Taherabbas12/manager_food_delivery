import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../colors_app.dart';
import '../urls.dart';

class ViewFood extends StatefulWidget {
  ViewFood({super.key, required this.idCategory});
  String idCategory;

  @override
  State<ViewFood> createState() => _ViewFoodState();
}

class _ViewFoodState extends State<ViewFood> {
  bool isValibe = true;

  @override
  Widget build(BuildContext context) {
    FormData formData = FormData();
    formData.fields.add(MapEntry('Category', widget.idCategory));

    return Scaffold(
        appBar: AppBar(backgroundColor: myColor, foregroundColor: Colors.white),
        body: FutureBuilder(
          future: Dio().post(URLS.foodView, data: formData),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              Map data = jsonDecode(snapshot.data!.data);
              if (data['status'] == 'success') {
                return Wrap(
                  children: List.generate(
                      data['data'].length,
                      (index) => InkWell(
                            onTap: () {
                              //
                              isValibe =
                                  data['data'][index]['isAvailable'] == '0'
                                      ? true
                                      : false;
                              print(data['data'][index]['Images'][index]);
                              showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                      backgroundColor: myColor,
                                      title: Text(
                                          'اسم الوجبة : ${data['data'][index]['MenuItemName']}',
                                          style: const TextStyle(
                                              color: Colors.white)),
                                      content: SizedBox(
                                        width: 400,
                                        height: 450,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              width: 400,
                                              height: 300,
                                              child: CarouselSlider(
                                                  items: List.generate(
                                                      data['data'][index]
                                                              ['Images']
                                                          .length,
                                                      (index) => Image.network(
                                                            '${URLS.URL}${data['data'][0]['Images'][index]}',
                                                            fit: BoxFit.cover,
                                                          )),
                                                  options: CarouselOptions(
                                                    height: 400,
                                                    aspectRatio: 16 / 9,
                                                    viewportFraction: 0.8,
                                                    initialPage: 0,
                                                    enableInfiniteScroll: true,
                                                    reverse: false,
                                                    autoPlay: true,
                                                    autoPlayInterval:
                                                        const Duration(
                                                            seconds: 3),
                                                    autoPlayAnimationDuration:
                                                        const Duration(
                                                            milliseconds: 800),
                                                    autoPlayCurve:
                                                        Curves.fastOutSlowIn,
                                                    enlargeCenterPage: true,
                                                    enlargeFactor: 0.3,
                                                    scrollDirection:
                                                        Axis.horizontal,
                                                  )),
                                            ),
                                            SizedBox(height: 50),
                                            //
                                            Text(
                                                'الوصف : ${data['data'][index]['Description']}',
                                                style: const TextStyle(
                                                    fontSize: 17,
                                                    color: Colors.white)),
                                            Text(
                                                'السعر : ${data['data'][index]['Price']}',
                                                style: const TextStyle(
                                                    fontSize: 17,
                                                    color: Colors.white)),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                const Text('متوفر : ',
                                                    style: TextStyle(
                                                        fontSize: 17,
                                                        color: Colors.white)),
                                                StreamBuilder(
                                                    stream: Stream.periodic(
                                                        const Duration(
                                                            milliseconds: 100)),
                                                    builder:
                                                        (context, snapshot) {
                                                      return CupertinoSwitch(
                                                          value: isValibe,
                                                          onChanged: (v) {
                                                            isValibe = v;
                                                            print(v);
                                                            setState(() {});
                                                          });
                                                    })
                                              ],
                                            ),
                                          ],
                                        ),
                                      )));
                            },
                            borderRadius: BorderRadius.circular(5),
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
                                        color:
                                            Color.fromARGB(255, 179, 179, 179))
                                  ],
                                  image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: NetworkImage(
                                          '${URLS.URL}${data['data'][index]['Images'][0]}'))),
                              child: Container(
                                  height: 40,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.only(
                                          bottomLeft: Radius.circular(5),
                                          bottomRight: Radius.circular(5)),
                                      color: myColor.withOpacity(0.7)),
                                  child: Text(data['data'][index]['Name'],
                                      style: const TextStyle(
                                          fontSize: 20, color: Colors.white))),
                            ),
                          )),
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
