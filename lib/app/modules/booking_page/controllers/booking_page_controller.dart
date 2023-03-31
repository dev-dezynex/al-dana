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

  getDetails() {
    getBookingHistory();
  }

  getBookingHistory() async {
    isLoading(true);
    bookingResult.value = await BookingProvider().getBookingHistory();
    bookingResult.refresh();
    isLoading(false);
  }
}
