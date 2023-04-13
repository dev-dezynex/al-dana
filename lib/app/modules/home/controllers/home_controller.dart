import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:al_dana/app/data/models/banner_model.dart';
import 'package:al_dana/app/data/providers/banner_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:location/location.dart';

import '../../../data/data.dart';
import '../../../routes/app_pages.dart';

class HomeController extends GetxController {
  var common = Common();
  var currentUser = User().obs;
  var addressList = <Address>[].obs;
  var bottomBarIndex = 1.obs;
  var bannerIndex = 0.obs;
  var bannerResult = BannerResult().obs;
  var categoryResult = CategoryResult().obs;
  TextEditingController vehicleController = TextEditingController();
  LocationData? currentLocation;
  // var modeList = <ServiceMode>[].obs;
  // var selectedMode = ServiceMode().obs;
  var vehicleList = <Vehicle>[].obs;
  var selectedVehicle = Vehicle().obs;
  //for admin home
  var bookingResult = BookingResult().obs;
  var adminTabIndex = 0.obs;

  //for profile
  var file = File('').obs;
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  var isLoading = false.obs;
  var isProfileEdited = false.obs;

  @override
  void onInit() {
    super.onInit();
    getDetails();
  }

  @override
  void onClose() {}

  getDetails() async {
    isLoading(true);
    // if (common.currentUser.scope == 'admin') {
    // getBookings();
    // }
    // getModeList();
    await getCategories();
    await getVehicles();
    await getUserProfile();
    await getBanners();
    isLoading(false);
  }

  getCategories() async {
    categoryResult.value = await CategoryProvider().getCategories();
    categoryResult.refresh();
  }

  getVehicles() async {
    vehicleList.value = (await VehicleProvider().getVehicles()).vehicleList!;
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
              '${vehicle.brand!.title} - ${vehicle.variant!.name}';
          storage.write(selected_vehicle, vehicle.toJson());
          Get.back();
        });
  }

  // void chooseMode(BuildContext context, Category category) {
  //   modeSelectionBottomSheet(
  //       context: context,
  //       modeList: modeList,
  //       selectedMode: selectedMode,
  //       onModeSelected: (ServiceMode mode) {
  //         selectedMode.value = mode;
  //         storage.write(selected_mode, mode.toJson());
  //       },
  //       onSubmit: () {
  //         Get.back();
  //         Get.toNamed(Routes.SERVICE, arguments: category);
  //       });
  // }

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

  void getBookings() async {
    bookingResult.value = await BookingProvider().getBookingHistory();
    bookingResult.refresh();
  }

  //for profile

  pickImage(ImageSource sourse) async {
    var image = (await FileProvider().pickImage(imageSource: sourse))!;

    print('file picked ${file.value.path.split('/').last}');

    file.value = (await FileProvider().cropImage(image))!;

    if (file.value.path.isNotEmpty) {
      updateProfile();
    }
  }

  Future<String> imageUpload() async {
    if (file.value.path.isNotEmpty) {
      var result = await FileProvider().uploadSingleFile(file: file.value);
      if (result['status'] == 'success') {
        return result['data'][0];
      }
    }
    return currentUser.value.image;
  }

  void updateProfile() async {
    isLoading(true);
    String imagePath = await imageUpload();
    var result = await UserProvider().updateProfile(
        userProfile: currentUser.value.copyWith(
      name: nameController.text,
      email: emailController.text,
      image: imagePath,
    ));

    if (result.status == 'success') {
      getUserProfile();
    } else {
      Get.snackbar('Error', result.message,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: textDark20,
          colorText: textDark80);
    }
  }

  getUserProfile() async {
    currentUser.value = (await UserProvider().getProfile()).user;
    log('&&&&&&current User ${jsonEncode(currentUser.value)}');
    storage.write(user_details, currentUser.value.toJson());
    setProfileFields();
  }

  void setProfileFields() {
    nameController.text = currentUser.value.name;
    emailController.text = currentUser.value.email;
    phoneController.text = currentUser.value.mobile.toString();
    addressList.addAll(currentUser.value.addressList);
  }

  getBanners() async {
    bannerResult.value = await BannerProvider().getBanners();
    bannerResult.refresh();
  }

  // void getModeList() async {
  //   modeList.value = (await ServiceModeProvider().getModes()).serviceModeList!;
  //   modeList.refresh();
  // }
}
