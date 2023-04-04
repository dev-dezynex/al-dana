import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../data/data.dart';
import '../controllers/address_map_controller.dart';

class AddressMapView extends GetView<AddressMapController> {
  AddressMapView({Key? key}) : super(key: key);
  final GlobalKey<FormState> formKeyAdd = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          fit: StackFit.expand,
          children: [
            Obx(
              () => (controller.isLoading.value)
                  ? Center(
                      child: Text(
                        'Please wait...',
                        style: tsPoppins(),
                      ),
                    )
                  : GoogleMap(
                      mapType: MapType.normal,
                      zoomControlsEnabled: false,
                      initialCameraPosition: controller.camPosition.value,
                      onMapCreated: (GoogleMapController gmController) {
                        controller.mapController.complete(gmController);
                      },
                      myLocationEnabled: true,
                      myLocationButtonEnabled: false,
                      markers: controller.markers,
                      onTap: (argument) {
                        print('ontapping**********');
                        controller.addCurrentLocMarker(argument);
                      },
                    ),
            ),
            Positioned(
              top: Get.height * .02,
              left: Get.width * .01,
              right: Get.width * .01,
              child: Container(
                color: Colors.transparent,
                margin: EdgeInsets.fromLTRB(
                    Get.width * .05, 0, Get.width * .05, 15),
                child: TextFormField(
                  autofocus: false,
                  onChanged: (value) {
                    controller.search(key: value);
                  },
                  style: tsPoppins(color: primary, size: 14),
                  decoration: InputFormDecoration.outLinedInputTextDecoration(
                      prefixIcon: const Icon(
                        Icons.search,
                        color: textDark40,
                      ),
                      radius: 100,
                      filled: true,
                      fillColor: white),
                ),
              ),
            ),
            Positioned(
                bottom: 10,
                left: 0,
                right: 0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    GestureDetector(
                      onTap: () {
                        controller.getCurrentLocation();
                      },
                      child: Container(
                          width: 40,
                          height: 40,
                          margin: const EdgeInsets.only(right: 15),
                          decoration: const BoxDecoration(
                              color: white, shape: BoxShape.circle),
                          child: const Icon(
                            Icons.my_location_outlined,
                            size: 18,
                          )),
                    ),
                    const SizedBox(height: 30),
                    Container(
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(15),
                              topRight: Radius.circular(15))),
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: Form(
                        key: formKeyAdd,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const SizedBox(
                              height: 45,
                            ),
                            TextFormField(
                              controller: controller.locationController,
                              textAlignVertical: TextAlignVertical.center,
                              keyboardType: TextInputType.text,
                              validator: (String? value) {
                                if (value == null || value.isEmpty) {
                                  return "Required location";
                                } else {
                                  return null;
                                }
                              },
                              style: tsPoppins(
                                  size: 14,
                                  weight: FontWeight.w400,
                                  color: textDark80),
                              decoration: InputFormDecoration
                                  .outLinedInputTextDecoration(
                                contentPadding:
                                    const EdgeInsets.only(left: 10, right: 10),
                                labelText: "Location",
                                labelStyle: tsPoppins(
                                    size: 14,
                                    weight: FontWeight.w400,
                                    color: textColor02),
                              ),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            TextFormField(
                              controller: controller.landMarkController,
                              textAlignVertical: TextAlignVertical.center,
                              keyboardType: TextInputType.text,
                              style: tsPoppins(
                                  size: 14,
                                  weight: FontWeight.w400,
                                  color: textDark80),
                              decoration: InputFormDecoration
                                  .outLinedInputTextDecoration(
                                contentPadding:
                                    const EdgeInsets.only(left: 10, right: 10),
                                labelText: "Landmark",
                                labelStyle: tsPoppins(
                                    size: 14,
                                    weight: FontWeight.w400,
                                    color: textColor02),
                              ),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Obx(
                              () => Row(
                                children: [
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Radio<String>(
                                        value: 'home',
                                        groupValue: controller
                                            .selectedAddress.value.addressType
                                            .toLowerCase(),
                                        onChanged: (String? value) {
                                          controller.selectedAddress.value
                                                  .addressType =
                                              value!;
                                          controller.selectedAddress.refresh();
                                        },
                                      ),
                                      Text(
                                        'Home',
                                        style: tsPoppins(),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Radio<String>(
                                        value: 'office',
                                        groupValue: controller
                                            .selectedAddress.value.addressType
                                            .toLowerCase(),
                                        onChanged: (String? value) {
                                          controller.selectedAddress.value
                                                  .addressType =
                                              value!;
                                          controller.selectedAddress.refresh();
                                        },
                                      ),
                                      Text(
                                        'Office',
                                        style: tsPoppins(),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Radio<String>(
                                        value: 'other',
                                        groupValue: controller
                                            .selectedAddress.value.addressType
                                            .toLowerCase(),
                                        onChanged: (String? value) {
                                          controller.selectedAddress.value
                                                  .addressType =
                                              value!;
                                          controller.selectedAddress.refresh();
                                        },
                                      ),
                                      Text(
                                        'Other',
                                        style: tsPoppins(),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            if(controller.isLoading.value)
                            Center(child: CircularProgressIndicator()),
                            if(!controller.isLoading.value && controller.isUpdate.value)
                             Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                ElevatedButton(
                                    onPressed: () {
                                      myAlertDialog(
                                          title: 'Confirm',
                                          message:
                                              'Do you want to delete this branch ?',
                                          onCancel: () {
                                            Get.back();
                                          },
                                          onSubmit: () {
                                            controller.deleteAddress();
                                          });
                                    },
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: white,
                                        minimumSize: Size(Get.width * .4, 50),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            side: const BorderSide(
                                                color: primary, width: 2))),
                                    child: Text('Delete',
                                        style: tsPoppins(
                                            color: primary,
                                            weight: FontWeight.w600,
                                            size: 15))),
                                ElevatedButton(
                                    onPressed: () {
                                      if (formKeyAdd.currentState!.validate()) {
                                        controller.updateAddress();
                                      }
                                    },
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: primary,
                                        minimumSize: Size(Get.width * .4, 50),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10))),
                                    child: Text('Update',
                                        style: tsPoppins(
                                            color: white,
                                            weight: FontWeight.w600,
                                            size: 15))),
                              ],
                            ),
                        
                            if(!controller.isLoading.value && !controller.isUpdate.value)
                            ElevatedButton(
                              onPressed: () {
                                if (formKeyAdd.currentState!.validate()) {
                                  controller.onConfirmPressed();
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: bgColor27,
                                  minimumSize: Size(Get.width, 50),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8))),
                              child: Text(
                                'Confirm Address',
                                style: tsPoppins(
                                    color: white,
                                    size: 16,
                                    weight: FontWeight.w600),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
