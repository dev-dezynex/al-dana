import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../data/data.dart';
import '../controllers/auth_controller.dart';

class SignUp extends GetView<AuthController> {
  final GlobalKey<FormState> formKeyOtp = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: primary,
      appBar: AppBar(
        elevation: 0,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: primary,
          statusBarIconBrightness: Brightness.light,
          statusBarBrightness: Brightness.light,
        ),
        backgroundColor: primary,
        leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: white),
            onPressed: () => Navigator.of(context).pop()),
        centerTitle: true,
        title: Text(
          "",
          style: tsPoppins(size: 16, weight: FontWeight.w500, color: white),
        ),
      ),
      body: SafeArea(
        child: Ink(
          height: Get.height,
          width: Get.width,
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  colors: [primary, primary2],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter)),
          child: Stack(
            alignment: Alignment.bottomCenter,
            fit: StackFit.expand,
            children: [
              SizedBox(
                width: Get.width,
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: Get.height * .05,
                      ),
                      SvgPicture.asset(
                        "assets/icons/ic_auth.svg",
                        width: Get.width * .3,
                        height: Get.height * .15,
                      ),
                      SizedBox(
                        height: Get.height * .05,
                      ),
                      SizedBox(
                          width: Get.width * .7,
                          child: Text(
                            'Please enter your details to continue',
                            textAlign: TextAlign.center,
                            style: tsPoppins(
                                color: textColor02,
                                weight: FontWeight.w600,
                                size: 14),
                          )),
                      SizedBox(height: Get.height * .05),
                      Container(
                        width: Get.width,
                        alignment: Alignment.center,
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: Get.width * .14),
                              child: Form(
                                  key: formKeyOtp,
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  child: Column(
                                    children: [
                                      TextFormField(
                                        controller: controller.nameController,
                                        textAlignVertical:
                                            TextAlignVertical.center,
                                        keyboardType: TextInputType.text,
                                        validator: (String? value) {
                                          if (value == null || value.isEmpty) {
                                            return "Required Name";
                                          } else {
                                            return null;
                                          }
                                        },
                                        style: tsPoppins(
                                            size: 14,
                                            weight: FontWeight.w400,
                                            color: white),
                                        decoration: InputDecoration(
                                          contentPadding:
                                              const EdgeInsets.only(left: 0),
                                          labelText: "Enter Name",
                                          labelStyle: tsPoppins(
                                              size: 14,
                                              weight: FontWeight.w400,
                                              color: textColor02),
                                          enabledBorder:
                                              const UnderlineInputBorder(
                                            borderSide: BorderSide(
                                              color: borderColor,
                                            ),
                                          ),
                                          focusedBorder:
                                              const UnderlineInputBorder(
                                            borderSide:
                                                BorderSide(color: borderColor),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      TextFormField(
                                        controller: controller.emailController,
                                        textAlignVertical:
                                            TextAlignVertical.center,
                                        keyboardType: TextInputType.text,
                                        validator: (String? value) {
                                          if (value == null || value.isEmpty) {
                                            return "Required Email";
                                          } else if (!RegExp(
                                                  r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$")
                                              .hasMatch(value)) {
                                            return "Please enter valid email";
                                          } else {
                                            return null;
                                          }
                                        },
                                        style: tsPoppins(
                                            size: 14,
                                            weight: FontWeight.w400,
                                            color: white),
                                        decoration: InputDecoration(
                                          contentPadding:
                                              const EdgeInsets.only(left: 0),
                                          labelText: "Enter Email",
                                          labelStyle: tsPoppins(
                                              size: 14,
                                              weight: FontWeight.w400,
                                              color: textColor02),
                                          enabledBorder:
                                              const UnderlineInputBorder(
                                            borderSide: BorderSide(
                                              color: borderColor,
                                            ),
                                          ),
                                          focusedBorder:
                                              const UnderlineInputBorder(
                                            borderSide:
                                                BorderSide(color: borderColor),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                    ],
                                  )),
                            ),
                            SizedBox(height: Get.height * .02),
                          ],
                        ),
                      ),
                      SizedBox(height: Get.height * .2),
                      Obx(
                        () => controller.isLoading.value
                            ? const CircularProgressIndicator(
                                color: white,
                              )
                            : InkWell(
                                customBorder: const CircleBorder(),
                                onTap: () {
                                  if (formKeyOtp.currentState!.validate()) {
                                    controller.signup();
                                  }
                                },
                                child: Ink(
                                  padding: const EdgeInsets.all(18),
                                  decoration: const BoxDecoration(
                                      shape: BoxShape.circle, color: accent),
                                  child: const Icon(
                                    Icons.arrow_forward_rounded,
                                    color: primary,
                                    size: 24,
                                  ),
                                )),
                      ),
                      SizedBox(height: Get.height * .2),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
