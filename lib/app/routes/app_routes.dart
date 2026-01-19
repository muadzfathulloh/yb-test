abstract class Routes {
  Routes._();
  static const MAIN = _Paths.MAIN;
  static const DASHBOARD = _Paths.DASHBOARD;
  static const LOGIN = _Paths.LOGIN;
  static const SIGNUP = _Paths.SIGNUP;
  static const FORGOT_PASSWORD = _Paths.FORGOT_PASSWORD;
  static const OTP_VERIFICATION = _Paths.OTP_VERIFICATION;
  static const RESET_PASSWORD = _Paths.RESET_PASSWORD;
  static const NEWS_DETAIL = _Paths.NEWS_DETAIL;
  static const TRENDING = _Paths.TRENDING;
  static const LATEST = _Paths.LATEST;
  static const COMMENTS = _Paths.COMMENTS;
  static const SEARCH = _Paths.SEARCH;
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
