import 'package:al_dana/app/data/data.dart';
import 'package:get/get.dart';

class WorkController extends GetxController {
  var workResult = WorkResult().obs;
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

  void getDetails() {
    getWorks();
  }

  void getWorks() async {
    workResult.value = await WorkProvider().getDummyData();
    workResult.refresh();
  }
}
