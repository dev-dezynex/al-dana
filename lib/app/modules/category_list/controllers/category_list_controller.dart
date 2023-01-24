import 'package:al_dana/app/data/data.dart';
import 'package:get/get.dart';

class CategoryListController extends GetxController {
  var categoryResult = CategoryResult().obs;
  @override
  void onInit() {
    super.onInit();
    getCategories();
  }



  void getCategories() async {
    categoryResult.value = await CategoryProvider().getDummyData();
    categoryResult.refresh();
  }
}
