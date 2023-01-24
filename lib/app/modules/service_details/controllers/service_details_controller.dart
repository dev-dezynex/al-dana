import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/data.dart';
import '../../../routes/app_pages.dart';

class ServiceDetailsController extends GetxController {
  var isLoading = false.obs;
  var extraServiceResult = ServiceResult().obs;
  var booking = Booking().obs;

  @override
  void onInit() {
    super.onInit();
    booking.value = Get.arguments;
    getDetails();
  }



  void getDetails() {
    getServices();
  }

  void getServices() async {
    extraServiceResult.value = await ServiceProvider().getExtraDummyData();
    extraServiceResult.refresh();
  }

  void onNextClick(BuildContext context) {
    bool isNeedSpare = false;
    RxList<SpareCategory> spareCategoryList = <SpareCategory>[].obs;

    for (Service service in booking.value.services!) {
      if (service.spareCategory.id != null &&
          service.spareCategory.id!.isNotEmpty) {
        isNeedSpare = true;
        spareCategoryList.add(service.spareCategory);
      }
    }

    if (isNeedSpare) {
      Rx<Spare> selectedSpare = Spare().obs;
      spareSelectionBottomSheet(
          context: context,
          spareCategoryList: spareCategoryList,
          selectedSpare: selectedSpare,
          onAutoSelectChange: (bool) {
            booking.value.autoSpareSelect = true;
          },
          onSpareSelected: (Spare? spare) {
            for (Spare inSpare in booking.value.spares!) {
              if (inSpare.categoryId == spare!.categoryId) {
                booking.value.spares!.remove(inSpare);
              }
            }
            booking.value.autoSpareSelect = false;
            booking.value.spares!.add(spare!);
          },
          isAutoSelect: true.obs,
          onSubmit: () {
            Get.toNamed(Routes.MAP_PAGE, arguments: booking.value);
          });
    } else {
      Get.toNamed(Routes.MAP_PAGE, arguments: booking.value);
    }
  }
}
