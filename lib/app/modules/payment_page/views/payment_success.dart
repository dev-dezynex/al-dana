import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';

import '../../../data/data.dart';
import '../../../routes/app_pages.dart';
import '../controllers/payment_page_controller.dart';

class PaymentSuccessView extends GetView<PaymentPageController> {
  const PaymentSuccessView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        width: Get.width,
        child: Column(
          children: [
            const Spacer(
              flex: 1,
            ),
            SvgPicture.asset('assets/icons/ic_payment_success.svg'),
            const Spacer(
              flex: 1,
            ),
            Text('Payment Success',
                style: tsRubik(
                    color: bgColor25, weight: FontWeight.w600, size: 18)),
            const SizedBox(
              height: 5,
            ),
            Text('Sit back and relax.our superhero will\ncome to you',
                textAlign: TextAlign.center,
                style: tsRubik(color: textColor10.withOpacity(.5), size: 12)),
            const Spacer(
              flex: 5,
            ),
            SvgPicture.asset('assets/icons/ic_award.svg'),
            const Spacer(
              flex: 1,
            ),
            Text('Your order has been Scheduled',
                style: tsRubik(color: textColor10, size: 14)),
            const SizedBox(
              height: 5,
            ),
            Text(
                '${outputDateFormat2.format(inputDateFormat.parse(controller.booking.value.date!))}, ${controller.booking.value.slot}',
                textAlign: TextAlign.center,
                style: tsRubik(color: textDark40, weight: FontWeight.w400)),
            const Spacer(
              flex: 3,
            ),
            ElevatedButton(
                onPressed: () {
                  Get.offNamedUntil(Routes.HOME, (route) => false);
                  Get.toNamed(Routes.TRACK_PAGE,
                      arguments: controller.booking.value);
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: bgColor27,
                    minimumSize: Size(Get.width, 50),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6))),
                child: Text(
                  'Tack Order',
                  style: tsPoppins(
                      color: white, size: 14, weight: FontWeight.w400),
                )),
            const Spacer(
              flex: 2,
            ),
          ],
        ),
      )),
    );
  }
}
