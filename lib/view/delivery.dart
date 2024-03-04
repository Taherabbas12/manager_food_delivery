import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:manager_food_delivery/urls.dart';

import '../colors_app.dart';
import '../models/basket_model.dart';

class Delivery extends StatelessWidget {
  const Delivery({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('الطلبات المرسله')),
      body: FutureBuilder(
        future: Dio().get(URLS.basketViewSend),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            print(snapshot.data!.data);

            Map data = jsonDecode(snapshot.data!.data);
            if (data['status'] == 'success') {
              List<BasketModel> d = [];
              for (Map<String, dynamic> i in data['data']) {
                d.add(BasketModel.fromJson(i));
              }

              return ListView.builder(
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: ListTile(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5)),
                      tileColor: myColor.withOpacity(0.7),
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(d[index].menuItemName,
                              style: const TextStyle(
                                  fontSize: 17, color: Colors.white)),
                          Text(d[index].receivedDate,
                              style: const TextStyle(
                                  fontSize: 17, color: Colors.white)),
                        ],
                      ),
                      leading: Text((index + 1).toString(),
                          style: const TextStyle(
                              fontSize: 17, color: Colors.white)),
                      subtitle:
                          // Text('العدد : ${da[index].quantity}',
                          //     style: const TextStyle(
                          //         fontSize: 14, color: Colors.white)),
                          Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('الزبون : ${d[index].name}',
                              style: const TextStyle(
                                  fontSize: 14, color: Colors.white)),
                          Text('الايميل : ${d[index].email}',
                              style: const TextStyle(
                                  fontSize: 14, color: Colors.white)),
                          Text('رقم الهاتف : ${d[index].phone}',
                              style: const TextStyle(
                                  fontSize: 14, color: Colors.white)),
                          Text('السعر : ${d[index].price} IQD',
                              style: const TextStyle(
                                  fontSize: 14, color: Colors.white)),
                        ],
                      ),
                    ),
                  );
                },
                itemCount: d.length,
              );
            } else {
              return const Center(
                child:
                    Text('لا يوجد طلبات حاليا', style: TextStyle(fontSize: 20)),
              );
            }
          } else {
            return const Center(
              child: SizedBox(
                width: 300,
                child: LinearProgressIndicator(),
              ),
            );
          }
        },
      ),
    );
  }
}
