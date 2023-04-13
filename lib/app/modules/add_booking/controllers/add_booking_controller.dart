import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../data/data.dart';

class AddBookingController extends GetxController {
  TextEditingController dateController =
      TextEditingController(text: outputDateFormat2.format(DateTime.now()));
  var selectedDate = DateTime.now().obs;
  var isLoading = false.obs;
  var timeSlotResult = TimeSlotResult().obs;
  // var availableTimeSlots = <String>[].obs;
  var selectedTimeSlot = TimeSlot();
  var booking = Booking().obs;

  @override
  void onInit() {
    super.onInit();
    booking.value = Get.arguments;
    getDetails();
  }

  chooseDate() async {
    selectedDate.value = await pickDate(firstDate: DateTime.now());
    dateController.text = outputDateFormat2.format(selectedDate.value);

    getTimeSlots();
  }

  void getDetails() {
    getTimeSlots();
  }

  void getTimeSlots() async {
    isLoading(true);
    timeSlotResult.value = await TimeSlotProvider().getTimeSlots();
    timeSlotResult.refresh();
    isLoading(false);
    // if (timeSlotResult.value.timeSlotList.isNotEmpty) {
    //   setAvailableTimeSlots();
    // }
  }

  // setAvailableTimeSlots() {
  //   TimeSlot slot = timeSlotResult.value.timeSlotList.firstWhere(
  //       (element) =>
  //           element.day.toLowerCase() ==
  //           dayFormat.format(selectedDate.value).toLowerCase(),
  //       orElse: () => TimeSlot());

  //   availableTimeSlots.value = slot.slotes;
  //   availableTimeSlots.refresh();
  // }

  onNextClick(String route) {
    if (selectedTimeSlot.sId!.isNotEmpty) {
      booking.value.date = inputDateFormat.format(selectedDate.value);
      booking.value.slot = selectedTimeSlot.sId;
      Get.toNamed(route, arguments: booking.value);
    } else {
      Get.snackbar('Error', 'Please choose a time slot to continue.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: textDark20,
          colorText: textDark80);
    }
  }
}
