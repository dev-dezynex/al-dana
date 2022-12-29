import 'dart:io';

import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../data/data.dart';
import '../controllers/add_service_controller.dart';

class AddServiceView extends GetView<AddServiceController> {
  AddServiceView({Key? key}) : super(key: key);
  final GlobalKey<FormState> formKeyAddPdf = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Add Service'),
          centerTitle: true,
        ),
        body: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: Get.width,
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 35),
                decoration: BoxDecoration(
                    color: white, borderRadius: BorderRadius.circular(15)),
                child: Form(
                  key: formKeyAddPdf,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: Obx(
                    () => Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextFormField(
                          controller: controller.titleController,
                          textAlignVertical: TextAlignVertical.center,
                          keyboardType: TextInputType.text,
                          validator: (String? value) {
                            if (value == null || value.isEmpty) {
                              return "Required Title";
                            } else {
                              return null;
                            }
                          },
                          style: tsPoppins(
                              size: 14,
                              weight: FontWeight.w400,
                              color: textDark80),
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.only(left: 0),
                            labelText: "Enter Title",
                            labelStyle: tsPoppins(
                                size: 14,
                                weight: FontWeight.w400,
                                color: textColor02),
                            enabledBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: borderColor,
                              ),
                            ),
                            focusedBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(color: borderColor),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        TextFormField(
                          controller: controller.subTitleController,
                          textAlignVertical: TextAlignVertical.center,
                          keyboardType: TextInputType.text,
                          validator: (String? value) {
                            if (value == null || value.isEmpty) {
                              return "Required Sub Title";
                            } else {
                              return null;
                            }
                          },
                          style: tsPoppins(
                              size: 14,
                              weight: FontWeight.w400,
                              color: textDark80),
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.only(left: 0),
                            labelText: "Enter Sub Title",
                            labelStyle: tsPoppins(
                                size: 14,
                                weight: FontWeight.w400,
                                color: textColor02),
                            enabledBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: borderColor,
                              ),
                            ),
                            focusedBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(color: borderColor),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        TextFormField(
                          controller: controller.descController,
                          textAlignVertical: TextAlignVertical.center,
                          keyboardType: TextInputType.text,
                          validator: (String? value) {
                            if (value == null || value.isEmpty) {
                              return "Required Description";
                            } else {
                              return null;
                            }
                          },
                          style: tsPoppins(
                              size: 14,
                              weight: FontWeight.w400,
                              color: textDark80),
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.only(left: 0),
                            labelText: "Enter Description",
                            labelStyle: tsPoppins(
                                size: 14,
                                weight: FontWeight.w400,
                                color: textColor02),
                            enabledBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: borderColor,
                              ),
                            ),
                            focusedBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(color: borderColor),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: Get.height * .02,
                        ),
                        TextFormField(
                          controller: controller.thumbController,
                          textAlignVertical: TextAlignVertical.center,
                          keyboardType: TextInputType.text,
                          readOnly: true,
                          style: tsPoppins(
                              size: 14,
                              weight: FontWeight.w400,
                              color: textDark80),
                          decoration: InputDecoration(
                            prefixIcon: const Icon(
                              Icons.photo_library_rounded,
                              color: textDark60,
                            ),
                            suffix: IconButton(
                                onPressed: () {
                                  controller.thumbController.text = '';
                                  controller.thumbFile.value = File('');
                                },
                                icon: const Icon(
                                  Icons.delete,
                                  color: textDark60,
                                )),
                            contentPadding: const EdgeInsets.only(left: 0),
                            labelText: "Upload Thumbnail",
                            labelStyle: tsPoppins(
                                size: 14,
                                weight: FontWeight.w400,
                                color: textColor02),
                            enabledBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: borderColor,
                              ),
                            ),
                            focusedBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(color: borderColor),
                            ),
                          ),
                          onTap: () {
                            controller.pickThumb();
                          },
                        ),
                        const SizedBox(height: 15),
                        const SizedBox(
                          height: 35,
                        ),
                        if (controller.isLoading.value)
                          const CircularProgressIndicator(color: primary),
                        if (!controller.isLoading.value &&
                            !controller.isUpdate.value)
                          ElevatedButton(
                              onPressed: () {
                                if (formKeyAddPdf.currentState!.validate()) {
                                  controller.createService();
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                  primary: primary,
                                  minimumSize: Size(Get.width, 50),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10))),
                              child: Text('Create Service',
                                  style: tsPoppins(
                                      color: white,
                                      weight: FontWeight.w600,
                                      size: 15))),
                        if (!controller.isLoading.value &&
                            controller.isUpdate.value)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              ElevatedButton(
                                  onPressed: () {
                                    myAlertDialog(
                                        title: 'Confirm',
                                        message:
                                            'Do you want to delete this service ?',
                                        onCancel: () {
                                          Get.back();
                                        },
                                        onSubmit: () {
                                          controller.deleteService();
                                        });
                                  },
                                  style: ElevatedButton.styleFrom(
                                      primary: white,
                                      minimumSize: Size(Get.width * .4, 50),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          side: const BorderSide(
                                              color: primary, width: 2))),
                                  child: Text('Delete',
                                      style: tsPoppins(
                                          color: primary,
                                          weight: FontWeight.w600,
                                          size: 15))),
                              ElevatedButton(
                                  onPressed: () {
                                    if (formKeyAddPdf.currentState!
                                        .validate()) {
                                      controller.createService();
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                      primary: primary,
                                      minimumSize: Size(Get.width * .4, 50),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10))),
                                  child: Text('Update',
                                      style: tsPoppins(
                                          color: white,
                                          weight: FontWeight.w600,
                                          size: 15))),
                            ],
                          ),
                        const SizedBox(
                          height: 35,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
