import 'package:al_dana/app/routes/app_pages.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../data/data.dart';
import '../controllers/booking_page_controller.dart';

class BookingPageView extends GetView<BookingPageController> {
  const BookingPageView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor1,
      appBar: AppBar(
        backgroundColor: primary,
        centerTitle: true,
        leading: const GoBack(),
        title: Text(
          'My Booking',
          style: tsPoppins(size: 18, weight: FontWeight.w600, color: white),
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
                  Obx(
                    () => controller.isLoading.value
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 2),
                            itemCount: controller
                                .bookingResult.value.bookingList!.length,
                            itemBuilder: (con, i) {
                              return BookingTile(
                                onTap: () {
                                  Get.toNamed(Routes.TRACK_PAGE,
                                      arguments: controller
                                          .bookingResult.value.bookingList![i]);
                                },
                                booking: controller
                                    .bookingResult.value.bookingList![i],
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
