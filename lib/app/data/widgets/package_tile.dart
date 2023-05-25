import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../data.dart';

class PackageTile extends StatelessWidget {
  const PackageTile({
    Key? key,
    required this.package,
    this.onTap,
    this.onEdit,
    this.onChanged,
    this.isSelected = false,
    this.isManage = false,
  }) : super(key: key);
  final PackageModel package;
  final GestureTapCallback? onTap, onEdit;
  final bool isSelected, isManage;
  final void Function(bool?)? onChanged;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        color: hexToColor(package.bgCardColor!),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.bottomRight,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: isManage
                    ? MainAxisAlignment.end
                    : MainAxisAlignment.spaceBetween,
                children: [
                  if (!isManage)
                    Radio(
                      fillColor:
                          MaterialStateColor.resolveWith((states) => white),
                      value: isSelected,
                      groupValue: true,
                      onChanged: onChanged,
                    ),
                  Container(
                    height: Get.width * .3,
                    width: Get.width * .4,
                    alignment: Alignment.bottomCenter,
                    padding:
                        const EdgeInsets.only(top: 18.0, left: 5, right: 5),
                    child: Image.network(
                      '$domainName${package.image!}',
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Image.asset(
                          package.image!,
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
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 5),
                  Text(
                    package.title!,
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
                      itemCount: package.services!.length,
                      itemBuilder: (con, i) {
                        return Row(
                          children: [
                            const Icon(
                              Icons.arrow_right_rounded,
                              color: white,
                            ),
                            Text(
                              package.services?[i].title ?? '',
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
