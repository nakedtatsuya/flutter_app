import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../services/network_service.dart';
import 'dart:convert';
import 'dart:typed_data';

class ImageUploadWidget extends StatefulWidget {
  @override
  _ImageUploadWidgetState createState() => _ImageUploadWidgetState();
}

class _ImageUploadWidgetState extends State<ImageUploadWidget> {
  XFile? _image;
  String? _output;

  Future<void> _pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        _image = image;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (_image != null) Image.file(File(_image!.path)),
        ElevatedButton(
          onPressed: _pickImage,
          child: const Text('Choose Image'),
        ),
        ElevatedButton(
          onPressed: () async {
            if (_image != null) {
              var res = await NetworkService.uploadImage(_image!.path);
              setState(() {
                _output = res.imageString;
              });
            }
          },
          child: const Text('Upload Image'),
        ),
        if (_output != null) Image.memory(base64Decode(_output!)),
      ],
    );
  }
}
