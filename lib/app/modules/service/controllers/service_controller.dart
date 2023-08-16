import 'dart:developer';

import 'package:al_dana/app/data/data.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../routes/app_pages.dart';

class ServiceController extends GetxController {
  var common = Common();
  var isLoading = false.obs;
  var serviceResult = ServiceResult().obs;
  var packageResult = PackageResult().obs;
  var selectedService = Service(spareCategory: SpareCategory()).obs;
  var selectedPackage = PackageModel().obs;
  var selectedCategory = Category().obs;
  var isServiceSelected = false.obs;
  var selectedVehicle = Vehicle().obs;
  var price = 0.0.obs;
  var packageId = ''.obs;
  var isSelected = false.obs;
  var selectedMode = ServiceMode().obs;
  @override
  void onInit() {
    super.onInit();
    selectedVehicle.value = common.selectedVehicle;
    selectedCategory.value = common.selectedCategory;
    getDetails();
  }

  void getDetails() async {
    isLoading(true);
    await getServices();
    await getPackages();
    isLoading(false);
  }

  getPackages() async {
    log('branch id');
    log(common.selectedBranch.id);
    packageResult.value = await PackageProvider()
        .getPackageList(branchId: common.selectedBranch.id);
    packageResult.refresh();
  }

  getServices() async {
    serviceResult.value = await ServiceProvider().getServices();
    serviceResult.refresh();
  }

  void chooseMode(BuildContext context) {
    if (isSelected.value) {
      RxList<ServiceMode> serviceModeList = <ServiceMode>[].obs;
      if (isServiceSelected.value) {
        serviceModeList.value = selectedService.value.serviceModeList;
      } else {
        serviceModeList.value = selectedPackage.value.serviceModeList!;
      }
      modeSelectionBottomSheet(
          context: context,
          modeList: serviceModeList,
          selectedMode: selectedMode,
          onModeSelected: (ServiceMode mode) {
            selectedMode.value = mode;
            storage.write(selected_mode, mode.toJson());
          },
          onSubmit: () {
            log(selectedMode.value.title);
            if (selectedMode.value.title != "") {
              log(selectedMode.value.title);
              Get.back();
              gotoDetailsPage();
            }
          });
    } else {
      Get.snackbar('Error', 'Please choose a service to continue.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: textDark20,
          colorText: textDark80);
    }
  }

  gotoDetailsPage() {
    Booking booking = Booking(
        branch: common.selectedBranch,
        mode: selectedMode.value,
        vehicle: selectedVehicle.value,
        services: [],
        packageList: [],
        spares: [],
        approvalStatus: "PENDING",
        date: "",
        slot: "",
        address: Address(),
        price: price.value);
    if (isServiceSelected.value) {
      booking.services!.add(selectedService.value);
    } else {
      booking.packageList!.add(selectedPackage.value);
    }
    Get.toNamed(Routes.SERVICE_DETAILS, arguments: booking);
  }
}
