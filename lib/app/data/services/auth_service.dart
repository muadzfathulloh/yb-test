import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'notification_service.dart';

class LoginResult {
  final bool success;
  final bool isFirstTime;
  final String? message;

  LoginResult({required this.success, this.isFirstTime = false, this.message});
}

class AuthService extends GetxService {
  final _notificationService = Get.find<NotificationService>();
  final _storage = GetStorage();

  static const String _sessionKey = 'user_session';

  // Mock users database
  final List<Map<String, dynamic>> _users = [
    {
      'email': 'user@gmail.com',
      'password': 'user123',
      'isFirstTime': true,
      'name': 'Demo User',
      'bio': 'Software Explorer & Flutter Dev',
    },
    {
      'email': 'admin@gmail.com',
      'password': 'admin123',
      'isFirstTime': true,
      'name': 'Admin User',
      'bio': 'System Administrator',
    },
  ];

  // Store active OTPs (Mock DB)
  final Map<String, String> _activeOtps = {};

  bool get isLoggedIn => _storage.hasData(_sessionKey);
  Map<String, dynamic>? get currentUser => _storage.read(_sessionKey);

  Future<LoginResult> login(String email, String password) async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));

    final user = _users.firstWhereOrNull((u) => u['email'] == email && u['password'] == password);

    if (user == null) {
      return LoginResult(success: false, message: 'Invalid email or password');
    }

    final isFirstTime = user['isFirstTime'] as bool;
    if (isFirstTime) {
      // Automatically send OTP for first time login
      await sendOtp(email);
    } else {
      // Save session for non-first-time users immediately
      _saveSession(user);
    }

    return LoginResult(success: true, isFirstTime: isFirstTime);
  }

  Future<void> sendOtp(String email) async {
    // Generate a 4-digit OTP
    final otp = (1000 + (DateTime.now().millisecondsSinceEpoch % 9000)).toString();
    _activeOtps[email] = otp;

    // Simulation: Show local notification instead of real email
    print('----------------------------------------');
    print('OTP CODE GENERATED for $email: $otp');

    try {
      await _notificationService.showFakeEmailNotification(otp);
      print('FAKE EMAIL NOTIFICATION TRIGGERED for $email');
    } catch (e) {
      print('ERROR triggering notification: $e');
    }
    print('----------------------------------------');
  }

  Future<bool> verifyOtp(String email, String otp) async {
    await Future.delayed(const Duration(milliseconds: 500));

    final storedOtp = _activeOtps[email];
    if (storedOtp == otp) {
      _activeOtps.remove(email);

      // Update user to no longer be first-time (in mock DB)
      final userIndex = _users.indexWhere((u) => u['email'] == email);
      if (userIndex != -1) {
        _users[userIndex]['isFirstTime'] = false;
        _saveSession(_users[userIndex]);
      }
      return true;
    }
    return false;
  }

  void _saveSession(Map<String, dynamic> user) {
    _storage.write(_sessionKey, {
      'email': user['email'],
      'name': user['name'],
      'bio': user['bio'] ?? 'No bio available',
    });
  }

  void logout() {
    _storage.remove(_sessionKey);
    Get.offAllNamed('/login');
  }
}
