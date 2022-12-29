import 'package:al_dana/app/data/data.dart';
import 'package:get/get.dart';

class TrackPageController extends GetxController {
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
}
