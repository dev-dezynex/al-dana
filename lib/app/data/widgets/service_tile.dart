import 'package:al_dana/app/data/data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ServiceTile extends StatelessWidget {
  const ServiceTile({
    Key? key,
    required this.service,
    this.isSelected = false,
    this.isManage = false,
    this.onChanged,
    this.onTap,
    this.onEdit,
  }) : super(key: key);
  final Service service;
  final bool isSelected, isManage;
  final void Function(bool?)? onChanged;
  final void Function()? onTap, onEdit;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: BorderSide(
              color: isSelected ? greenAppTheme : tileColor, width: 3),
        ),
        // color: hexToColor('#09DDBD'),
        color: tileColor,
        child: Stack(
          children: [
            Container(
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    constraints: BoxConstraints(
                        maxHeight: Get.width * .2, maxWidth: Get.width * .35),
                    padding:
                        const EdgeInsets.only(top: 18.0, left: 5, right: 5),
                    alignment: Alignment.center,
                    child: Image.network(
                      '$domainName${service.image}',
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Image.asset(
                          service.image ?? '',
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Image.asset(
                              'assets/images/img_placeholder.png',
                              fit: BoxFit.cover,
                            );
                          },
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 5),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      service.title ?? '',
                      style: tsPoppins(
                        weight: FontWeight.w600,
                        color: bgColor25,
                        size: 12,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          '${service.price}',
                          style: tsPoppins(
                            weight: FontWeight.w600,
                            color: bgColor25,
                            size: 12,
                          ),
                        ),
                        const SizedBox(width: 3),
                        Text(
                          'AED',
                          style: tsPoppins(
                            weight: FontWeight.w500,
                            color: greenAppTheme,
                            size: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // if (!isManage)
            //   Positioned(
            //       top: 0,
            //       right: 0,
            //       child: Radio(
            //         fillColor: MaterialStateColor.resolveWith(
            //             (states) => greenAppTheme),
            //         value: isSelected,
            //         groupValue: true,
            //         onChanged: onChanged,
            //       )),
            if (isManage)
              Positioned(
                top: 0,
                right: 0,
                child: IconButton(
                  onPressed: onEdit,
                  icon: const Icon(
                    Icons.edit,
                    color: white,
                    size: 15,
                  ),
                ),
              )
          ],
        ),
      ),
    );
  }
}

class ServiceTile2 extends StatelessWidget {
  const ServiceTile2(
      {Key? key,
      required this.service,
      required this.isSelected,
      this.onChanged,
      this.onTap})
      : super(key: key);
  final Service service;
  final bool isSelected;
  final void Function(bool?)? onChanged;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: BorderSide(
              color: isSelected ? greenAppTheme : tileColor, width: 3),
        ),
        color: white,
        child: Stack(
          fit: StackFit.expand,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Flexible(
                  child: Container(
                    padding:
                        const EdgeInsets.only(top: 18.0, left: 5, right: 5),
                    child: Image.network(
                      '$domainName${service.image}',
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) {
                        return Image.asset(
                          service.image ?? '',
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
                ),
                const SizedBox(height: 5),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    service.title ?? '',
                    style: tsPoppins(
                      weight: FontWeight.w600,
                      color: textDark80,
                      size: 14,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    service.desc ?? '',
                    textAlign: TextAlign.center,
                    style: tsPoppins(
                      weight: FontWeight.w500,
                      color: textDark40,
                      size: 10,
                    ),
                  ),
                ),
                const SizedBox(height: 5),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        service.price.toString(),
                        textAlign: TextAlign.center,
                        style: tsPoppins(
                          weight: FontWeight.w600,
                          color: black,
                          size: 14,
                        ),
                      ),
                      const SizedBox(
                        width: 3,
                      ),
                      Text(
                        'AED',
                        textAlign: TextAlign.center,
                        style: tsPoppins(
                          weight: FontWeight.w500,
                          color: greenAppTheme,
                          size: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            // Positioned(
            //     top: 0,
            //     right: 0,
            //     child: Radio(
            //       fillColor:
            //           MaterialStateColor.resolveWith((states) => tileColor),
            //       value: isSelected,
            //       groupValue: true,
            //       onChanged: onChanged,
            //     ))
          ],
        ),
      ),
    );
  }
}
