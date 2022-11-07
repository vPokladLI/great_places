import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;

class ImageInput extends StatefulWidget {
  final Function selectImage;
  const ImageInput(this.selectImage, {super.key});

  @override
  State<ImageInput> createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File? _imageFIle;
  final _imagePicker = ImagePicker();

  _takePhoto(source) async {
    try {
      XFile? image =
          await _imagePicker.pickImage(source: source, maxWidth: 600);
      if (image == null) {
        return;
      }
      final Directory appDocumentsDirectory =
          await getApplicationDocumentsDirectory();
      setState(() {
        _imageFIle = File(image.path);
      });
      final imageFileName = path.basename(_imageFIle!.path);
      final appDocDir = appDocumentsDirectory.path;

      final savedImage = await _imageFIle?.copy('$appDocDir/$imageFileName');
      widget.selectImage(savedImage);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Container(
          width: 200,
          height: 150,
          decoration: BoxDecoration(
              border: Border.all(width: 1, color: Colors.black12)),
          alignment: Alignment.center,
          child: _imageFIle != null
              ? Image.file(
                  _imageFIle!,
                  fit: BoxFit.cover,
                  width: double.infinity,
                )
              : const Text(
                  "No image",
                  textAlign: TextAlign.center,
                )),
      const SizedBox(
        width: 8,
      ),
      Expanded(
        child: SizedBox(
          height: 150,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TextButton.icon(
                  style:
                      TextButton.styleFrom(alignment: const Alignment(-1, 0)),
                  onPressed: () {
                    _takePhoto(ImageSource.camera);
                  },
                  icon: const Icon(Icons.camera),
                  label: const Text(
                    'Take photo',
                    textAlign: TextAlign.right,
                  )),
              TextButton.icon(
                  style:
                      TextButton.styleFrom(alignment: const Alignment(-1, 0)),
                  onPressed: () {
                    _takePhoto(ImageSource.gallery);
                  },
                  icon: const Icon(Icons.upload_file),
                  label: const Text('Upload image')),
            ],
          ),
        ),
      )
    ]);
  }
}
