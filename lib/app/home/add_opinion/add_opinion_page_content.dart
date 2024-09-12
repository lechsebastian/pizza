import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddOpinionPageContent extends StatefulWidget {
  const AddOpinionPageContent({
    required this.onSave,
    super.key,
  });

  final Function onSave;

  @override
  State<AddOpinionPageContent> createState() => _AddOpinionPageContentState();
}

class _AddOpinionPageContentState extends State<AddOpinionPageContent> {
  var restaurantName = '';
  var pizzaName = '';
  var rating = 3.0;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              onChanged: (value) {
                setState(() {
                  restaurantName = value;
                });
              },
              decoration: const InputDecoration(
                label: Text('Restauracja'),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              onChanged: (value) {
                setState(() {
                  pizzaName = value;
                });
              },
              decoration: const InputDecoration(
                label: Text('Pizza'),
              ),
            ),
            const SizedBox(height: 20),
            Slider(
              value: rating,
              min: 0,
              max: 6,
              divisions: 12,
              label: rating.toString(),
              onChanged: (newValue) {
                setState(() {
                  rating = newValue;
                });
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: restaurantName.isEmpty || pizzaName.isEmpty
                  ? null
                  : () {
                      FirebaseFirestore.instance.collection('restaurants').add({
                        'name': restaurantName,
                        'pizza': pizzaName,
                        'rating': rating,
                      });
                      widget.onSave();
                    },
              child: const Text('Dodaj'),
            ),
          ],
        ),
      ),
    );
  }
}
