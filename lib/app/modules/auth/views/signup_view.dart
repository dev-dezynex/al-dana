import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/data.dart';
import '../controllers/auth_controller.dart';

class SignUp extends GetView<AuthController> {
  final GlobalKey<FormState> formKeyOtp = GlobalKey<FormState>();

  SignUp({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: white,
      body: SafeArea(
        child: SizedBox(
          width: Get.width,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: Get.height * .05,
                ),
                Image.asset(
                  'assets/auth/auth.png',
                  height: Get.height * .3,
                ),
                SizedBox(
                  height: Get.height * .05,
                ),
                SizedBox(
                  width: Get.width * .7,
                  child: Text(
                    'SIGN UP',
                    textAlign: TextAlign.center,
                    style: tsPoppins(
                        color: black, weight: FontWeight.w600, size: 18),
                  ),
                ),
                SizedBox(
                  width: Get.width * .7,
                  child: Text(
                    'Please enter your details to continue',
                    textAlign: TextAlign.center,
                    style: tsPoppins(
                        color: textColor02, weight: FontWeight.w600, size: 14),
                  ),
                ),
                SizedBox(height: Get.height * .05),
                Container(
                  width: Get.width,
                  alignment: Alignment.center,
                  child: Column(
                    children: [
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: Get.width * .14),
                        child: Form(
                            key: formKeyOtp,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            child: Column(
                              children: [
                                TextFormField(
                                  controller: controller.nameController,
                                  textAlignVertical: TextAlignVertical.center,
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
                                      color: black),
                                  decoration: InputDecoration(
                                    contentPadding:
                                        const EdgeInsets.only(left: 0),
                                    labelText: "Enter Name",
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
                                  textAlignVertical: TextAlignVertical.center,
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
                                      color: black),
                                  decoration: InputDecoration(
                                    contentPadding:
                                        const EdgeInsets.only(left: 0),
                                    labelText: "Enter Email",
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
                Obx(
                  () => controller.isLoading.value
                      ? const CircularProgressIndicator(
                          color: white,
                        )
                      // : InkWell(
                      //     customBorder: const CircleBorder(),
                      //     onTap: () {
                      //       if (formKeyOtp.currentState!.validate()) {
                      //         controller.signup();
                      //       }
                      //     },
                      //     child: Ink(
                      //       padding: const EdgeInsets.all(18),
                      //       decoration: const BoxDecoration(
                      //           shape: BoxShape.circle, color: accent),
                      //       child: const Icon(
                      //         Icons.arrow_forward_rounded,
                      //         color: primary,
                      //         size: 24,
                      //       ),
                      //     ),
                      //   ),
                      : FractionallySizedBox(
                          widthFactor: 0.7,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: greenAppTheme,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            onPressed: () {
                              if (formKeyOtp.currentState!.validate()) {
                                controller.signup();
                              }
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: const [
                                Text('Continue'),
                                CircleAvatar(
                                  radius: 12,
                                  backgroundColor: Colors.lightGreen,
                                  child: Icon(
                                    Icons.arrow_forward,
                                    color: Colors.white,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                ),
                SizedBox(height: Get.height * .1),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
