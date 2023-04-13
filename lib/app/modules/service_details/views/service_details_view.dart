import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../data/data.dart';
import '../controllers/service_details_controller.dart';

class ServiceDetailsView extends GetView<ServiceDetailsController> {
  const ServiceDetailsView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor1,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: true,
        leading: const GoBack(),
        title: Text(
          controller.selectedCategory.value.title,
          style:
              tsPoppins(size: 18, weight: FontWeight.w600, color: textDark80),
        ),
      ),
      bottomSheet: Container(
        decoration: const BoxDecoration(
            color: white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10), topRight: Radius.circular(10))),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(
              height: 10,
            ),
            Container(
              height: 5,
              width: 100,
              decoration: BoxDecoration(
                  color: textDark20, borderRadius: BorderRadius.circular(100)),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Branch',
                          style: tsPoppins(
                              size: 10,
                              weight: FontWeight.w400,
                              color: textDark40)),
                      Text(controller.booking.value.branch!.name,
                          style: tsPoppins(color: textDark40)),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Mode',
                          style: tsPoppins(
                              size: 10,
                              weight: FontWeight.w400,
                              color: textDark40)),
                      Text('${controller.booking.value.mode!.title}',
                          style: tsPoppins(color: textDark40)),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Obx(
                            () => Text(
                                controller.booking.value.price
                                    .toStringAsFixed(2),
                                style: tsPoppins(
                                    size: 18,
                                    weight: FontWeight.w600,
                                    color: primary)),
                          ),
                          Text('AED',
                              style: tsPoppins(
                                  size: 16,
                                  weight: FontWeight.w400,
                                  color: textDark40)),
                        ],
                      ),
                      Text('Incl. 5% VAT',
                          style: tsPoppins(
                              weight: FontWeight.w400, color: textColor08)),
                    ],
                  ),
                  ElevatedButton(
                      onPressed: () {
                        controller.onNextClick(context);
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: primary,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6))),
                      child: Text(
                        '    Next   ',
                        style: tsPoppins(
                            color: white, size: 14, weight: FontWeight.w400),
                      )),
                ],
              ),
            )
          ],
        ),
      ),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // SizedBox(
                  //   height: Get.height * .1,
                  //   child: ListView.builder(
                  //       shrinkWrap: true,
                  //       scrollDirection: Axis.horizontal,
                  //       padding: const EdgeInsets.symmetric(
                  //           horizontal: 10, vertical: 2),
                  //       itemCount: 2,
                  //       itemBuilder: (con, i) {
                  //         return VehicleTile(
                  //             vehicle: Vehicle(
                  //                 image: 'assets/images/img_vehicle_1.png',
                  //                 brand: Brand(
                  //                     id: "string",
                  //                     name: "Abarth",
                  //                     image: "assets/images/img_brand_1.png"),
                  //                 variant: Variant(id: '1', name: 'Type 1'),
                  //                 year: VehicleYear(id: '1', name: '2016'),
                  //                 colour: VehicleColor(
                  //                     id: "8", name: "Blue", code: "#3C8AFF")));
                  //       }),
                  // ),

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child:
                        VehicleTile(vehicle: controller.booking.value.vehicle!),
                  ),
                  if (controller.booking.value.packageList!.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Obx(() => PackageTile(
                            package: controller.booking.value.packageList![0],
                            isSelected: true,
                          )),
                    ),
                  if (controller.booking.value.services!.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Obx(() => ServiceTile(
                            service: controller.booking.value.services![0],
                            isSelected: true,
                          )),
                    ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Add Extra Services',
                            style: tsPoppins(
                                color: textDark80, weight: FontWeight.w600)),
                        Container(
                          height: 2,
                          width: 20,
                          decoration: BoxDecoration(
                              color: accent60,
                              borderRadius: BorderRadius.circular(100)),
                        )
                      ],
                    ),
                  ),
                  Obx(
                    () => GridView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        physics: const NeverScrollableScrollPhysics(),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 2),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: Get.width ~/ 166,
                          crossAxisSpacing: 8,
                          mainAxisSpacing: 8,
                          childAspectRatio: 1 / 1,
                        ),
                        itemCount: controller
                            .extraServiceResult.value.serviceList.length,
                        itemBuilder: (con, i) {
                          return ServiceTile2(
                            onTap: () {
                              controller.addExtraService(controller
                                  .extraServiceResult.value.serviceList[i]);
                            },
                            service: controller
                                .extraServiceResult.value.serviceList[i],
                            isSelected: (controller.booking.value.services!
                                .contains(controller
                                    .extraServiceResult.value.serviceList[i])),
                            onChanged: (bool? c) {
                              controller.addExtraService(controller
                                  .extraServiceResult.value.serviceList[i]);
                            },
                          );
                        }),
                  ),
                  SizedBox(height: Get.height * .2),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
