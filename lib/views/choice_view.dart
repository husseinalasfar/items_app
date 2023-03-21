import 'package:flutter/material.dart';
import 'package:task_1/views/add_item_view.dart';
import 'package:task_1/views/items_view.dart';

class ChoiceView extends StatelessWidget {
  const ChoiceView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 30,
        title: const Text(
          'إختر خدمة',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 25,
          ),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const ItemsView()));
              },
              child: Container(
                color: Colors.teal,
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                child: const Text(
                  'عـرض',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const SizedBox(
              width: 20,
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const AddItemView()));
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
    );
  }
}
