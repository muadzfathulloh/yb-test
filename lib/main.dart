import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app/data/services/auth_service.dart';
import 'app/data/services/bookmark_service.dart';
import 'app/data/services/connectivity_service.dart';
import 'app/data/services/notification_service.dart';
import 'app/routes/app_pages.dart';
import 'app/routes/app_routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  await Get.putAsync(() => NotificationService().init());
  await Get.putAsync(() => ConnectivityService().init());
  Get.put<AuthService>(AuthService());
  Get.put<BookmarkService>(BookmarkService());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final authService = Get.find<AuthService>();

    return GetMaterialApp(
      title: "Flutter GetX App",
      initialRoute: authService.isLoggedIn ? Routes.MAIN : AppPages.INITIAL,
      getPages: AppPages.routes,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        textTheme: GoogleFonts.outfitTextTheme(),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
