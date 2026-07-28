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
  
  // Subscription endpoints
  static const String subscriptionPlans = '$baseUrl/subscriptions/plans/';
  static const String subscribe = '$baseUrl/subscriptions/subscribe/';
  static const String mySubscription = '$baseUrl/subscriptions/my-subscription/';
  static const String creditStatus = '$baseUrl/subscriptions/credit-status/';

  // Bookings endpoints
  static const String bookClass = '$baseUrl/bookings/book/';
  static const String bookingsStatus = '$baseUrl/bookings/status/';
  static String cancelBooking(int id) => '$baseUrl/bookings/$id/cancel/';
  
  // Home/Studio Endpoints
  static const String classes = '$baseUrl/studios/classes/explore/';
  static String classesSearch(String query) => '$baseUrl/studios/classes/explore/?search=$query';
  static String classDetails(int id) => '$baseUrl/studios/classes/$id/';
  static const String studios = '$baseUrl/studios/nearby/?latitude=23.8103&longitude=90.4125&radius=10000';
  static String studioDetails(int id) => '$baseUrl/studios/$id/';

  // Favorites Endpoints
  static const String favoriteStudios = '$baseUrl/studios/favorites/';
  static const String favoriteClasses = '$baseUrl/studios/classes/favorites/';
  static String toggleFavoriteStudio(int id) => '$baseUrl/studios/$id/favorite/';
  static String toggleFavoriteClass(int id) => '$baseUrl/studios/classes/$id/favorite/';
}
