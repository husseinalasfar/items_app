import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

class AddItemView extends StatefulWidget {
  const AddItemView({super.key});

  @override
  State<AddItemView> createState() => _AddItemViewState();
}

class _AddItemViewState extends State<AddItemView> {
  var categoryNumber = '';
  var itemName = '';
  var sell = '';
  var buy = '';
  CollectionReference itemList =
      FirebaseFirestore.instance.collection('item_list');

  File? file;
  ImagePicker image = ImagePicker();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 30,
        title: const Text(
          'إضافة صنف',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 25,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 30),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                      width: 150,
                      height: 40,
                      child: TextField(
                        onChanged: (value) {
                          categoryNumber = (value);
                        },
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5))),
                        ),
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                      )),
                  const SizedBox(width: 40),
                  const Text(
                    'رقم المجموعة',
                    style: TextStyle(color: Colors.black, fontSize: 25),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                      width: 150,
                      height: 40,
                      child: TextField(
                        onChanged: (value) {
                          itemName = value;
                        },
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5))),
                        ),
                        textAlign: TextAlign.center,
                      )),
                  const SizedBox(width: 40),
                  const Text(
                    '   إسم الصنف',
                    style: TextStyle(color: Colors.black, fontSize: 25),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                      width: 150,
                      height: 40,
                      child: TextField(
                        onChanged: (value) {
                          sell = (value);
                        },
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5))),
                        ),
                        textAlign: TextAlign.center,
                      )),
                  const SizedBox(width: 40),
                  const Text(
                    '      سعر البيع',
                    style: TextStyle(color: Colors.black, fontSize: 25),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                      width: 150,
                      height: 40,
                      child: TextField(
                        onChanged: (value) {
                          buy = (value);
                        },
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5))),
                        ),
                        textAlign: TextAlign.center,
                      )),
                  const SizedBox(width: 40),
                  const Text(
                    '   سعر الشراء',
                    style: TextStyle(color: Colors.black, fontSize: 25),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      Container(
                          height: 140,
                          width: 140,
                          color: Colors.black12,
                          child: file == null
                              ? const Icon(
                                  Icons.image,
                                  color: Colors.black26,
                                  size: 70,
                                )
                              : Image.file(
                                  file!,
                                  fit: BoxFit.fill,
                                )),
                      Row(
                        children: [
                          IconButton(
                              onPressed: () {
                                gitcam();
                              },
                              icon: const Icon(Icons.camera_alt)),
                          const SizedBox(
                            width: 10,
                          ),
                          IconButton(
                              onPressed: () {
                                gitgall();
                              },
                              icon: const Icon(Icons.image))
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(width: 35),
                  const Text(
                    '         الصورة',
                    style: TextStyle(color: Colors.black, fontSize: 25),
                  ),
                ],
              ),
              const SizedBox(height: 50),
              TextButton(
                onPressed: () async {
                  var imageName = basename(file!.path);
                  var ref = FirebaseStorage.instance.ref('images/$imageName');
                  await ref.putFile(file!);
                  String imageUrl = await ref.getDownloadURL();
                  FirebaseFirestore.instance
                      .collection(categoryNumber.toString())
                      .add({
                    'category_num': categoryNumber,
                    'item_name': itemName,
                    'sell': sell,
                    'buy': buy,
                    'image': imageUrl
                  }).then((value) => print('item added ###############'));
                  Navigator.pop(context);
                },
                child: Container(
                  color: Colors.teal,
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                  child: const Text(
                    'إضافة',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  gitcam() async {
    // ignore: deprecated_member_use
    var img = await image.getImage(source: ImageSource.camera);
    setState(() {
      file = File(img!.path);
    });
  }

  gitgall() async {
    // ignore: deprecated_member_use
    var img = await image.getImage(source: ImageSource.gallery);
    setState(() {
      file = File(img!.path);
    });
  }
}
