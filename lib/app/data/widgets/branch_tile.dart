import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../data.dart';

class BranchTile extends StatefulWidget {
  const BranchTile({Key? key,required this.branch,this.onTap}) : super(key: key);
  final Branch branch;
final GestureTapCallback? onTap;
  @override
  State<BranchTile> createState() => _BranchTileState();
}

class _BranchTileState extends State<BranchTile> {
     var bgCardImage;
 
   @override
  void initState() {
    super.initState();
    bgCardImage = NetworkImage(widget.branch.image);
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width * .6,
      margin: const EdgeInsets.only(left: 15),
      decoration: BoxDecoration(
        image:   DecorationImage(
            image: bgCardImage,
            onError: (exception, stackTrace) {
              setState(() {
                bgCardImage = AssetImage('assets/images/img_branch_1.png');
              });
            },
          ),
      ),
      child: InkWell(
        onTap: widget.onTap,
        child: Stack(
          children: [
            Positioned(
                top: 15,
                left: 15,
                child: Container(
                  color: bgColor28,
                  padding: const EdgeInsets.all(3),
                  child: Row(
                    children: [
                      SvgPicture.asset('assets/icons/ic_star.svg', color: white),
                      Text('${widget.branch.rating}', style: tsPoppins(size: 10, color: white))
                    ],
                  ),
                )),
            Positioned(
                bottom: 16,
                left: 15,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.branch.name,
                      style: tsPoppins(
                          color: white, size: 13, weight: FontWeight.w600),
                    ),
                    Text(
                      widget.branch.location,
                      style:
                          tsPoppins(color: textDark10, weight: FontWeight.w400),
                    ),
                  ],
                )),
            Positioned(
                bottom: 16,
                right: 15,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.location_on_outlined,
                      color: textDark10,
                      size: 10,
                    ),
                    Text(
                      ' ${widget.branch.distance}',
                      style:
                          tsPoppins(color: textDark10, weight: FontWeight.w400),
                    ),
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
