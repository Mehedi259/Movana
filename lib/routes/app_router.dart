import 'package:flutter/material.dart';
import '../core/constants/app_routes.dart';
import '../features/auth/presentation/screens/splash_screen.dart';
import '../features/auth/presentation/screens/onboarding_screen_1.dart';
import '../features/auth/presentation/screens/onboarding_screen_2.dart';
import '../features/auth/presentation/screens/onboarding_screen_3.dart';
import '../features/auth/presentation/screens/login_screen.dart';
import '../features/auth/presentation/screens/signup_screen.dart';
import '../features/auth/presentation/screens/forgot_password_screen.dart';
import '../features/auth/presentation/screens/verification_screen.dart';
import '../features/auth/presentation/screens/reset_password_screen.dart';
import '../features/auth/presentation/screens/reset_password_success_screen.dart';
import '../features/home/presentation/screens/home_screen.dart';
import '../features/search/presentation/screens/search_screen.dart';
import '../features/bookings/presentation/screens/bookings_screen.dart';
import '../features/favorites/presentation/screens/favorites_screen.dart';
import '../features/profile/presentation/screens/profile_screen.dart';
import '../features/studio/presentation/screens/studio_details_screen.dart';
import '../features/class/presentation/screens/class_details_screen.dart';
import '../features/reservation/presentation/screens/reservation_screen.dart';
import '../features/profile/presentation/screens/edit_profile_screen.dart';
import '../features/profile/presentation/screens/fitness_interests_screen.dart';
import '../features/profile/presentation/screens/location_preferences_screen.dart';
import '../features/profile/presentation/screens/plans_screen.dart';
import '../features/profile/presentation/screens/special_offer_screen.dart';
import '../features/profile/presentation/screens/offer_claimed_screen.dart';
import '../features/profile/presentation/screens/faq_screen.dart';
import '../features/profile/presentation/screens/help_support_screen.dart';
import '../features/profile/presentation/screens/security_screen.dart';
import '../features/profile/presentation/screens/terms_policy_screen.dart';
import '../features/profile/presentation/screens/change_password_screen.dart';
import '../features/profile/presentation/screens/contact_support_screen.dart';
import '../features/profile/presentation/screens/privacy_policy_screen.dart';
import '../features/profile/presentation/screens/terms_conditions_screen.dart';
import '../features/bookings/presentation/screens/review_screen.dart';
import '../features/bookings/presentation/screens/booking_details_screen.dart';
import '../features/class/presentation/screens/class_schedule_screen.dart';
import '../features/favorites/presentation/screens/favorite_classes_screen.dart';
import '../features/search/presentation/screens/search_map_screen.dart';
import '../features/reservation/presentation/screens/booking_confirmation_screen.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      // Auth Routes
      case AppRoutes.splash:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case AppRoutes.onboarding1:
        return MaterialPageRoute(builder: (_) => const OnboardingScreen1());
      case AppRoutes.onboarding2:
        return MaterialPageRoute(builder: (_) => const OnboardingScreen2());
      case AppRoutes.onboarding3:
        return MaterialPageRoute(builder: (_) => const OnboardingScreen3());
      case AppRoutes.login:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case AppRoutes.signUp:
        return MaterialPageRoute(builder: (_) => const SignUpScreen());
      case AppRoutes.forgotPassword:
        return MaterialPageRoute(builder: (_) => const ForgotPasswordScreen());
      case AppRoutes.verification:
        return MaterialPageRoute(builder: (_) => const VerificationScreen(), settings: settings);
      case AppRoutes.resetPassword:
        return MaterialPageRoute(builder: (_) => const ResetPasswordScreen());
      case AppRoutes.resetPasswordSuccess:
        return MaterialPageRoute(builder: (_) => const ResetPasswordSuccessScreen());
      
      // Main Routes
      case AppRoutes.home:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case AppRoutes.search:
        return MaterialPageRoute(builder: (_) => const SearchScreen());
      case AppRoutes.bookings:
        return MaterialPageRoute(builder: (_) => const BookingsScreen());
      case AppRoutes.favorites:
        return MaterialPageRoute(builder: (_) => const FavoritesScreen());
      case AppRoutes.profile:
        return MaterialPageRoute(builder: (_) => const ProfileScreen());
      
      // Details Routes
      case AppRoutes.studioDetails:
        final studioId = settings.arguments as int?;
        return MaterialPageRoute(builder: (_) => StudioDetailsScreen(studioId: studioId));
      case AppRoutes.classDetails:
        return MaterialPageRoute(builder: (_) => const ClassDetailsScreen());
      case AppRoutes.reservation:
        return MaterialPageRoute(builder: (_) => const ReservationScreen());
      
      // Profile Settings Routes
      case AppRoutes.editProfile:
        return MaterialPageRoute(builder: (_) => const EditProfileScreen());
      case AppRoutes.fitnessInterests:
        return MaterialPageRoute(builder: (_) => const FitnessInterestsScreen());
      case AppRoutes.locationPreferences:
        return MaterialPageRoute(builder: (_) => const LocationPreferencesScreen());
      case AppRoutes.plans:
        return MaterialPageRoute(builder: (_) => const PlansScreen());
      case AppRoutes.specialOffer:
        return MaterialPageRoute(builder: (_) => const SpecialOfferScreen());
      case AppRoutes.offerClaimed:
        return MaterialPageRoute(builder: (_) => const OfferClaimedScreen());
      
      // Support & Settings Routes
      case AppRoutes.faq:
        return MaterialPageRoute(builder: (_) => const FAQScreen());
      case AppRoutes.helpSupport:
        return MaterialPageRoute(builder: (_) => const HelpSupportScreen());
      case AppRoutes.security:
        return MaterialPageRoute(builder: (_) => const SecurityScreen());
      case AppRoutes.termsPolicy:
        return MaterialPageRoute(builder: (_) => const TermsPolicyScreen());
      case AppRoutes.changePassword:
        return MaterialPageRoute(builder: (_) => const ChangePasswordScreen());
      case AppRoutes.contactSupport:
        return MaterialPageRoute(builder: (_) => const ContactSupportScreen());
      case AppRoutes.privacyPolicy:
        return MaterialPageRoute(builder: (_) => const PrivacyPolicyScreen());
      case AppRoutes.termsConditions:
        return MaterialPageRoute(builder: (_) => const TermsConditionsScreen());
      
      // Additional Routes
      case AppRoutes.review:
        return MaterialPageRoute(builder: (_) => const ReviewScreen());
      case AppRoutes.bookingDetails:
        return MaterialPageRoute(builder: (_) => const BookingDetailsScreen());
      case AppRoutes.classSchedule:
        return MaterialPageRoute(builder: (_) => const ClassScheduleScreen());
      case AppRoutes.favoriteClasses:
        return MaterialPageRoute(builder: (_) => const FavoriteClassesScreen());
      case AppRoutes.searchMap:
        return MaterialPageRoute(builder: (_) => const SearchMapScreen());
      case AppRoutes.bookingConfirmation:
        return MaterialPageRoute(builder: (_) => const BookingConfirmationScreen());
      
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}
