import 'package:flutter/material.dart';
import 'dart:io';

class ImageInput extends StatefulWidget {
  const ImageInput({super.key});

  @override
  State<ImageInput> createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File? _imageFIle;
  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Container(
          width: 150,
          height: 100,
          decoration: BoxDecoration(
              border: Border.all(width: 1, color: Colors.black12)),
          alignment: Alignment.center,
          child: _imageFIle != null
              ? Image.file(_imageFIle!)
              : Text(
                  "No image",
                  textAlign: TextAlign.center,
                )),
      SizedBox(
        width: 16,
      ),
      Expanded(
          child: TextButton.icon(
              onPressed: () {},
              icon: Icon(Icons.camera),
              label: Text('Take photo')))
    ]);
  }
}
