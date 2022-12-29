import 'package:get/get.dart';

import '../controllers/track_page_controller.dart';

class TrackPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TrackPageController>(
      () => TrackPageController(),
    );
  }
}
