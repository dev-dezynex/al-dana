import 'package:al_dana/app/data/data.dart';
import 'package:get/get.dart';

class BookingPageController extends GetxController {
  var bookingResult = BookingResult().obs;
  var isLoading = false.obs;
  @override
  void onInit() {
    super.onInit();
    getDetails();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  getDetails() {
    getBookingHistory();
  }

  getBookingHistory() async {
    bookingResult.value = await BookingProvider().getBookingHistory();
    bookingResult.refresh();
  }
}
