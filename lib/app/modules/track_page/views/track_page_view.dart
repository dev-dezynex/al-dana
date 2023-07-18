import 'package:al_dana/app/data/widgets/tracker.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../data/data.dart';
import '../controllers/track_page_controller.dart';

class TrackPageView extends GetView<TrackPageController> {
  TrackPageView({Key? key}) : super(key: key);
  // List<TextDto> orderList = [
  //   TextDto("Your order has been placed", "Fri, 25th Mar '22 - 10:47pm"),
  //   TextDto("Seller ha processed your order", "Sun, 27th Mar '22 - 10:19am"),
  //   TextDto("Your item has been picked up by courier partner.",
  //       "Tue, 29th Mar '22 - 5:00pm"),
  // ];

  // List<TextDto> shippedList = [
  //   TextDto("Your order has been shipped", "Tue, 29th Mar '22 - 5:04pm"),
  //   TextDto("Your item has been received in the nearest hub to you.", null),
  // ];

  // List<TextDto> outOfDeliveryList = [
  //   TextDto("Your order is out for delivery", "Thu, 31th Mar '22 - 2:27pm"),
  // ];

  // List<TextDto> deliveredList = [
  //   TextDto("Your order has been delivered", "Thu, 31th Mar '22 - 3:58pm"),
  // ];
  @override
  final controller = Get.put(TrackPageController());
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: bgColor1,
        appBar: AppBar(
          backgroundColor: primary,
          centerTitle: true,
          leading: const GoBack(),
          title: Obx(
            () => Text(
              'Tracking ${controller.booking.value.id}',
              style: tsPoppins(size: 18, weight: FontWeight.w600, color: white),
            ),
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
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: VehicleTile(
                        vehicle: controller.booking.value.vehicle ?? Vehicle(),
                      ),
                    ),
                    Container(
                      // margin: const EdgeInsets.symmetric(
                      //     horizontal: 20, vertical: 10),
                      decoration: const BoxDecoration(color: bgColor36),
                      child: TabBar(
                        unselectedLabelColor: bgColor36,
                        indicator: const BoxDecoration(color: greenAppTheme),
                        indicatorColor: bgColor36,
                        padding: EdgeInsets.zero,
                        onTap: (value) {
                          controller.tabIndex.value = value;
                        },
                        tabs: [
                          Tab(
                            child: Obx(
                              () => Text(
                                'Service Tracking',
                                maxLines: 1,
                                style: tsPoppins(
                                    color: controller.tabIndex.value == 0
                                        ? white
                                        : textDark80,
                                    weight: FontWeight.w400),
                              ),
                            ),
                          ),
                          Tab(
                            child: Obx(
                              () => Text(
                                'Vehicle Photos',
                                maxLines: 1,
                                style: tsPoppins(
                                    color: controller.tabIndex.value == 1
                                        ? white
                                        : textDark80,
                                    weight: FontWeight.w400),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Obx(
                      () {
                        switch (controller.tabIndex.value) {
                          case 1:
                            return imagesView();
                          default:
                            return trackView();
                        }
                      },
                    ),
                    SizedBox(height: Get.height * .2),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget trackView() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Obx(
        () => TrackerTile(
          booking: controller.booking.value,
        ),
      ),
    );
  }

  Widget imagesView() {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(
              color: white, borderRadius: BorderRadius.circular(10)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Before Service',
                style: tsPoppins(
                  color: textDark80,
                ),
              ),
              Container(
                  height: 2,
                  width: 30,
                  decoration: BoxDecoration(
                      color: bgColor27,
                      borderRadius: BorderRadius.circular(100))),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                height: Get.height * .42,
                child: Swiper(
                  itemWidth: Get.width,
                  containerWidth: Get.width,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      margin: const EdgeInsets.only(bottom: 15.0),
                      child: Column(
                        children: [
                          Card(
                            color: Colors.transparent,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0)),
                            elevation: 0.0,
                            child: Image.asset(
                                'assets/images/img_vehicle_6.png',
                                fit: BoxFit.contain),
                          ),
                          Text(
                            'Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
                            style: tsPoppins(
                              color: textDark40,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                  onTap: (index) {
                    //Constants().showMessageInScaffold(context, banners[index]);
                  },
                  onIndexChanged: (index) {
                    controller.imageBeforeIndex.value = index;
                  },
                  itemCount: 3,
                  pagination: SwiperCustomPagination(
                    builder: (context, config) {
                      return Container(
                          alignment: Alignment.bottomCenter,
                          child: Obx(() => LinearIndicator(
                                index: controller.imageBeforeIndex.value,
                                length: 3,
                                activeColor: bgColor4,
                                inactiveColor: textDark20,
                              )));
                    },
                  ),
                  autoplay: false,
                  autoplayDelay: 4000,
                  duration: 800,
                  viewportFraction: 1,
                  scale: 1.0,
                ),
              ),
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(
              color: white, borderRadius: BorderRadius.circular(10)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'After Service',
                style: tsPoppins(
                  color: textDark80,
                ),
              ),
              Container(
                  height: 2,
                  width: 30,
                  decoration: BoxDecoration(
                      color: bgColor27,
                      borderRadius: BorderRadius.circular(100))),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                height: Get.height * .42,
                child: Swiper(
                  itemWidth: Get.width,
                  containerWidth: Get.width,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      margin: const EdgeInsets.only(bottom: 15.0),
                      child: Column(
                        children: [
                          Card(
                            color: Colors.transparent,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0)),
                            elevation: 0.0,
                            child: Image.asset(
                                'assets/images/img_vehicle_6.png',
                                fit: BoxFit.contain),
                          ),
                          Text(
                            'Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
                            style: tsPoppins(
                              color: textDark40,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                  onTap: (index) {
                    //Constants().showMessageInScaffold(context, banners[index]);
                  },
                  onIndexChanged: (index) {
                    controller.imageAfterIndex.value = index;
                  },
                  itemCount: 3,
                  pagination: SwiperCustomPagination(
                    builder: (context, config) {
                      return Container(
                          alignment: Alignment.bottomCenter,
                          child: Obx(() => LinearIndicator(
                                index: controller.imageAfterIndex.value,
                                length: 3,
                                activeColor: bgColor4,
                                inactiveColor: textDark20,
                              )));
                    },
                  ),
                  autoplay: false,
                  autoplayDelay: 4000,
                  duration: 800,
                  viewportFraction: 1,
                  scale: 1.0,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
