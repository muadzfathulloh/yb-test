import 'package:get/get.dart';

import '../modules/comments/bindings/comments_binding.dart';
import '../modules/comments/views/comments_view.dart';
import '../modules/dashboard/bindings/dashboard_binding.dart';
import '../modules/dashboard/views/dashboard_view.dart';
import '../modules/forgot_password/bindings/forgot_password_binding.dart';
import '../modules/forgot_password/views/forgot_password_view.dart';
import '../modules/latest/bindings/latest_binding.dart';
import '../modules/latest/views/latest_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/main/bindings/main_binding.dart';
import '../modules/main/views/main_view.dart';
import '../modules/news_detail/bindings/news_detail_binding.dart';
import '../modules/news_detail/views/news_detail_view.dart';
import '../modules/otp_verification/bindings/otp_verification_binding.dart';
import '../modules/otp_verification/views/otp_verification_view.dart';
import '../modules/reset_password/bindings/reset_password_binding.dart';
import '../modules/reset_password/views/reset_password_view.dart';
import '../modules/search/bindings/search_binding.dart';
import '../modules/search/views/search_view.dart';
import '../modules/signup/bindings/signup_binding.dart';
import '../modules/signup/views/signup_view.dart';
import '../modules/trending/bindings/trending_binding.dart';
import '../modules/trending/views/trending_view.dart';
import 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.LOGIN;

  static final routes = [
    GetPage(name: _Paths.MAIN, page: () => const MainView(), binding: MainBinding()),
    GetPage(name: _Paths.DASHBOARD, page: () => const DashboardView(), binding: DashboardBinding()),
    GetPage(name: _Paths.LOGIN, page: () => const LoginView(), binding: LoginBinding()),
    GetPage(name: _Paths.SIGNUP, page: () => const SignupView(), binding: SignupBinding()),
    GetPage(
      name: _Paths.FORGOT_PASSWORD,
      page: () => const ForgotPasswordView(),
      binding: ForgotPasswordBinding(),
    ),
    GetPage(
      name: _Paths.OTP_VERIFICATION,
      page: () => const OtpVerificationView(),
      binding: OtpVerificationBinding(),
    ),
    GetPage(
      name: _Paths.RESET_PASSWORD,
      page: () => const ResetPasswordView(),
      binding: ResetPasswordBinding(),
    ),
    GetPage(
      name: _Paths.NEWS_DETAIL,
      page: () => const NewsDetailView(),
      binding: NewsDetailBinding(),
    ),
    GetPage(name: _Paths.TRENDING, page: () => const TrendingView(), binding: TrendingBinding()),
    GetPage(name: _Paths.LATEST, page: () => const LatestView(), binding: LatestBinding()),
    GetPage(name: _Paths.COMMENTS, page: () => const CommentsView(), binding: CommentsBinding()),
    GetPage(name: _Paths.SEARCH, page: () => const SearchResultView(), binding: SearchBinding()),
  ];
}

abstract class _Paths {
  _Paths._();
  static const MAIN = '/main';
  static const DASHBOARD = '/dashboard';
  static const LOGIN = '/login';
  static const SIGNUP = '/signup';
  static const FORGOT_PASSWORD = '/forgot-password';
  static const OTP_VERIFICATION = '/otp-verification';
  static const RESET_PASSWORD = '/reset-password';
  static const NEWS_DETAIL = '/news-detail';
  static const TRENDING = '/trending';
  static const LATEST = '/latest';
  static const COMMENTS = '/comments';
  static const SEARCH = '/search';
}
