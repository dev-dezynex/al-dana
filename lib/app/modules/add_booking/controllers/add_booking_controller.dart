import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../data/data.dart';
import '../../../routes/app_pages.dart';

class AddBookingController extends GetxController {
  TextEditingController dateController = TextEditingController(
      text: DateFormat('dd-MM-yyyy').format(DateTime.now()));
  var selectedDate = DateTime.now().obs;
  var isLoading = false.obs;
  var timeSlotResult = TimeSlotResult().obs;
  var availableTimeSlots = <String>[].obs;
  var selectedTimeSlot = ''.obs;
  var booking = Booking().obs;
  @override
  void onInit() {
    super.onInit();
    booking.value = Get.arguments;
    getDetails();
  }



  chooseDate() async {
    selectedDate.value = await pickDate(firstDate: DateTime.now());
    dateController.text = DateFormat('dd-MM-yyyy').format(selectedDate.value);
    if (timeSlotResult.value.timeSlotList.isNotEmpty) {
      setAvailableTimeSlots();
    }
  }

  void getDetails() {
    getTimeSlots();
  }

  void getTimeSlots() async {
    timeSlotResult.value = await TimeSlotProvider().getDummyData();
    timeSlotResult.refresh();
    if (timeSlotResult.value.timeSlotList.isNotEmpty) {
      setAvailableTimeSlots();
    }
  }

  setAvailableTimeSlots() {
    TimeSlot slot = timeSlotResult.value.timeSlotList.firstWhere(
        (element) =>
            element.day.toLowerCase() ==
            DateFormat('EEEE').format(selectedDate.value).toLowerCase(),
        orElse: () => TimeSlot());

    availableTimeSlots.value = slot.slotes;
    availableTimeSlots.refresh();
  }

  onNextClick() {
    if (selectedTimeSlot.isNotEmpty) {
      booking.value.date = DateFormat('dd-MM-yyyy').format(selectedDate.value);
      booking.value.slot = selectedTimeSlot.value;
      Get.toNamed(Routes.PAYMENT_PAGE, arguments: booking.value);
    } else {
      Get.snackbar('Error', 'Please choose a time slot to continue.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: textDark20,
          colorText: textDark80);
    }
  }
}
