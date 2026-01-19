import 'package:get/get.dart';

import '../controllers/latest_controller.dart';

class LatestBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LatestController>(() => LatestController());
  }
}
