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
  File? _pickedImage;

  final ImagePicker _picker = ImagePicker();

  void _pickImage(ImageSource src) async{
    final pickedImageFile = await _picker.getImage(source: src,imageQuality: 50,maxWidth: 150);

    if(pickedImageFile != null){
      setState(() {
        _pickedImage = File(pickedImageFile.path);
        widget.imagePickFn(_pickedImage!);
      });

    }else{
      print("No Image Selected");
    }


  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      margin: EdgeInsets.all(8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 40,
            backgroundColor: Colors.grey,
            backgroundImage: _pickedImage != null ? FileImage(_pickedImage!) : null,
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: TextButton.icon(onPressed: ()=> _pickImage(ImageSource.camera),
                  icon: Icon(Icons.camera_alt_outlined),
                  label: Text('Add Image\nfrom Camera'),
                  style: TextButton.styleFrom(
                    primary: Color.fromRGBO(49, 39, 79, 1),
                  ),
                ),
              ),
              Expanded(
                child: TextButton.icon(onPressed: ()=> _pickImage(ImageSource.gallery),
                  icon: Icon(Icons.photo_outlined),
                  label: Text('Add Image\nfrom Gallery'),
                  style: TextButton.styleFrom(
                    primary: Color.fromRGBO(49, 39, 79, 1),
                  ),
                ),
              ),

            ],
          )
        ],
      ),
    );
  }
}
