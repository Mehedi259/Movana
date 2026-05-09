# Movana - Flutter Project Structure

এই প্রজেক্টটি **Clean Architecture** এবং **Feature-First** approach অনুসরণ করে তৈরি করা হয়েছে।

## 📁 Folder Structure

```
lib/
├── core/                          # Core functionality এবং shared resources
│   ├── constants/                 # App-wide constants
│   │   ├── app_colors.dart       # Color definitions
│   │   ├── app_routes.dart       # Route names
│   │   └── app_strings.dart      # String constants
│   ├── theme/                     # App theming
│   │   └── app_theme.dart        # Theme configuration
│   └── utils/                     # Utility functions
│       └── validators.dart       # Form validators
│
├── features/                      # Feature-based modules
│   ├── auth/                      # Authentication feature
│   │   └── presentation/
│   │       ├── screens/          # Auth screens
│   │       │   ├── splash_screen.dart
│   │       │   ├── onboarding_screen_1.dart
│   │       │   ├── onboarding_screen_2.dart
│   │       │   ├── onboarding_screen_3.dart
│   │       │   ├── login_screen.dart
│   │       │   ├── signup_screen.dart
│   │       │   ├── forgot_password_screen.dart
│   │       │   ├── verification_screen.dart
│   │       │   ├── reset_password_screen.dart
│   │       │   └── reset_password_success_screen.dart
│   │       └── widgets/          # Auth-specific widgets
│   │           └── auth_text_field.dart
│   │
│   ├── home/                      # Home feature
│   │   └── presentation/
│   │       └── screens/
│   │           └── home_screen.dart
│   │
│   ├── search/                    # Search feature
│   │   └── presentation/
│   │       └── screens/
│   │           └── search_screen.dart
│   │
│   ├── bookings/                  # Bookings feature
│   │   └── presentation/
│   │       └── screens/
│   │           └── bookings_screen.dart
│   │
│   ├── favorites/                 # Favorites feature
│   │   └── presentation/
│   │       └── screens/
│   │           └── favorites_screen.dart
│   │
│   ├── profile/                   # Profile feature
│   │   └── presentation/
│   │       └── screens/
│   │           └── profile_screen.dart
│   │
│   ├── studio/                    # Studio feature
│   │   └── presentation/
│   │       └── screens/
│   │           └── studio_details_screen.dart
│   │
│   ├── class/                     # Class feature
│   │   └── presentation/
│   │       └── screens/
│   │           └── class_details_screen.dart
│   │
│   └── reservation/               # Reservation feature
│       └── presentation/
│           └── screens/
│               └── reservation_screen.dart
│
├── routes/                        # Navigation
│   └── app_router.dart           # Route configuration
│
├── shared/                        # Shared widgets এবং utilities
│   └── widgets/                  # Reusable widgets
│       ├── custom_button.dart
│       └── loading_indicator.dart
│
└── main.dart                      # App entry point
```

## 🎯 Feature Structure

প্রতিটি feature এর জন্য নিচের structure অনুসরণ করা হয়েছে:

```
feature_name/
├── data/                    # Data layer (API, models, repositories)
│   ├── models/             # Data models
│   ├── repositories/       # Repository implementations
│   └── datasources/        # Remote/Local data sources
├── domain/                  # Business logic layer
│   ├── entities/           # Business entities
│   ├── repositories/       # Repository interfaces
│   └── usecases/           # Use cases
└── presentation/            # UI layer
    ├── screens/            # Screen widgets
    ├── widgets/            # Feature-specific widgets
    └── providers/          # State management (if using Provider/Riverpod)
```

## 📱 Screens List

### Authentication Screens
1. ✅ Splash Screen
2. ✅ Onboarding Screen 1
3. ✅ Onboarding Screen 2
4. ✅ Onboarding Screen 3
5. ✅ Login Screen
6. ✅ Sign Up Screen
7. ✅ Forgot Password Screen
8. ✅ Verification Screen
9. ✅ Reset Password Screen
10. ✅ Reset Password Success Screen

### Main Screens
11. ✅ Home Screen
12. ✅ Search Screen
13. ✅ Bookings Screen
14. ✅ Favorites Screen
15. ✅ Profile Screen

### Details Screens
16. ✅ Studio Details Screen
17. ✅ Class Details Screen
18. ✅ Reservation Screen

## 🚀 Next Steps

### 1. State Management Setup
আপনার পছন্দের state management solution যোগ করুন:
- Provider
- Riverpod
- Bloc
- GetX

### 2. Data Layer Implementation
প্রতিটি feature এর জন্য:
```dart
feature_name/
├── data/
│   ├── models/
│   │   └── feature_model.dart
│   ├── repositories/
│   │   └── feature_repository_impl.dart
│   └── datasources/
│       ├── feature_remote_datasource.dart
│       └── feature_local_datasource.dart
```

### 3. Domain Layer Implementation
```dart
feature_name/
├── domain/
│   ├── entities/
│   │   └── feature_entity.dart
│   ├── repositories/
│   │   └── feature_repository.dart
│   └── usecases/
│       └── get_feature_usecase.dart
```

### 4. API Integration
- `lib/core/network/` folder তৈরি করুন
- API client setup করুন (Dio/http)
- Interceptors যোগ করুন

### 5. Local Storage
- SharedPreferences/Hive setup করুন
- `lib/core/storage/` folder তৈরি করুন

### 6. Assets Organization
```
assets/
├── images/
│   ├── onboarding/
│   ├── icons/
│   └── logos/
├── fonts/
└── animations/
```

## 🎨 Design System

### Colors
`lib/core/constants/app_colors.dart` এ সব colors define করা আছে।

### Theme
`lib/core/theme/app_theme.dart` এ app theme configure করা আছে।

### Strings
`lib/core/constants/app_strings.dart` এ সব text constants আছে।

## 📝 Naming Conventions

- **Files**: snake_case (e.g., `home_screen.dart`)
- **Classes**: PascalCase (e.g., `HomeScreen`)
- **Variables**: camelCase (e.g., `userName`)
- **Constants**: camelCase with static const (e.g., `static const primaryColor`)

## 🔧 Useful Commands

```bash
# Get dependencies
flutter pub get

# Run app
flutter run

# Build APK
flutter build apk

# Build iOS
flutter build ios

# Clean project
flutter clean
```

## 📦 Recommended Packages

```yaml
dependencies:
  # State Management
  provider: ^6.0.0
  # or
  flutter_riverpod: ^2.0.0
  
  # Navigation
  go_router: ^10.0.0
  
  # Network
  dio: ^5.0.0
  
  # Local Storage
  shared_preferences: ^2.0.0
  hive: ^2.0.0
  
  # UI
  cached_network_image: ^3.0.0
  shimmer: ^3.0.0
  
  # Utils
  intl: ^0.18.0
  equatable: ^2.0.0
```

---

**Happy Coding! 🚀**
