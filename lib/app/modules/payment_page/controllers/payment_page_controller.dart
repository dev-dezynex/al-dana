import 'dart:developer';

import 'package:al_dana/app/data/data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class PaymentPageController extends GetxController {
  Common common = Common();
  TextEditingController promoCodeController = TextEditingController();
  var isLoading = false.obs;
  var isCouponApplied = false.obs;
  final Razorpay _razorpay = Razorpay();
  var paymentOptions = ['Pay by Credit Card / Debit Card', 'Pay with Cash'].obs;
  var selectedPaymentOption = ''.obs;
  var isPaymentSuccess = false.obs;
  var selectedRedeemPoints = 0.obs;
  var isRewardApplied = false.obs;
  var walletResult = WalletResult().obs;
  var booking = Booking().obs;
  String? bookingId;
  @override
  void onInit() {
    super.onInit();
    booking.value = Get.arguments;
    getDetails();
  }

  @override
  void onClose() {
    _razorpay.clear();
    super.onClose();
  }

  void onNextClick(BuildContext context) {}

  void getDetails() async {
    isLoading(true);
    await getWalletPoints();
    paymentGatwayListeners();
    isLoading(false);
  }

  getWalletPoints() async {
    walletResult.value = await WalletProvider().getWallet();
    walletResult.refresh();
    selectedRedeemPoints.value = walletResult.value.wallet!.rewardPoint!;
  }

  redeemPoints() async {
    isLoading(true);
    var result = await WalletProvider().redeemWallet(
        point: selectedRedeemPoints.value,
        totalAmount: double.parse(booking.value.price.toStringAsFixed(2)));

    if (result.status == 'success') {
      walletResult.value.wallet!.rewardPoint =
          result.walletRedeem!.balancePoint;
      booking.value.price = result.walletRedeem!.totalAmount!;
    } else {
      Get.snackbar('Error', result.message!,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: textDark20,
          colorText: textDark80);
    }
    isLoading(false);
  }

  applyCoupon() async {
    isLoading(true);

    var result = await CouponProvider().redeemCoupon(
        couponCode: promoCodeController.text, totalAmount: booking.value.price);
    if (result.status == 'success') {
      booking.value.couponCode = promoCodeController.text;
      booking.value.price = result.coupon!.totalAmount!;
    } else {
      Get.snackbar('Error', result.message!,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: textDark20,
          colorText: textDark80);
    }
    isLoading(false);
  }

  void paymentGatwayListeners() {
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    // Do something when payment succeeds
    isLoading(false);
    verifyPayment(response);
    print(
        "Payment success  \norderId: ${response.orderId} \npaymentId: ${response.paymentId} \nsignature: ${response.signature}");
    Get.snackbar('Payment success', '',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: textDark20,
        colorText: textDark80);
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    // Do something when payment fails
    isLoading(false);
    print('Payment failed with:  ${response.message}');
    Get.snackbar('Payment failed', '',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: textDark20,
        colorText: textDark80);
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // Do something when an external wallet is selected
    isLoading(false);
    print('Payment wallet ${response.walletName}');
  }

  startPayment(String bookingId) async {
    isLoading(true);
    // double amount = (booking.value.price * 100);
    var result =
        await PaymentProvider().generateOrderId(bookingId, booking.value.price);
    print("order_id: $result");
    var options = {
      'key': razorKeyId,
      'amount': '${booking.value.price}', //in the smallest currency sub-unit.
      'name': 'Al Dana Service',
      'order_id': result.order.id, // Generate order_id using Orders API
      'description': 'We take care of the vehicle that take care of you',
      'timeout': 150, // in seconds
      'prefill': {
        'contact': common.currentUser.mobile,
        'email': common.currentUser.email
      }
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      print("Razorpay error $e");
    }
  }

  postBooking() async {
    isLoading(true);
    // print("booking.value");
    // print(booking.value.slot);
    var result = await BookingProvider().postBooking(booking: booking.value);
    if (result.status == 'success') {
      if (selectedPaymentOption.value != paymentOptions[1]) {
        startPayment(result.booking!.id!);
        log("result.booking!.id!");
        log(result.booking!.id!);
      } else {
        isLoading(false);
        isPaymentSuccess.value = true;
      }
    } else {
      isLoading(false);
      Get.snackbar('Error', result.message!,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: textDark20,
          colorText: textDark80);
    }
  }

  void verifyPayment(PaymentSuccessResponse response) async {
    isLoading(true);

    // log('body: ${jsonEncode(booking.value)}');
    log('========================================================Verify payment========================================================');
    log('razorpay_payment_id:${response.paymentId}');
    log('razorpay_order_id:${response.orderId}');
    log('razorpay_signature:${response.signature}');
    log('bookingId:${booking.value.id}');
    log('slot:${booking.value.slot}');
    log('totalAmount:${booking.value.price}');
    log('branchId:${booking.value.branch!.id}');
    log('========================================================Verify payment========================================================');
    Map<String, dynamic> body = {
      "razorpay_payment_id": response.paymentId,
      "razorpay_order_id": response.orderId,
      "razorpay_signature": response.signature,
      "bookingId": booking.value.id,
      "totalAmount": booking.value.price,
      "branchId": booking.value.branch!.id,
    };
    var result = await BookingProvider().verifyPayment(body: body);
    if (result.status == 'success') {
      isPaymentSuccess.value = true;
    } else {
      Get.snackbar('Error', result.message!,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: textDark20,
          colorText: textDark80);
    }
    isLoading(false);
  }
}
