import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../data/data.dart';

class AddServiceController extends GetxController {
  TextEditingController titleController = TextEditingController();
  TextEditingController subTitleController = TextEditingController();
  TextEditingController descController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController thumbController = TextEditingController();
  var isUpdate = false.obs;
  var isLoading = false.obs;
  var thumbFile = File('').obs;

  var selectedService = Service(spareCategory: SpareCategory()).obs;
  @override
  void onInit() {
    super.onInit();

    if (Get.arguments != null) {
      isUpdate.value = true;
      selectedService.value = Get.arguments;
      setFields();
    }
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  pickThumb() async {
    thumbFile.value = (await FileProvider().pickFile(
        fileType: FileType.custom, allowedExtensions: ['png', 'jpeg']))!;
    String fileName = thumbFile.value.path.split('/').last;
    print('file url path ${thumbFile.value.path}');
    print('file picked path $fileName');

    thumbController.text = fileName;
  }

  void createService() {}

  void deleteService() {}

  void setFields() {
    titleController.text = selectedService.value.title;
    subTitleController.text = selectedService.value.subTitle;
    descController.text = selectedService.value.desc;
    priceController.text = selectedService.value.price.toString();
    thumbController.text = selectedService.value.image.split('/').last;
  }
}
