import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UserImagePicker extends StatefulWidget {
  final void Function(File pickedImage) imagePickFn;

  UserImagePicker(this.imagePickFn);

  @override
  _UserImagePickerState createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> {
  final ImagePicker _picker = ImagePicker();

  File _pickedImage;

  void _pickImage(ImageSource src) async {
    final pickedImageFile = await _picker.getImage(source: src,imageQuality: 50, maxWidth: 150,);
    if (pickedImageFile != null) {
      setState(() {
        _pickedImage = File(pickedImageFile.path);
      });
      widget.imagePickFn(_pickedImage);
    } else {
      print("no image selected");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        CircleAvatar(
          radius: 40,
          backgroundColor: Colors.grey,
          backgroundImage:
              _pickedImage != null ? FileImage(_pickedImage) : null,
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            FlatButton.icon(
              textColor: Theme.of(context).primaryColor,
              icon: Icon(Icons.photo_camera_outlined),
              label: Text(
                'Add Image\n from camera',
                textAlign: TextAlign.center,
              ),
              onPressed: () => _pickImage(ImageSource.camera),
            ),
            FlatButton.icon(
              onPressed: () => _pickImage(ImageSource.gallery),
              icon: Icon(Icons.image_outlined),
              textColor: Theme.of(context).primaryColor,
              label: Text(
                'Add Image \n from gallery',
                textAlign: TextAlign.center,
              ),
            )
          ],
        )
      ],
    );
  }
}
