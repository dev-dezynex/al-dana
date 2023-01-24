import 'package:al_dana/app/data/data.dart';
import 'package:get/get.dart';

class ServiceListController extends GetxController {
  var isLoading = false.obs;
  var serviceResult = ServiceResult().obs;
  @override
  void onInit() {
    super.onInit();
    getServices();
  }



  getServices() async {
    serviceResult.value = await ServiceProvider().getDummyData();
    serviceResult.refresh();
  }
}
