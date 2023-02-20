import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class SubscriptionPageController extends GetxController {
  var startDate = DateTime.now().obs;
  var endDate = DateTime.now().obs;
  var selectedTab = 0.obs;
  var tabs = ['Daily', 'Alternate', 'Custom'].obs;
  var dateRangeController1 = DateRangePickerController();
  var dateRangeController2 = DateRangePickerController();
  var dateRangeController3 = DateRangePickerController();
  var pickDateRange = PickerDateRange(DateTime.now(), DateTime.now()).obs;
  RxList<DateTime> alternateDateList = <DateTime>[].obs;
  RxList<DateTime> multiDateList = <DateTime>[].obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void setDateRange() {}

  void setDateList() {}
}
