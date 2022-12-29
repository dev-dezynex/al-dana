import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../data/data.dart';

class ProfileController extends GetxController {
  var file = File('').obs;
  var currentUser = Common().currentUser.obs;
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

  pickImage(ImageSource sourse) async {
    var image = (await FileProvider().pickImage(imageSource: sourse))!;

    print('file picked ${file.value.path.split('/').last}');

    file.value = (await FileProvider().cropImage(image))!;
  }

  void updateProfile() {}
}
