import 'package:al_dana/app/data/data.dart';
import 'package:get/get.dart';

import '../../../routes/app_pages.dart';

class ServiceController extends GetxController {
  var common = Common();
  var isLoading = false.obs;
  var serviceResult = ServiceResult().obs;
  var packageResult = PackageResult().obs;
  var selectedService = Service(spareCategory: SpareCategory()).obs;
  var selectedPackage = PackageModel().obs;
  var isServiceSelected = false.obs;
  var selectedVehicle = Vehicle().obs;
  var price = 0.0.obs;
  var isSelected = false.obs;
  @override
  void onInit() {
    super.onInit();
    selectedVehicle.value = common.selectedVehicle;
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
    getServices();
    getPackages();
  }

  void getPackages() async {
    packageResult.value = await PackageProvider().getDummyData();
    packageResult.refresh();
  }

  void getServices() async {
    serviceResult.value = await ServiceProvider().getDummyData();
    serviceResult.refresh();
  }

  gotoDetailsPage() {
    if (isSelected.value) { 
      Booking booking = Booking(
        branch: common.selectedBranch,
        mode: common.selectedMode,
        vehicle: selectedVehicle.value,
        services: [],
        packageList: [],
        spares: [],
        approvalStatus: "PENDING",
        date: "",
        slot: "",
        price: price.value

      );
      if (isServiceSelected.value) {
        booking.services!.add(selectedService.value);
      } else {
        booking.packageList!.add(selectedPackage.value);
      }
      Get.toNamed(Routes.SERVICE_DETAILS,arguments: booking);
    } else {
      Get.snackbar('Error', 'Please choose a service to continue.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: textDark20,
          colorText: textDark80);
    }
  }
}
