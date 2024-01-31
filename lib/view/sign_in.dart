// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' as get1;

import '../colors_app.dart';
import '../urls.dart';
import 'extentions.dart';

TextEditingController email = TextEditingController();

class SignIn extends StatelessWidget {
  SignIn({super.key});
  TextEditingController password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('تسجيل الدخول'),
        centerTitle: true,
      ),
      body: Center(
        child: Container(
          height: 400,
          width: 500,
          decoration: BoxDecoration(
              color: myColor, borderRadius: BorderRadius.circular(15)),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                textInput('الايميل', email),
                const SizedBox(height: 15),
                textInput('رمز الدخول', password, password: true),
                const SizedBox(height: 45),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        fixedSize: const Size(300, 50)),
                    onPressed: () async {
                      if (email.text.isNotEmpty && password.text.isNotEmpty) {
                        var fromData = FormData.fromMap({
                          'email': email.text.trim(),
                          'password': password.text
                        });

                        Response response =
                            await Dio().post(URLS.signIn, data: fromData);
                        print(response.data);
                        Map data = jsonDecode(response.data);
                        if (data['status'] != 'fail') {
                          print(data);
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            backgroundColor: Colors.green,
                            content: Text(
                                'تم تسجيل الدخول بأسم : ${data['data'][0]['name']}'),
                          ));
                          await Future.delayed(const Duration(seconds: 2));

                          get1.Get.offAndToNamed('Dashbord');
                        } else {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            backgroundColor: Colors.red,
                            content: Text('تحقق من البيانات'),
                          ));
                        }
                      } else {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          backgroundColor: Colors.red,
                          content: Text('يرجى ملأ كل الحقول'),
                        ));
                      }
                    },
                    child: const Text(
                      'دخول',
                      style: TextStyle(fontSize: 20),
                    ))
              ]),
        ),
      ),
    );
  }
}
