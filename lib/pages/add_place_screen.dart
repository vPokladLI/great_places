import 'package:flutter/material.dart';

import '../widgets/image_input.dart';

class AddPlaceScreen extends StatefulWidget {
  static String routName = '/add-place';
  const AddPlaceScreen({super.key});

  @override
  State<AddPlaceScreen> createState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState extends State<AddPlaceScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add place'),
      ),
      body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: SingleChildScrollView(
                  child: Form(
                    child: Column(children: [
                      TextFormField(
                        decoration: InputDecoration(labelText: 'Title'),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      ImageInput(),
                    ]),
                  ),
                ),
              ),
            ),
            ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.secondary,
                    padding: EdgeInsets.only(top: 12, bottom: 12),
                    elevation: 0,
                    shape: ContinuousRectangleBorder()),
                onPressed: () {},
                icon: Icon(Icons.photo_size_select_actual_rounded),
                label: Text('Add place'))
          ]),
    );
  }
}
