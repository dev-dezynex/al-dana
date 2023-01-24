import 'package:al_dana/app/routes/app_pages.dart';
import 'package:get/get.dart';

import '../../../data/data.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    initSplash();
  }


  @override
  void onClose() {}

  void initSplash() async {
    print('on init splash');
    Future.delayed(
      const Duration(seconds: 3),
      () {
        setRoute();
      },
    );
  }

  void setRoute() async {
    bool isLoggedIn =
        await storage.read(is_login) != null && storage.read(is_login);

    Get.offAndToNamed(isLoggedIn ? Routes.HOME : Routes.AUTH);
  }
}
