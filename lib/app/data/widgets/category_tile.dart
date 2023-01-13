import 'package:al_dana/app/data/data.dart';
import 'package:al_dana/app/data/models/service_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoryTile extends StatelessWidget {
  const CategoryTile(
      {Key? key, required this.category, this.onTap, this.onEdit,this.isManage=false})
      : super(key: key);
  final Category category;
  final GestureTapCallback? onTap, onEdit;
  final bool isManage;
  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: onTap,
        child: Card(
          elevation: 5,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          color: hexToColor(category.bgCardColor),
          child: Stack(
            children: [
              Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    flex: 50,
                    child: Padding(
                      padding:
                          const EdgeInsets.only(top: 8.0, left: 5, right: 5),
                      child: Image.network(
                        category.image,
                        errorBuilder: (context, error, stackTrace) {
                          return Image.asset(
                            category.image,
                            errorBuilder: (context, error, stackTrace) {
                              return Image.asset(
                                'assets/images/img_placeholder.png',
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 40,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 5),
                          Text(
                            category.title,
                            style: tsPoppins(
                                weight: FontWeight.w600, color: white),
                          ),
                          Text(
                            category.desc,
                            style: tsPoppins(
                                size: 11,
                                weight: FontWeight.w400,
                                color: white),
                          ),
                          // const SizedBox(height: 5),
                          Container(
                            alignment: Alignment.bottomRight,
                            child: Icon(
                              Icons.arrow_forward_sharp,
                              color: white,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
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
        ));
  }
}
