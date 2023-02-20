import 'package:al_dana/app/data/data.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../routes/app_pages.dart';
import '../controllers/branch_list_controller.dart';

class BranchListView extends GetView<BranchListController> {
  const BranchListView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Branches',
            style:
                tsPoppins(size: 18, weight: FontWeight.w600, color: textDark80),
          ),
          centerTitle: true,
          leading: const GoBack(),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Get.toNamed(Routes.ADD_BRANCH);
          },
          backgroundColor: primary,
          child: const Icon(
            Icons.add,
          ),
        ),
        body: SafeArea(
          child: Obx(
            () => ListView.builder(
                itemCount: controller.branchResult.value.branchList!.length,
                itemBuilder: (con, i) {
                  return BranchTile(
                      isManage: true,
                      onEdit: () {
                        Get.toNamed(Routes.ADD_BRANCH,
                            arguments:
                                controller.branchResult.value.branchList![i]);
                      },
                      branch: controller.branchResult.value.branchList![i]);
                }),
          ),
        ));
  }
}
