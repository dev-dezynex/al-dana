import 'package:al_dana/app/data/data.dart';
import 'package:get/get.dart';

class SpareController extends GetxController {
  var selectedSpareCategory = SpareCategory().obs;
  @override
  void onInit() {
    super.onInit();
    if (Get.arguments != null) {
      selectedSpareCategory.value = Get.arguments;
    }
  }


}
