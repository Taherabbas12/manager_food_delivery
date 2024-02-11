// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' as get2;

import 'package:image_picker/image_picker.dart';
import 'package:manager_food_delivery/colors_app.dart';
import 'package:manager_food_delivery/urls.dart';

import 'extentions.dart';

class AddFood extends StatefulWidget {
  const AddFood({super.key});

  @override
  State<AddFood> createState() => _AddFoodState();
}

class _AddFoodState extends State<AddFood> {
  TextEditingController nameFood = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController price = TextEditingController();
  String category = "";
  List<String> imagesFood = [];
  int indexCategory = 0;
  double _progress = 0.0;

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
          addTypeFood(context),
          addFood(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          if (nameFood.text.isNotEmpty &&
              description.text.isNotEmpty &&
              price.text.isNotEmpty &&
              category.isNotEmpty &&
              imagesFood.isNotEmpty) {
            _uploadFiles();
          } else {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text(' يجب ملئ كل الحقول '),
              backgroundColor: Colors.red,
            ));
          }
        },
        backgroundColor: myColor,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }

  Expanded addFood() => Expanded(
      flex: 5,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Wrap(
                  runSpacing: 15,
                  spacing: 15,
                  alignment: WrapAlignment.center,
                  children: [
                    textInput('اسم الوجبه', nameFood, w: 250),
                    textInput('الوصف', description, w: 250),
                    textInputNumber('السعر', price, w: 250),
                  ],
                ),
                const SizedBox(height: 15),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        fixedSize: const Size(130, 95),
                        backgroundColor: myColor2,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                    onPressed: () async {
                      try {
                        final XFile? imageF = await ImagePicker()
                            .pickImage(source: ImageSource.gallery);
                        imagesFood.add(imageF!.path);
                        setState(() {});
                      } catch (e) {}
                    },
                    child: const Text(
                      'أضافة صورة',
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    )),
                const SizedBox(width: 15, height: 15),
                Wrap(
                  children: [
                    for (String i in imagesFood)
                      GestureDetector(
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                    content: Container(
                                      margin: const EdgeInsets.all(5),
                                      // width: 130,
                                      // height: 95,
                                      width: MediaQuery.sizeOf(context).width *
                                          0.7,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: FileImage(File(i)))),
                                    ),
                                  ));
                        },
                        child: Column(
                          children: [
                            Container(
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 3),
                              width: 130,
                              height: 95,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: FileImage(File(i)))),
                            ),
                            ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    fixedSize: const Size(130, 40),
                                    backgroundColor: Colors.red,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10))),
                                onPressed: () async {
                                  try {
                                    imagesFood.remove(i);
                                    setState(() {});
                                  } catch (e) {}
                                },
                                child: const Text(
                                  'حذف الصورة',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                )),
                          ],
                        ),
                      )
                  ],
                )
              ],
            ),
          ),
        ),
      ));

  Container addTypeFood(BuildContext context) {
    return Container(
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
              String imageFile = '';
              TextEditingController name = TextEditingController();
              showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                        title: const Text('اضافة اصناف'),
                        content: StreamBuilder(
                            stream: Stream.periodic(
                              const Duration(seconds: 1),
                            ),
                            builder: (context, snapshot) {
                              return SizedBox(
                                width: 400,
                                height: 300,
                                child: Column(children: [
                                  textInput('اسم الصنف', name),
                                  const SizedBox(height: 10),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                              fixedSize: const Size(130, 95),
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10))),
                                          onPressed: () async {
                                            final XFile? imageF =
                                                await ImagePicker().pickImage(
                                                    source:
                                                        ImageSource.gallery);
                                            imageFile = imageF!.path;
                                            setState(() {});
                                          },
                                          child: const Text('أضافة صورة')),
                                      const SizedBox(width: 15),
                                      imageFile.isNotEmpty
                                          ? Container(
                                              width: 130,
                                              height: 95,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                  image: DecorationImage(
                                                      fit: BoxFit.cover,
                                                      image: FileImage(
                                                          File(imageFile)))),
                                            )
                                          : const SizedBox()
                                    ],
                                  ),
                                  const SizedBox(height: 40),
                                  ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          fixedSize: const Size(330, 60),
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10))),
                                      onPressed: () async {
                                        //  add Category
                                        if (name.text.isNotEmpty) {
                                          FormData fromData = FormData.fromMap({
                                            'file': await MultipartFile.fromFile(
                                                imageFile), // استبدل filePath بمسار الملف الخاص بك
                                            'name': name.text
                                                .trim() // النص الذي ترغب في إرفاقه مع الملف
                                          });

                                          Response response = await Dio().post(
                                              URLS.categoryAdd,
                                              data: fromData);
                                          print(response.data);
                                          Map data = jsonDecode(response.data);
                                          if (data['status'] != 'fail') {
                                            print(data);
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(SnackBar(
                                              backgroundColor: Colors.green,
                                              content: Text(
                                                  'تم اضافة الصنف  : ${name.text.trim()}'),
                                            ));
                                          }
                                        }
                                      },
                                      child: const Text('أضافة الصنف'))
                                ]),
                              );
                            }),
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
                )),
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
                        onTap: () {
                          setState(() {
                            category = values[index]['name'];
                            indexCategory = index;
                          });
                        },
                        child: Container(
                          height: 100,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 5),
                          decoration: BoxDecoration(
                              color: indexCategory == index
                                  ? myColor.withOpacity(1)
                                  : myColor.withOpacity(0.4),
                              borderRadius: BorderRadius.circular(15)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Container(
                                  width: 130,
                                  height: 95,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
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
    );
  }

  void _uploadFiles() async {
    Dio dio = Dio();

    Response response = await dio.post(URLS.foodAdd,
        data: FormData.fromMap({
          'Name': nameFood.text.trim(),
          'Description': description.text.trim(),
          'Price': price.text.trim(),
          'Category': category,
          'isAvailable': 'true'
        }));

    print(response.data);

    Map data = jsonDecode(response.data);
    if (data['status'] == 'success') {
      for (String i in imagesFood) {
        FormData formData = FormData();
        formData.fields
            .add(MapEntry('id_items', data['data'][0]['MenuItemID']));
        formData.files.add(MapEntry(
          'file',
          await MultipartFile.fromFile(i),
        ));
        Response response2 = await dio.post(URLS.foodAddImages, data: formData);
        print(response2.data);
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('تم أضافة البياتات')));
      }

      // إضافة النص الإضافي

      print(response.data);
    }
  }
}
