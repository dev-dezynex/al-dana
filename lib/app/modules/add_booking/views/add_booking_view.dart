import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../data/data.dart';
import '../../../routes/app_pages.dart';
import '../controllers/add_booking_controller.dart';

class AddBookingView extends GetView<AddBookingController> {
  const AddBookingView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor1,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: true,
        leading: const GoBack(),
        title: Text(
          'Shedule Order',
          style:
              tsPoppins(size: 18, weight: FontWeight.w600, color: textDark80),
        ),
        bottom: PreferredSize(
          preferredSize: Size(Get.width, 40),
          child: InkWell(
            onTap: () {
              controller.onNextClick(Routes.SUBSCRIPTION_PAGE);
            },
            child: Container(
              width: Get.width,
              height: 35,
              alignment: Alignment.center,
              color: Colors.yellow,
              child: Text(
                'Subscribe now save upto 50% ->',
                style: tsPoppins(size: 15),
              ),
            ),
          ),
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
                      Text(controller.booking.value.mode!.title,
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
                        controller.onNextClick(Routes.PAYMENT_PAGE);
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
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextFormField(
                            controller: controller.dateController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Select date";
                              } else {
                                return null;
                              }
                            },
                            onTap: () {
                              controller.chooseDate();
                            },
                            readOnly: true,
                            textAlignVertical: TextAlignVertical.center,
                            style: tsPoppins(
                                size: 14,
                                weight: FontWeight.w400,
                                color: textDark80),
                            decoration:
                                InputFormDecoration.outLinedInputTextDecoration(
                              borderSide:
                                  const BorderSide(color: textDark20, width: 1),
                              filled: true,
                              fillColor: white,
                              contentPadding: const EdgeInsets.only(left: 20),
                              suffixIcon: const Padding(
                                  padding: EdgeInsets.all(
                                      15), // add padding to adjust icon
                                  child: Icon(
                                    Icons.calendar_month,
                                    color: textDark40,
                                  )),
                              labelText: "Select Date",
                              labelStyle: tsPoppins(
                                  size: 14,
                                  weight: FontWeight.w400,
                                  color: textColor02),
                            )),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Available slot',
                          style: tsPoppins(
                              weight: FontWeight.w600, color: textDark40),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 40,
                    child: Obx(
                      () => (controller.isLoading.value)
                          ? const Center(child: CircularProgressIndicator())
                          : (controller.timeSlotResult.value.data?.timeSlotId ==
                                      null &&
                                  controller.timeSlotResult.value.data
                                          ?.timeSlotId ==
                                      [])
                              ? Center(
                                  child: Text(
                                    'No timeslots available',
                                    style: tsPoppins(),
                                  ),
                                )
                              : ListView.builder(
                                  shrinkWrap: true,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  scrollDirection: Axis.horizontal,
                                  itemCount: controller.timeSlotResult.value
                                      .data?.timeSlotId?.length,
                                  itemBuilder: (con, i) {
                                    return Container(
                                      margin: const EdgeInsets.only(right: 14),
                                      child: InkWell(
                                        onTap: () {
                                          print('time slot at 0');
                                          print(controller.timeSlotResult.value
                                              .data?.timeSlotId?[0].sId);
                                          controller.selectedTimeSlot =
                                              controller.timeSlotResult.value
                                                      .data?.timeSlotId?[i] ??
                                                  TimeSlotId();
                                          controller.booking.value.slot =
                                              controller.timeSlotResult.value
                                                  .data?.timeSlotId?[i].sId;

                                          controller.timeSlotResult.refresh();
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 20),
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                                color: controller
                                                            .selectedTimeSlot
                                                            .sId ==
                                                        controller
                                                            .timeSlotResult
                                                            .value
                                                            .data
                                                            ?.timeSlotId?[i]
                                                            .sId
                                                    ? bgColor27
                                                    : Colors.transparent),
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            color: white,
                                          ),
                                          child: Text(
                                            '${controller.timeSlotResult.value.data?.timeSlotId?[i].startTime} - ${controller.timeSlotResult.value.data?.timeSlotId?[i].endTime}',
                                            style: tsInter(
                                                size: 13, color: textDark80),
                                          ),
                                        ),
                                      ),
                                    );
                                  }),
                    ),
                  ),
                  const Divider(
                    color: textDark20,
                    thickness: 1,
                    height: 30,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Overview',
                            style: tsPoppins(
                                color: textDark80, weight: FontWeight.w600)),
                        Container(
                          height: 2,
                          width: 20,
                          decoration: BoxDecoration(
                              color: accent60,
                              borderRadius: BorderRadius.circular(100)),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        AddressTile(
                          address: controller.booking.value.address!,
                          distance: calculateDistance(
                              controller.booking.value.branch!.latitude,
                              controller.booking.value.branch!.longitude,
                              controller.booking.value.address!.latitude,
                              controller.booking.value.address!.longitude),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        if (controller.booking.value.packageList!.isNotEmpty)
                          Obx(() => PackageTile(
                                package:
                                    controller.booking.value.packageList![0],
                                isSelected: true,
                              )),
                        const SizedBox(
                          height: 13,
                        ),
                        Text('Services',
                            style: tsPoppins(
                                color: textDark80, weight: FontWeight.w600)),
                        Container(
                          height: 2,
                          width: 20,
                          decoration: BoxDecoration(
                              color: accent60,
                              borderRadius: BorderRadius.circular(100)),
                        ),
                        Obx(
                          () => GridView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              physics: const NeverScrollableScrollPhysics(),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 0, vertical: 10),
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: Get.width ~/ 166,
                                crossAxisSpacing: 8,
                                mainAxisSpacing: 8,
                                childAspectRatio: 1 / 1,
                              ),
                              itemCount:
                                  controller.booking.value.services!.length,
                              itemBuilder: (con, i) {
                                return ServiceTile2(
                                  service:
                                      controller.booking.value.services![i],
                                  isSelected: true,
                                );
                              }),
                        ),
                      ],
                    ),
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
