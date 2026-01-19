import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/theme/app_colors.dart';

class ConnectivityService extends GetxService {
  final Connectivity _connectivity = Connectivity();
  final RxBool isOnline = true.obs;

  // Track if we were previously offline to show "Back Online" message
  bool _wasOffline = false;

  Future<ConnectivityService> init() async {
    // Initial check
    final results = await _connectivity.checkConnectivity();
    _updateState(results);

    // Listen to changes
    _connectivity.onConnectivityChanged.listen(_updateState);

    return this;
  }

  void _updateState(List<ConnectivityResult> results) {
    // connectivity_plus 6.x returns a list of results
    final bool online = results.isNotEmpty && !results.contains(ConnectivityResult.none);

    if (online != isOnline.value) {
      isOnline.value = online;

      if (!online) {
        _wasOffline = true;
        _showOfflineSnackbar();
      } else if (_wasOffline) {
        _showOnlineSnackbar();
        _wasOffline = false;
      }
    }
  }

  void _showOfflineSnackbar() {
    Get.rawSnackbar(
      messageText: const Text(
        'No Internet Connection',
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
      icon: const Icon(Icons.wifi_off, color: Colors.white),
      backgroundColor: AppColors.error,
      snackPosition: SnackPosition.TOP,
      isDismissible: false,
      duration: const Duration(days: 1), // Persistent until online
      shouldIconPulse: true,
      margin: const EdgeInsets.all(16),
      borderRadius: 12,
    );
  }

  void _showOnlineSnackbar() {
    // Close the persistent offline snackbar
    if (Get.isSnackbarOpen) {
      Get.closeCurrentSnackbar();
    }

    Get.rawSnackbar(
      messageText: const Text(
        'Back Online',
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
      icon: const Icon(Icons.wifi, color: Colors.white),
      backgroundColor: Colors.green,
      snackPosition: SnackPosition.TOP,
      duration: const Duration(seconds: 3),
      margin: const EdgeInsets.all(16),
      borderRadius: 12,
    );
  }
}
