import 'package:al_dana/app/data/data.dart';
import 'package:get/get.dart';

class BranchListController extends GetxController {
  var branchResult = BranchResult().obs;
  @override
  void onInit() {
    super.onInit();
    getDetails();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void getDetails() {
    getBranches();
  }

  void getBranches() async {
    branchResult.value = await BranchProvider().getDummyData();
    branchResult.refresh();
  }
}
