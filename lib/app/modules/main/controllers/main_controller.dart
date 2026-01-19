import 'package:get/get.dart';

import '../../../data/services/auth_service.dart';

class MainController extends GetxController {
  final _authService = Get.find<AuthService>();
  final RxInt selectedIndex = 0.obs;

  void changeIndex(int index) {
    selectedIndex.value = index;
  }

  Map<String, dynamic>? get currentUser => _authService.currentUser;

  void logout() {
    _authService.logout();
  }
}
