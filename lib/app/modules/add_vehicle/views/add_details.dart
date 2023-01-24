import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../data/data.dart';
import '../controllers/add_vehicle_controller.dart';

class AddVehicleDetails extends GetView<AddVehicleController> {
  const AddVehicleDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Stack(
      fit: StackFit.expand,
      children: [
        SingleChildScrollView(
          child: Obx(() => controller.pageIndex.value > 1
              ? details2(context)
              : details1(context)),
        ),
        Positioned(
          bottom: 20,
          left: 15,
          right: 15,
          child: ElevatedButton(
              onPressed: () {
                if (controller.pageIndex.value > 1) {
                } else {
                  controller.selectedVehicle.value.variant =
                      controller.selectedVariant.value;
                  controller.selectedVehicle.value.year =
                      controller.selectedYear.value;
                  controller.selectedVehicle.value.colour =
                      controller.selectedColor.value;
                  controller.progress.value = 1.0;
                  controller.pageIndex.value = 2;
                }
              },
              style: ElevatedButton.styleFrom(
                  primary: bgColor27,
                  minimumSize: Size(Get.width, 50),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8))),
              child: Obx(() => Text(
                    controller.pageIndex.value > 1 ? 'Done' : 'Next',
                    style: tsPoppins(
                        color: white, size: 16, weight: FontWeight.w600),
                  ))),
        )
      ],
    ));
  }

  details1(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        children: [
          TextFormField(
              controller: controller.variantController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Select vehicle model";
                } else {
                  return null;
                }
              },
              onTap: () {
                variantSelectionBottomSheet(
                    context: context,
                    isSingleSelection: true,
                    variantList: controller.variantList,
                    selectedVariant: controller.selectedVariant,
                    onVariantSelected: (Variant variant) {
                      controller.selectedVariant.value = variant;
                      controller.variantController.text = variant.name;
                    });
              },
              readOnly: true,
              textAlignVertical: TextAlignVertical.center,
              style: tsPoppins(
                  size: 14, weight: FontWeight.w400, color: textDark80),
              decoration: InputFormDecoration.outLinedInputTextDecoration(
                borderSide: const BorderSide(color: textDark20, width: 1),
                filled: true,
                fillColor: white,
                contentPadding: const EdgeInsets.only(left: 20),
                suffixIcon: Padding(
                  padding:
                      const EdgeInsets.all(15), // add padding to adjust icon
                  child: SvgPicture.asset(
                    "assets/icons/ic_down_arrow.svg",
                    color: textDark40,
                  ),
                ),
                labelText: "Vehicle Model",
                labelStyle: tsPoppins(
                    size: 14, weight: FontWeight.w400, color: textColor02),
              )),
          const SizedBox(
            height: 10,
          ),
          TextFormField(
              controller: controller.yearController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Select year";
                } else {
                  return null;
                }
              },
              onTap: () {
                yearSelectionBottomSheet(
                  context: context,
                  yearList: controller.yearList,
                  selectedYear: controller.selectedYear,
                  isSingleSelection: true,
                  onYearSelected: (VehicleYear vehicleYear) {
                    controller.selectedYear.value = vehicleYear;
                    controller.yearController.text = vehicleYear.name!;
                  },
                );
              },
              readOnly: true,
              textAlignVertical: TextAlignVertical.center,
              style: tsPoppins(
                  size: 14, weight: FontWeight.w400, color: textDark80),
              decoration: InputFormDecoration.outLinedInputTextDecoration(
                contentPadding: const EdgeInsets.only(left: 20),
                filled: true,
                fillColor: white,
                suffixIcon: Padding(
                  padding:
                      const EdgeInsets.all(15), // add padding to adjust icon
                  child: SvgPicture.asset(
                    "assets/icons/ic_down_arrow.svg",
                    color: textDark40,
                  ),
                ),
                labelText: "Year",
                labelStyle: tsPoppins(
                    size: 14, weight: FontWeight.w400, color: textColor02),
              )),
          const SizedBox(
            height: 10,
          ),
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: white,
                border: Border.all(color: textDark20, width: 1)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(
                  height: 10,
                ),
                Text(
                  '    Select Color',
                  style: tsPoppins(size: 14, color: textDark40),
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 5,
                        crossAxisSpacing: 8,
                        mainAxisSpacing: 8,
                        childAspectRatio: 1 / 1.1,
                      ),
                      itemCount: controller.colorList.length,
                      itemBuilder: (con, i) {
                        return InkWell(
                          onTap: () {
                            controller.selectedColor.value =
                                controller.colorList[i];
                            controller.colorList.refresh();
                          },
                          child: Stack(
                            fit: StackFit.expand,
                            children: [
                              Container(
                                width: 15,
                                decoration: BoxDecoration(
                                    border: Border.all(color: textDark20),
                                    shape: BoxShape.circle,
                                    color: hexToColor(
                                        controller.colorList[i].code!)),
                              ),
                              if (controller.selectedColor.value.id ==
                                  controller.colorList[i].id)
                                Positioned(
                                    top: 0,
                                    right: 2,
                                    child: SvgPicture.asset(
                                        'assets/icons/ic_tick.svg'))
                            ],
                          ),
                        );
                      }),
                )
              ],
            ),
          ),
          SizedBox(
            height: Get.height * .4,
          )
        ],
      ),
    );
  }

  details2(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          VehicleTile(vehicle: controller.selectedVehicle.value),
          const SizedBox(
            height: 20,
          ),
          DottedBorder(
              radius: const Radius.circular(8),
              child: Container(
                color: white,
                child: Column(
                  children: [
                    const SizedBox(
                      height: 14,
                    ),
                    Text('Add Vehicle Photos',
                        style: tsPoppins(size: 14, color: textDark80)),
                    Text(
                        'In publishing and graphic design, Lorem ipsum placeholder text commonly. ',
                        textAlign: TextAlign.center,
                        style: tsPoppins(
                            weight: FontWeight.w400, color: textDark40)),
                    const SizedBox(
                      height: 10,
                    ),
                    SvgPicture.asset('assets/icons/ic_image_upload.svg'),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              )),
          const SizedBox(
            height: 27,
          ),
          Text(
            'Please fill in the number plate to find your car quickly.',
            style: tsPoppins(color: textColor09, weight: FontWeight.w400),
          ),
          const SizedBox(
            height: 10,
          ),
          TextFormField(
              controller: controller.plateCodeController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Enter Plate Code";
                } else {
                  return null;
                }
              },
              textAlignVertical: TextAlignVertical.center,
              style: tsPoppins(
                  size: 14, weight: FontWeight.w400, color: textDark80),
              decoration: InputFormDecoration.outLinedInputTextDecoration(
                contentPadding: const EdgeInsets.only(left: 20, right: 15),
                filled: true,
                fillColor: white,
                labelText: "Plate Code",
                labelStyle: tsPoppins(
                    size: 14, weight: FontWeight.w400, color: textColor02),
              )),
          const SizedBox(
            height: 10,
          ),
          TextFormField(
              controller: controller.plateNumberController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Enter Plate Number";
                } else {
                  return null;
                }
              },
              textAlignVertical: TextAlignVertical.center,
              style: tsPoppins(
                  size: 14, weight: FontWeight.w400, color: textDark80),
              decoration: InputFormDecoration.outLinedInputTextDecoration(
                contentPadding: const EdgeInsets.only(left: 20, right: 15),
                filled: true,
                fillColor: white,
                labelText: "Plate Number",
                labelStyle: tsPoppins(
                    size: 14, weight: FontWeight.w400, color: textColor02),
              )),
          const SizedBox(
            height: 10,
          ),
          TextFormField(
              controller: controller.plateNumberController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Enter City";
                } else {
                  return null;
                }
              },
              textAlignVertical: TextAlignVertical.center,
              style: tsPoppins(
                  size: 14, weight: FontWeight.w400, color: textDark80),
              decoration: InputFormDecoration.outLinedInputTextDecoration(
                contentPadding: const EdgeInsets.only(left: 20, right: 15),
                filled: true,
                fillColor: white,
                labelText: "Plate City",
                labelStyle: tsPoppins(
                    size: 14, weight: FontWeight.w400, color: textColor02),
              )),
          SizedBox(
            height: Get.height * .4,
          )
        ],
      ),
    );
  }
}
