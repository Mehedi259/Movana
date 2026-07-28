class ApiConstants {
  static const String baseUrl = 'http://16.170.40.206:8000';
  
  // Auth Endpoints
  static const String register = '$baseUrl/accounts/user/register/';
  static const String verifyOtp = '$baseUrl/accounts/user/verify-otp/'; 
  static const String login = '$baseUrl/accounts/user/login/';
  static const String forgetPassword = '$baseUrl/accounts/user/send-reset-password-email/';
  static const String resetPasswordOtp = '$baseUrl/accounts/user/reset-password-otp/';
  static const String resetNewPassword = '$baseUrl/accounts/user/set-new-password/';
  static const String profile = '$baseUrl/accounts/user/profile/';
  static const String changePassword = '$baseUrl/accounts/user/change-password/';
  static const String logout = '$baseUrl/accounts/user/logout/';
  static const String deleteAccount = '$baseUrl/accounts/user/delete-account/';
  
  // Home/Studio Endpoints
  static const String creditStatus = '$baseUrl/subscriptions/credit-status/';
  static const String classes = '$baseUrl/studios/classes/explore/';
  static const String studios = '$baseUrl/studios/nearby/?latitude=23.8103&longitude=90.4125&radius=10000';
}
