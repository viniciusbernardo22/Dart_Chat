import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:image_picker/image_picker.dart';

class UserImagePicker extends StatefulWidget {
  final void Function(File image) onImagePick;

  const UserImagePicker({Key? key, required this.onImagePick})
      : super(key: key);

  @override
  State<UserImagePicker> createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> {
  File? _image;

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(
        source: ImageSource.gallery, imageQuality: 50, maxWidth: 150);

    if (pickedImage != null) {
      setState(() {
        _image = File(pickedImage.path);
      });

      widget.onImagePick(_image!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          backgroundImage: _image != null ? FileImage(_image!) : null,
          radius: 40,
          backgroundColor: Colors.grey,
        ),
        TextButton(
          onPressed: _pickImage,
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Icon(Icons.image, color: Theme.of(context).primaryColor),
            SizedBox(
              width: 10,
            ),
            Text('Adicionar Imagem')
          ]),
        )
      ],
    );
  }
}