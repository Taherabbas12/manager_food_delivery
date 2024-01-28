import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:manager_food_delivery/colors_app.dart';
import 'package:manager_food_delivery/urls.dart';

import 'sign_in.dart';

class AddFood extends StatelessWidget {
  const AddFood({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        title: const Text(
          'أضافة الوجبات',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: myColor,
      ),
      body: Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            color: myColor.withOpacity(0.4),
            width: 300,
            child: Column(
              children: [
                const SizedBox(
                  height: 5,
                ),
                InkWell(
                  borderRadius: BorderRadius.circular(15),
                  hoverColor: const Color.fromARGB(255, 0, 0, 0),
                  onTap: () {
                    TextEditingController name = TextEditingController();
                    showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                              title: const Text('اضافة اصناف'),
                              content: SizedBox(
                                width: 400,
                                height: 400,
                                child: Column(children: [
                                  textInput('اسم الصنف', name),
                                ]),
                              ),
                            ));
                  },
                  child: Container(
                    alignment: Alignment.center,
                    height: 60,
                    width: double.infinity,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                        color: myColor.withOpacity(0.8),
                        borderRadius: BorderRadius.circular(15)),
                    child: const Row(
                      children: [
                        Icon(
                          Icons.add,
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Text(
                          'اضافة نوع من الاطعمة',
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Expanded(
                  child: FutureBuilder(
                    future: Dio().get(URLS.categoryView),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        final data = jsonDecode(snapshot.data.toString());
                        List values = data['data'];
                        return ListView.builder(
                          itemBuilder: (context, index) => Padding(
                            padding: const EdgeInsets.symmetric(vertical: 2.0),
                            child: InkWell(
                              borderRadius: BorderRadius.circular(15),
                              hoverColor: const Color.fromARGB(255, 0, 0, 0),
                              onTap: () {},
                              child: Container(
                                height: 100,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 5),
                                decoration: BoxDecoration(
                                    color: myColor.withOpacity(0.8),
                                    borderRadius: BorderRadius.circular(15)),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Container(
                                        width: 130,
                                        height: 95,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            image: DecorationImage(
                                                fit: BoxFit.cover,
                                                image: NetworkImage(
                                                    '${URLS.URL}${values[index]['image']}'))),
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        values[index]['name'],
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                            color: Colors.white, fontSize: 18),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          itemCount: values.length,
                        );
                      } else {
                        return const Text('ليس هناك أي انواع');
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
          const Expanded(flex: 5, child: Text('B')),
        ],
      ),
    );
  }
}
