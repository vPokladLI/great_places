import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageInput extends StatefulWidget {
  const ImageInput({super.key});

  @override
  State<ImageInput> createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File? _imageFIle;
  final _imagePicker = ImagePicker();
  _takePhoto() async {
    XFile? image =
        await _imagePicker.pickImage(source: ImageSource.camera, maxWidth: 600);
    setState(() {
      _imageFIle = File(image!.path);
    });
  }

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
              ? Image.file(
                  _imageFIle!,
                  fit: BoxFit.cover,
                  width: double.infinity,
                )
              : Text(
                  "No image",
                  textAlign: TextAlign.center,
                )),
      SizedBox(
        width: 16,
      ),
      Expanded(
          child: TextButton.icon(
              onPressed: _takePhoto,
              icon: Icon(Icons.camera),
              label: Text('Take photo')))
    ]);
  }
}
