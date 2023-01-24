import 'package:al_dana/app/data/data.dart';
import 'package:get/get.dart';

class TrackPageController extends GetxController {
  var booking = Booking().obs;
  var tabIndex = 0.obs;
  var imageBeforeIndex = 0.obs;
  var imageAfterIndex = 0.obs;
  @override
  void onInit() {
    super.onInit();
    booking.value = Get.arguments;
    print("bokking ${booking.value.id}");
  }


}
