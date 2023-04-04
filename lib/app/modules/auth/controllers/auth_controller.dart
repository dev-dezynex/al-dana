import 'package:al_dana/app/data/constants/enums.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/data.dart';
import '../../../routes/app_pages.dart';

class AuthController extends GetxController {
  var isLoading = false.obs;
  String contryCode = '971';
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  final shakeKey = GlobalKey<ShakeWidgetState>();
  final otpFocus1 = FocusNode(),
      otpFocus2 = FocusNode(),
      otpFocus3 = FocusNode(),
      otpFocus4 = FocusNode(),
      otpFocus5 = FocusNode(),
      otpFocus6 = FocusNode();
  var isOTPEmpty = false.obs;
  var isTimerEnd = false.obs;
  final otp = '******'.obs;

  var authView = AuthStatus.phone.obs;
  @override
  void onInit() {
    super.onInit();
    if (Get.arguments != null) {
      authView.value = Get.arguments;
    }
  }

  @override
  void onClose() {}

  void requestOTP() {
    authView.value = AuthStatus.otp;
  }

  changeOTP(String digit, int index) {
    print('before otp $otp');
    if (digit.isEmpty) {
      otp.value = '${otp.substring(0, index)}*${otp.substring(index + 1)}';
    } else {
      otp.value = otp.substring(0, index) + digit + otp.substring(index + 1);
    }
    print('after otp $otp');
  }

  void verifyOTP() async {
    isLoading(true);
    var result = await UserProvider().verifyOTP(
        phoneNumber: '$contryCode${phoneController.text}', otp: otp.value);

    if (result.status == 'success') {
      var result = await UserProvider().getProfile();
      if (result.status == 'success') {
        storage.write(user_details, result.user.toJson());
        storage.write(is_login, true);
        Get.offAllNamed(Routes.BRANCH);
      } else {
        showError(result.message);
      }
    } else if (result.message.toLowerCase() == 'new user') {
      authView.value = AuthStatus.signup;
    } else {
      showError(result.message);
    }

    isLoading(false);
  }

  showError(String message) {
    Get.snackbar('Error', message,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: textDark20,
        colorText: textDark80);
  }

  void signup() async {
    isLoading(true);
    var result = await UserProvider().signUp(
        user: User(
            name: nameController.text,
            mobile: int.parse('$contryCode${phoneController.text}'),
            email: emailController.text));

    if (result.status == 'success') {
      var result = await UserProvider().getProfile();
      if (result.status == 'success') {
        storage.write(user_details, result.user.toJson());
        storage.write(is_login, true);
        Get.offAllNamed(Routes.BRANCH);
      } else {
        showError(result.message);
      }
    } else {
      showError(result.message);
    }
    isLoading(false);
  }
}
