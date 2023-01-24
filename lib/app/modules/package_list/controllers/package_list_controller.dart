import 'package:al_dana/app/data/data.dart';
import 'package:get/get.dart';

class PackageListController extends GetxController {
  var packageResult = PackageResult().obs;
  @override
  void onInit() {
    super.onInit();
    getPackages();
  }



  void getPackages() async {
    packageResult.value = await PackageProvider().getDummyData();
    packageResult.refresh();
  }
}
