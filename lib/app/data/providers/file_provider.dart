import 'dart:async';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../data.dart';
import 'package:image_cropper/image_cropper.dart';

import 'package:image_picker/image_picker.dart';

class FileProvider {
  dynamic Function(double)? uploadProgress;

  Future<File?> pickFile({FileType fileType = FileType.image,List<String>? allowedExtensions}) async {
    FilePickerResult? result = await FilePicker.platform
        .pickFiles(type: fileType, allowMultiple: false,allowedExtensions: allowedExtensions);
    if (result == null) {
      return null;
    } else {
      return File(result.files.single.path!);
    }
  }

  Future<File?> pickImage(
      {ImageSource imageSource = ImageSource.gallery}) async {
    final ImagePicker _picker = ImagePicker();
    XFile? image = await _picker.pickImage(source: imageSource);
    if (image == null) {
      return null;
    } else {
      print('image path ${image.path}');
      return File(image.path);
    }
  }

  Future<Map<String, dynamic>> uploadFile(
      {required File file,
      required dynamic Function(double) uploadProgress}) async {
    try {
      String fileName = file.path.split('/').last;
      var formData = FormData.fromMap({
        'files': await MultipartFile.fromFile(file.path, filename: fileName),
      });
      var response = await Dio().post('apiFileUpload', data: formData,
          onSendProgress: (int send, int total) {
        print('send $send  -  total  $total');
        uploadProgress.call(((send / total) * 100));
      });
      print('file upload server responce = ${response.data}');
      print('responce data = ${response.data['data'][0]}');
      if (response.statusCode == 200) {
        return response.data;
      } else {
        return {"status": "error", "data": 'Uploading failed...!'};
      }
    } catch (e) {
      return {"status": "error", "data": e.toString()};
    }
  }

  Future<File?> cropImage(File imageFile) async {
    CroppedFile? croppedFile = await ImageCropper().cropImage(
      sourcePath: imageFile.path,
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.ratio4x3,
        CropAspectRatioPreset.ratio16x9
      ],
      uiSettings: [
        AndroidUiSettings(
            toolbarTitle: '',
            toolbarColor: Colors.black,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        IOSUiSettings(
          title: 'Cropper',
        ),
      ],
    );

    return File(croppedFile!.path);
  }
}
