import 'package:al_dana/app/data/data.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../controllers/branch_controller.dart';

class BranchView extends GetView<BranchController> {
  const BranchView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const GoBack(),
        title: Text(
          'Branch',
          style:
              tsPoppins(color: textDark80, size: 18, weight: FontWeight.w600),
        ),
        centerTitle: true,
      ),
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
                      initialCameraPosition: controller.camPosition.value,
                      onMapCreated: (GoogleMapController gmController) {
                        controller.mapController.complete(gmController);
                      },
                      markers: controller.markers,
                    ),
            ),
            Positioned(
                bottom: 100,
                left: 0,
                right: 0,
                child: SizedBox(
                  height: Get.height * .2,
                  child: Obx(
                    () => controller.isLoading.value
                        ? const SizedBox()
                        : ListView.builder(
                            scrollDirection: Axis.horizontal,
                            padding: const EdgeInsets.symmetric(horizontal: 30),
                            itemCount: controller
                                .branchResult.value.branchList!.length,
                            itemBuilder: (con, i) {
                              return SizedBox(
                                width: Get.width * .8,
                                child: BranchTile(
                                  onTap: () {
                                    controller.selectBranch(controller
                                        .branchResult.value.branchList![i]);
                                  },
                                  branch: controller
                                      .branchResult.value.branchList![i],
                                ),
                              );
                            }),
                  ),
                )),
            Positioned(
                bottom: 10,
                left: 20,
                right: 20,
                child: Obx(
                  () => controller.isLoading.value
                      ? SizedBox()
                      : ElevatedButton(
                          onPressed: () {
                            controller.onConfirmPressed();
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: bgColor27,
                              minimumSize: Size(Get.width, 50),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8))),
                          child: Text(
                            'Confirm',
                            style: tsPoppins(
                                color: white,
                                size: 16,
                                weight: FontWeight.w600),
                          ),
                        ),
                ))
          ],
        ),
      ),
    );
  }
}
