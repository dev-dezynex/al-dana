import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../data.dart';

class BookingTile extends StatelessWidget {
  const BookingTile({
    Key? key,
    required this.booking,
    this.onTap,
    this.onChanged,
  }) : super(key: key);
  final Booking booking;
  final GestureTapCallback? onTap;
  final void Function(bool?)? onChanged;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        color: bgColor32,
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 5),
                  Text(
                    booking.packageList![0].title!,
                    style: tsPoppins(
                      weight: FontWeight.w600,
                      color: white,
                      size: 18,
                    ),
                  ),
                  Container(
                      height: 2,
                      width: 30,
                      decoration: BoxDecoration(
                          color: accent60,
                          borderRadius: BorderRadius.circular(100))),
                  const SizedBox(height: 8),
                  Text(
                    'Service Includes',
                    style: tsPoppins(
                      color: bgColor25,
                      size: 14,
                    ),
                  ),
                  const SizedBox(height: 5),
                  ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: booking.packageList![0].services!.length,
                      itemBuilder: (con, i) {
                        return Row(
                          children: [
                            const Icon(
                              Icons.arrow_right_rounded,
                              color: white,
                            ),
                            Text(
                              booking.packageList![0].services![i].title,
                              style: tsPoppins(
                                  color: white, weight: FontWeight.w400),
                            )
                          ],
                        );
                      }),
                  const SizedBox(height: 5),
                  Text(
                    'Add-Once',
                    style: tsPoppins(
                      color: bgColor25,
                      size: 14,
                    ),
                  ),
                  ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: booking.services!.length,
                      itemBuilder: (con, i) {
                        return Row(
                          children: [
                            const Icon(
                              Icons.arrow_right_rounded,
                              color: white,
                            ),
                            Text(
                              booking.services![i].title,
                              style: tsPoppins(
                                  color: white, weight: FontWeight.w400),
                            )
                          ],
                        );
                      }),
                  const SizedBox(height: 5),
                ],
              ),
            ),
            Positioned(
                top: 20,
                right: 10,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                        '${outputDateFormat2.format(outputDateFormat.parse(booking.date!))},\n ${booking.slot}',
                        textAlign: TextAlign.right,
                        style:
                            tsPoppins(color: white, weight: FontWeight.w400)),
                    Text('AED ${booking.price.toStringAsFixed(2)}',
                        textAlign: TextAlign.center,
                        style: tsRubik(color: bgColor27, size: 14)),
                  ],
                )),
            Positioned(
              bottom: 10,
              right: 10,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  SizedBox(
                    height: 100,
                    width: 150,
                    //padding: const EdgeInsets.only(top: 1.0, left: 5, right: 5),
                    child: Image.network(
                      booking.packageList![0].image!,
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) {
                        return Image.asset(
                          booking.packageList![0].image!,
                          fit: BoxFit.contain,
                          errorBuilder: (context, error, stackTrace) {
                            return Image.asset(
                              'assets/images/img_placeholder.png',
                              fit: BoxFit.contain,
                            );
                          },
                        );
                      },
                    ),
                  ),
                  ElevatedButton(
                      onPressed: onTap,
                      style: ElevatedButton.styleFrom(primary: bgColor27),
                      child: Text(
                        'Track >>',
                        style: tsPoppins(weight: FontWeight.w600, color: white),
                      )),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
