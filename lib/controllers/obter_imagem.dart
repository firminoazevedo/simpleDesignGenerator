import 'dart:io';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';

class ObterImagem {
  bool imageSelected = false;
  File _imageDois;
  
  Future<File> getImage() async {
    var image;
    var croppedFile;
    try {
      // ignore: deprecated_member_use
      image = await ImagePicker.pickImage(source: ImageSource.gallery); // Obter imagem da galeria
      croppedFile = await ImageCropper.cropImage( // Cortar imagem
          sourcePath: image.path,
          aspectRatioPresets: [
            CropAspectRatioPreset.square,
            CropAspectRatioPreset.ratio3x2,
            CropAspectRatioPreset.original,
            CropAspectRatioPreset.ratio4x3,
            CropAspectRatioPreset.ratio16x9
          ],
          androidUiSettings: AndroidUiSettings(
              toolbarTitle: 'Cortar',
              toolbarColor: Colors.deepOrange,
              toolbarWidgetColor: Colors.white,
              initAspectRatio: CropAspectRatioPreset.original,
              lockAspectRatio: false),
          iosUiSettings: IOSUiSettings(
            minimumAspectRatio: 1.0,
          ));
    } catch (platformException) {
      print("NÃO PERMITIDO " + platformException);
    }

    if (image != null) {
      imageSelected = true;
      _imageDois = croppedFile;
    } 
    
    new Directory('storage/emulated/0/' + 'MemeGenerator').create(recursive: true);
    print(image);
    return _imageDois;

  }

}