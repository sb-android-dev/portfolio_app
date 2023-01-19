
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ChangeImage extends StatelessWidget {
  const ChangeImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Change Image'),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ElevatedButton(onPressed: () {
            _getFromGallery(context);
          }, child: const Text('Open Gallery')),
          ElevatedButton(onPressed: () {
            _getFromCamera(context);
          }, child: const Text('Open Camera'))
        ],
      ),
    );
  }

  _getFromGallery(BuildContext context, [bool mounted = true]) async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery, maxWidth: 1080, maxHeight: 1080);

    if(pickedFile != null) {
      XFile file = XFile(pickedFile.path);

      if(!mounted) return;

      Navigator.pop(context, file);
    }
  }

  _getFromCamera(BuildContext context, [bool mounted = true]) async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.camera, maxWidth: 1080, maxHeight: 1080);

    if(pickedFile != null) {
      XFile file = XFile(pickedFile.path);

      if(!mounted) return;

      Navigator.pop(context, file);
    }
  }
}
