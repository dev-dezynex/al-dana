import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../../../data/data.dart';
import '../controllers/subscription_page_controller.dart';

class SubscriptionPageView extends GetView<SubscriptionPageController> {
  const SubscriptionPageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: controller.tabs.length,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'Subscribe',
            style: tsPoppins(color: primary, size: 17, weight: FontWeight.w600),
          ),
          leading: const GoBack(),
        ),
        body: Stack(
          fit: StackFit.expand,
          children: [
            SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 15.0, right: 15.0, top: 20.0, bottom: 14.0),
                      child: Row(
                        children: [
                          SvgPicture.asset('assets/images/ic_date_range.svg'),
                          const SizedBox(
                            width: 9.0,
                          ),
                          Text(
                            'Select your date range',
                            style: tsPoppins(color: textDark80),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 15.0, right: 15.0, top: 14.0, bottom: 50.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Start Date',
                                style: tsPoppins(color: textDark40),
                              ),
                              SizedBox(
                                width: Get.width * .4,
                                child: Obx(() {
                                  return TextFormField(
                                      readOnly: true,
                                      onTap: () async {
                                        final DateTime? picked =
                                            await showDatePicker(
                                                context: context,
                                                initialDate:
                                                    controller.startDate.value,
                                                firstDate: DateTime.now(),
                                                lastDate: DateTime(
                                                    DateTime.now().year + 10));
                                        if (picked != null &&
                                            picked !=
                                                controller.startDate.value &&
                                            picked.isBefore(
                                                controller.endDate.value)) {
                                          controller.startDate.value = picked;
                                          controller.setDateRange();
                                          controller.setDateList();
                                        }
                                      },
                                      decoration: InputFormDecoration
                                          .outLinedInputTextDecoration(
                                        prefixIcon: SvgPicture.asset(
                                            'assets/images/ic_date_range.svg'),
                                        hintText: outputDateFormat
                                            .format(controller.startDate.value),
                                        hintStyle: tsPoppins(color: textDark80),
                                      ));
                                }),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'End Date',
                                style: tsPoppins(color: textDark40),
                              ),
                              SizedBox(
                                width: Get.width * .4,
                                child: Obx(() => TextFormField(
                                    onTap: () async {
                                      final DateTime? picked =
                                          await showDatePicker(
                                              context: context,
                                              initialDate:
                                                  controller.endDate.value,
                                              firstDate: DateTime.now(),
                                              lastDate: DateTime(
                                                  DateTime.now().year + 10));
                                      if (picked != null &&
                                          picked != controller.endDate.value &&
                                          picked.isAfter(
                                              controller.startDate.value)) {
                                        controller.endDate.value = picked;
                                        controller.setDateRange();
                                        controller.setDateList();
                                      }
                                    },
                                    readOnly: true,
                                    decoration: InputFormDecoration
                                        .outLinedInputTextDecoration(
                                      prefixIcon: SvgPicture.asset(
                                          'assets/images/ic_date_range.svg'),
                                      hintText: outputDateFormat
                                          .format(controller.endDate.value),
                                      hintStyle: tsPoppins(color: textDark80),
                                    ))),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 15.0, bottom: 17.0),
                      child: Row(
                        children: [
                          SvgPicture.asset('assets/images/ic_date_range.svg'),
                          const SizedBox(
                            width: 9.0,
                          ),
                          Text(
                            'Select your period',
                            style: tsPoppins(color: textDark80),
                          ),
                        ],
                      ),
                    ),
                    Obx(() => DecoratedTabBar(
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: textDark40.withOpacity(.5),
                                width: 1.0,
                              ),
                            ),
                          ),
                          tabBar: TabBar(
                              labelStyle: tsPoppins(
                                  color: textDark80,
                                  size: 14,
                                  weight: FontWeight.w400),
                              unselectedLabelStyle: tsPoppins(
                                  color: textDark80,
                                  size: 14,
                                  weight: FontWeight.w400),
                              labelColor: primary,
                              unselectedLabelColor: textDark40,
                              indicatorColor: primary,
                              indicatorSize: TabBarIndicatorSize.tab,
                              isScrollable: false,
                              onTap: (index) {
                                controller.selectedTab.value = index;
                              },
                              tabs: List.generate(
                                  controller.tabs.length,
                                  (index) => Tab(
                                        text: controller.tabs[index],
                                      ))),
                        )),
                    SizedBox(
                      height: Get.height * .4,
                      child: TabBarView(
                        children: [
                          Obx(
                            () => SfDateRangePicker(
                              controller: controller.dateRangeController1,
                              view: DateRangePickerView.month,
                              headerStyle: const DateRangePickerHeaderStyle(
                                  textAlign: TextAlign.center),
                              initialSelectedRange:
                                  controller.pickDateRange.value,
                              selectionMode: DateRangePickerSelectionMode.range,
                              startRangeSelectionColor: primary,
                              endRangeSelectionColor: primary,
                              selectionColor: primary,
                              onSelectionChanged: (args) {
                                if (args.value is PickerDateRange) {
                                  controller.startDate.value =
                                      args.value.startDate;
                                  controller.endDate.value = args.value.endDate;
                                }
                              },
                            ),
                          ),
                          Obx(
                            () => SfDateRangePicker(
                              controller: controller.dateRangeController2,
                              view: DateRangePickerView.month,
                              headerStyle: const DateRangePickerHeaderStyle(
                                  textAlign: TextAlign.center),
                              initialSelectedRange:
                                  controller.pickDateRange.value,
                              initialSelectedDates:
                                  controller.alternateDateList,
                              monthViewSettings:
                                  const DateRangePickerMonthViewSettings(
                                      firstDayOfWeek: 1),
                              selectionMode:
                                  DateRangePickerSelectionMode.multiple,
                              startRangeSelectionColor: primary,
                              endRangeSelectionColor: primary,
                              selectionColor: primary,
                              
                              onSelectionChanged: (args) {
                                if (args.value is PickerDateRange) {
                                  controller.startDate.value =
                                      args.value.startDate;
                                  controller.endDate.value = args.value.endDate;
                                }
                              },
                            ),
                          ),
                          Obx(
                            () => SfDateRangePicker(
                              controller: controller.dateRangeController3,
                              view: DateRangePickerView.month,
                              headerStyle: const DateRangePickerHeaderStyle(
                                  textAlign: TextAlign.center),
                              initialSelectedRange:
                                  controller.pickDateRange.value,
                              initialSelectedDates: controller.multiDateList,
                              monthViewSettings:
                                  const DateRangePickerMonthViewSettings(
                                      firstDayOfWeek: 1),
                              selectionMode:
                                  DateRangePickerSelectionMode.multiple,
                              startRangeSelectionColor: primary,
                              endRangeSelectionColor: primary,
                              selectionColor: primary,
                              onSelectionChanged: (args) {
                                if (args.value is List<DateTime>) {
                                  controller.multiDateList.value =
                                      List.from(args.value);
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: Get.height * .2,
                    )
                  ],
                ),
              ),
            ),
            Positioned(
                bottom: 0.0,
                right: 0.0,
                left: 0.0,
                child: InkWell(
                  onTap: () {},
                  child: Container(
                    width: Get.width,
                    height: 50.0,
                    alignment: Alignment.center,
                    color: primary,
                    child: Text(
                      'subscribe',
                      style: tsPoppins(
                          weight: FontWeight.w700, size: 18.0, color: white),
                    ),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}