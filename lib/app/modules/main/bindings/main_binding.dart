import 'package:get/get.dart';

import '../../bookmark/controllers/bookmark_controller.dart';
import '../../dashboard/controllers/dashboard_controller.dart';
import '../../explore/controllers/explore_controller.dart';
import '../controllers/main_controller.dart';

class MainBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MainController>(() => MainController());
    Get.lazyPut<DashboardController>(() => DashboardController());
    Get.lazyPut<ExploreController>(() => ExploreController());
    Get.put<BookmarkController>(BookmarkController());
  }
}
