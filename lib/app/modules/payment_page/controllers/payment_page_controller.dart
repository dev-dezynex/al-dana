import 'package:al_dana/app/data/data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PaymentPageController extends GetxController {
  TextEditingController promoCodeController = TextEditingController();
  var paymentOptions = ['Pay by Credit Card / Debit Card', 'Pay with Cash'].obs;
  var selectedPaymentOption = ''.obs;
  var isPaymentSuccess = false.obs;

  var booking = Booking().obs;
  @override
  void onInit() {
    super.onInit();
    booking.value = Get.arguments;
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void onNextClick(BuildContext context) {
    isPaymentSuccess.value = true;
  }
}
