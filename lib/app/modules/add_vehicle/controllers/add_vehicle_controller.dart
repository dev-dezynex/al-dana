import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/data.dart';

class AddVehicleController extends GetxController {
  var title = 'Select Vehicle'.obs;
  var pageIndex = 0.obs;
  var progress = 0.3.obs;
  var brandResult = BrandResult(brandList: [Brand(variantList: [])]).obs;
  var colorList = <VehicleColor>[].obs;
  var yearList = <VehicleYear>[].obs;

  var filterBrands = <Brand>[].obs;
  var selectedBrand = Brand().obs;
  var variantList = <Variant>[].obs;
  var selectedVariant = Variant().obs;
  var selectedYear = VehicleYear().obs;
  var selectedColor = VehicleColor().obs;
  var selectedVehicle = Vehicle().obs;
  TextEditingController variantController = TextEditingController();
  TextEditingController yearController = TextEditingController();
  TextEditingController plateCodeController = TextEditingController();
  TextEditingController plateNumberController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  @override
  void onInit() {
    super.onInit();
    getDetails();
  }



  getDetails() {
    getbrands();
    getColors();
    getYears();
  }

  void search({required String key}) {
    filterBrands.value = brandResult.value.brandList
        .where(
            (element) => element.name.toLowerCase().contains(key.toLowerCase()))
        .toList();
    filterBrands.refresh();
  }

  getbrands() async {
    brandResult.value = await BrandProvider().getDummyData();
    filterBrands.value = brandResult.value.brandList;
    brandResult.refresh();
    filterBrands.refresh();
  }

  getColors() async {
    colorList.value = (await ColorProvider().getDummyData()).colorList!;
    colorList.refresh();
  }

  getYears() async {
    yearList.value = (await YearProvider().getDummyData()).yearList!;
    yearList.refresh();
  }
}
