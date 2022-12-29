import 'package:al_dana/app/modules/auth/controllers/auth_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

import '../../../data/data.dart';

class PhoneView extends GetView<AuthController> {
  final GlobalKey<FormState> formKeySignIn = GlobalKey<FormState>();

  PhoneView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: primary,
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 0,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: primary,
          statusBarIconBrightness: Brightness.light,
          statusBarBrightness: Brightness.light,
        ),
        backgroundColor: primary,
        automaticallyImplyLeading: false,
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
                      SizedBox(height: Get.height * .1),
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
                            'Please enter your phone\nnumber to verify',
                            textAlign: TextAlign.center,
                            style: tsPoppins(
                                color: white,
                                weight: FontWeight.w600,
                                size: 14),
                          )),
                      SizedBox(height: Get.height * .05),
                      Form(
                        key: formKeySignIn,
                        child: SizedBox(
                            width: Get.width * .7,
                            child: IntlPhoneField(
                              controller: controller.phoneController,
                              onTap: null,
                              style: tsPoppins(
                                  color: white,
                                  size: 14,
                                  weight: FontWeight.w400),
                              dropdownTextStyle: tsPoppins(
                                  color: white,
                                  size: 14,
                                  weight: FontWeight.w400),
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                              ],
                              dropdownIcon: const Icon(
                                Icons.arrow_drop_down,
                                color: white,
                              ),
                              showDropdownIcon: false,
                              decoration: InputDecoration(
                                iconColor: textDark40,
                                counterStyle: tsPoppins(
                                    color: textDark60,
                                    size: 14,
                                    weight: FontWeight.w400),
                                contentPadding:
                                    const EdgeInsets.symmetric(vertical: 15),
                                hintText: 'Enter your number',
                                hintStyle: tsPoppins(
                                    color: textDark40,
                                    size: 14,
                                    weight: FontWeight.w400),
                                border: const UnderlineInputBorder(
                                    borderSide: BorderSide(color: textDark20)),
                                focusedBorder: const UnderlineInputBorder(
                                    borderSide: BorderSide(color: textDark20)),
                                errorBorder: const UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.red)),
                                focusedErrorBorder: const UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.red)),
                                enabledBorder: const UnderlineInputBorder(
                                    borderSide: BorderSide(color: textDark20)),
                                disabledBorder: const UnderlineInputBorder(
                                    borderSide: BorderSide(color: textDark20)),
                              ),
                              initialCountryCode: 'IN',
                              onCountryChanged: (code) {
                                controller.contryCode = code.dialCode;
                              },
                            )),
                      ),
                      SizedBox(
                        height: Get.height * .2,
                      ),
                      Obx(
                        () => controller.isLoading.value
                            ? const CircularProgressIndicator(
                                color: white,
                              )
                            : InkWell(
                                customBorder: const CircleBorder(),
                                onTap: () {
                                  if (formKeySignIn.currentState!.validate()) {
                                    controller.requestOTP();
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
                      SizedBox(
                        height: Get.height * .2,
                      ),
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
