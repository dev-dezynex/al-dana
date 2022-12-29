import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:location/location.dart';

import '../../../data/data.dart';
import '../../../routes/app_pages.dart';

class HomeController extends GetxController {
  var bottomBarIndex = 1.obs;
  var bannerIndex = 0.obs;
  var categoryResult = CategoryResult().obs;
  TextEditingController vehicleController = TextEditingController();
  LocationData? currentLocation;
  var modeList = <ServiceMode>[].obs;
  var selectedMode = ServiceMode().obs;
  var vehicleList = <Vehicle>[].obs;
  var selectedVehicle = Vehicle().obs;
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
  void onClose() {}

  getDetails() {
    getService();
    getVehicles();
  }

  getService() async {
    categoryResult.value = await CategoryProvider().getDummyData();
    categoryResult.refresh();
  }

  getVehicles() async {
    vehicleList.value = (await VehicleProvider().getDummyData()).vehicleList!;
    vehicleList.refresh();
  }

  getCurrentLocation() {
    Location location = Location();
    location.getLocation().then((loc) => currentLocation = loc);
    location.onLocationChanged.listen((loc) {
      currentLocation = loc;
      update();
    });
  }

  void chooseVehicle(BuildContext context) {
    vehicleSelectionBottomSheet(
        context: context,
        vehicleList: vehicleList,
        selectedVehicle: selectedVehicle,
        onVehicleSelected: (Vehicle vehicle) {
          selectedVehicle.value = vehicle;
          vehicleController.text =
              '${vehicle.brand!.name} - ${vehicle.variant!.name}';
          storage.write(selected_vehicle, vehicle.toJson());
          Get.back();
        });
  }

  void chooseMode(BuildContext context, Category category) {
    modeSelectionBottomSheet(
        context: context,
        modeList: modeList,
        selectedMode: selectedMode,
        onModeSelected: (ServiceMode mode) {
          selectedMode.value = mode;
          storage.write(selected_mode, mode.toJson());
        },
        onSubmit: () {
          Get.back();
          Get.toNamed(Routes.SERVICE, arguments: category);
        });
  }

  void logout() {
    Get.dialog(
      AlertDialog(
        title: Text(
          "Logout",
          style: tsPoppins(color: primary, weight: FontWeight.w600, size: 18),
        ),
        content: Text(
          "Are you sure want to logout ?",
          style:
              tsPoppins(color: textDark40, weight: FontWeight.w400, size: 12),
        ),
        actions: <Widget>[
          TextButton(
            child: Text("cancel",
                style: tsPoppins(
                    color: primary, weight: FontWeight.w400, size: 14)),
            onPressed: () {
              Get.back();
            },
          ),
          TextButton(
            child: Text("Confirm",
                style: tsPoppins(
                    color: textDark80, weight: FontWeight.w600, size: 14)),
            onPressed: () {
              storage.erase();
              Get.offAllNamed(Routes.AUTH);
            },
          ),
        ],
      ),
      barrierDismissible: false,
    );
  }
}
