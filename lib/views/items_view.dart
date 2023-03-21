import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class ItemsView extends StatefulWidget {
  const ItemsView({super.key});

  @override
  State<ItemsView> createState() => _ItemsViewState();
}

class _ItemsViewState extends State<ItemsView> {
  List<int> categoryList = [1, 2, 3, 4, 5];
  int selectedCategory = 1;

  getData(String coll) async {
    var firestore = FirebaseFirestore.instance;
    QuerySnapshot qn = await firestore.collection(coll).get();
    return qn.docs;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 30,
        title: Row(
          children: [
            const Expanded(child: SizedBox(width: 30)),
            DropdownButton<int>(
              iconEnabledColor: Colors.white,
              dropdownColor: Colors.teal,
              value: selectedCategory,
              items: categoryList
                  .map((category) => DropdownMenuItem(
                      value: category,
                      child: Text(
                        "$category",
                        style:
                            const TextStyle(color: Colors.white, fontSize: 30),
                      )))
                  .toList(),
              onChanged: (category) => setState(() {
                selectedCategory = category!;
              }),
            ),
            const SizedBox(width: 45),
            const Text(
              'إختر مجموعة',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
              ),
            ),
          ],
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 30, left: 10, right: 10),
        child: FutureBuilder(
          future: getData(selectedCategory.toString()),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List data = snapshot.data as List;
              return ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index) => Column(
                  children: [
                    Container(
                      color: Colors.grey[300],
                      child: Row(
                        children: [
                          SizedBox(
                            height: 100,
                            width: 100,
                            child: Image.network(data[index]['image']),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Container(
                            width: 120,
                            child: Text(
                              data[index]['item_name'],
                              style: const TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Column(
                            children: [
                              const Text('سعر الشراء'),
                              Text(data[index]['buy']),
                            ],
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Column(
                            children: [
                              const Text('سعر البيع'),
                              Text(data[index]['sell']),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}
