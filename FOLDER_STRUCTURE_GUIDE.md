# 📂 Movana - Complete Folder Structure Guide

## 🎯 Overview
এই প্রজেক্টটি **Clean Architecture** এবং **Feature-First** approach অনুসরণ করে সাজানো হয়েছে। প্রতিটি feature আলাদা module হিসেবে কাজ করে যা সহজে maintain এবং scale করা যায়।

---

## 📁 Complete Structure

```
lib/
│
├── 🎨 core/                                    # Core functionality
│   ├── constants/                              # App-wide constants
│   │   ├── app_colors.dart                    # ✅ Color palette
│   │   ├── app_routes.dart                    # ✅ Route definitions
│   │   ├── app_strings.dart                   # ✅ Text constants
│   │   └── app_assets.dart                    # ✅ Asset paths
│   │
│   ├── theme/                                  # Theming
│   │   └── app_theme.dart                     # ✅ Theme configuration
│   │
│   ├── utils/                                  # Utilities
│   │   ├── validators.dart                    # ✅ Form validators
│   │   └── extensions.dart                    # ✅ Dart extensions
│   │
│   └── network/                                # Network layer (TODO)
│       ├── api_client.dart                    # API client setup
│       ├── api_endpoints.dart                 # API endpoints
│       └── interceptors/                      # HTTP interceptors
│
├── 🔐 features/auth/                           # Authentication Feature
│   ├── presentation/
│   │   ├── screens/
│   │   │   ├── splash_screen.dart            # ✅ Splash
│   │   │   ├── onboarding_screen_1.dart      # ✅ Onboarding 1
│   │   │   ├── onboarding_screen_2.dart      # ✅ Onboarding 2
│   │   │   ├── onboarding_screen_3.dart      # ✅ Onboarding 3
│   │   │   ├── login_screen.dart             # ✅ Login
│   │   │   ├── signup_screen.dart            # ✅ Sign Up
│   │   │   ├── forgot_password_screen.dart   # ✅ Forgot Password
│   │   │   ├── verification_screen.dart      # ✅ Verification
│   │   │   ├── reset_password_screen.dart    # ✅ Reset Password
│   │   │   └── reset_password_success_screen.dart # ✅ Success
│   │   │
│   │   └── widgets/
│   │       └── auth_text_field.dart          # ✅ Custom text field
│   │
│   ├── data/                                   # Data layer (TODO)
│   │   ├── models/
│   │   │   └── user_model.dart
│   │   ├── repositories/
│   │   │   └── auth_repository_impl.dart
│   │   └── datasources/
│   │       └── auth_remote_datasource.dart
│   │
│   └── domain/                                 # Business logic (TODO)
│       ├── entities/
│       │   └── user_entity.dart
│       ├── repositories/
│       │   └── auth_repository.dart
│       └── usecases/
│           ├── login_usecase.dart
│           └── signup_usecase.dart
│
├── 🏠 features/home/                           # Home Feature
│   └── presentation/
│       ├── screens/
│       │   └── home_screen.dart              # ✅ Home
│       └── widgets/
│           ├── class_card.dart               # ✅ Class card widget
│           └── studio_card.dart              # ✅ Studio card widget
│
├── 🔍 features/search/                         # Search Feature
│   └── presentation/
│       └── screens/
│           └── search_screen.dart            # ✅ Search
│
├── 📅 features/bookings/                       # Bookings Feature
│   └── presentation/
│       └── screens/
│           └── bookings_screen.dart          # ✅ Bookings
│
├── ❤️ features/favorites/                      # Favorites Feature
│   └── presentation/
│       └── screens/
│           └── favorites_screen.dart         # ✅ Favorites
│
├── 👤 features/profile/                        # Profile Feature
│   └── presentation/
│       └── screens/
│           └── profile_screen.dart           # ✅ Profile
│
├── 🏢 features/studio/                         # Studio Feature
│   └── presentation/
│       └── screens/
│           └── studio_details_screen.dart    # ✅ Studio Details
│
├── 🎓 features/class/                          # Class Feature
│   └── presentation/
│       └── screens/
│           └── class_details_screen.dart     # ✅ Class Details
│
├── 📝 features/reservation/                    # Reservation Feature
│   └── presentation/
│       └── screens/
│           └── reservation_screen.dart       # ✅ Reservation
│
├── 🔀 routes/                                  # Navigation
│   └── app_router.dart                        # ✅ Route configuration
│
├── 🧩 shared/                                  # Shared components
│   └── widgets/                               # Reusable widgets
│       ├── custom_button.dart                # ✅ Custom button
│       ├── loading_indicator.dart            # ✅ Loading widget
│       ├── custom_app_bar.dart               # ✅ Custom app bar
│       ├── empty_state.dart                  # ✅ Empty state widget
│       └── error_view.dart                   # ✅ Error view widget
│
└── main.dart                                   # ✅ App entry point
```

---

## 🎯 Feature Module Structure

প্রতিটি feature এর জন্য এই structure অনুসরণ করুন:

```
feature_name/
│
├── 📱 presentation/              # UI Layer
│   ├── screens/                 # Screen widgets
│   ├── widgets/                 # Feature-specific widgets
│   └── providers/               # State management
│
├── 💾 data/                     # Data Layer
│   ├── models/                  # Data models (JSON serialization)
│   ├── repositories/            # Repository implementations
│   └── datasources/             # API/Local data sources
│       ├── remote/              # API calls
│       └── local/               # Local storage
│
└── 🎯 domain/                   # Business Logic Layer
    ├── entities/                # Business entities
    ├── repositories/            # Repository interfaces
    └── usecases/                # Use cases (business logic)
```

---

## 📱 All Screens (18 Total)

### 🔐 Authentication (10 screens)
| # | Screen | Status | Route |
|---|--------|--------|-------|
| 1 | Splash | ✅ | `/` |
| 2 | Onboarding 1 | ✅ | `/onboarding1` |
| 3 | Onboarding 2 | ✅ | `/onboarding2` |
| 4 | Onboarding 3 | ✅ | `/onboarding3` |
| 5 | Login | ✅ | `/login` |
| 6 | Sign Up | ✅ | `/signup` |
| 7 | Forgot Password | ✅ | `/forgot-password` |
| 8 | Verification | ✅ | `/verification` |
| 9 | Reset Password | ✅ | `/reset-password` |
| 10 | Reset Success | ✅ | `/reset-password-success` |

### 🏠 Main App (5 screens)
| # | Screen | Status | Route |
|---|--------|--------|-------|
| 11 | Home | ✅ | `/home` |
| 12 | Search | ✅ | `/search` |
| 13 | Bookings | ✅ | `/bookings` |
| 14 | Favorites | ✅ | `/favorites` |
| 15 | Profile | ✅ | `/profile` |

### 📄 Details (3 screens)
| # | Screen | Status | Route |
|---|--------|--------|-------|
| 16 | Studio Details | ✅ | `/studio-details` |
| 17 | Class Details | ✅ | `/class-details` |
| 18 | Reservation | ✅ | `/reservation` |

---

## 🎨 Design System Components

### Colors (`app_colors.dart`)
```dart
- Primary Color
- Secondary Color
- Background Colors
- Text Colors
- Status Colors (Success, Error, Warning, Info)
```

### Shared Widgets
```dart
✅ CustomButton          - Reusable button
✅ LoadingIndicator      - Loading spinner
✅ CustomAppBar          - Custom app bar
✅ EmptyState            - Empty state view
✅ ErrorView             - Error display
✅ AuthTextField         - Auth input field
✅ ClassCard             - Class display card
✅ StudioCard            - Studio display card
```

### Utilities
```dart
✅ Validators            - Form validation
✅ Extensions            - Dart extensions
   - String extensions
   - Context extensions
   - DateTime extensions
```

---

## 🚀 Next Steps

### 1️⃣ State Management Setup
Choose and implement:
- [ ] Provider / Riverpod
- [ ] Bloc
- [ ] GetX

### 2️⃣ API Integration
```dart
lib/core/network/
├── api_client.dart          # Dio/HTTP setup
├── api_endpoints.dart       # API URLs
└── interceptors/
    ├── auth_interceptor.dart
    └── logging_interceptor.dart
```

### 3️⃣ Local Storage
```dart
lib/core/storage/
├── local_storage.dart       # SharedPreferences wrapper
└── secure_storage.dart      # Secure storage for tokens
```

### 4️⃣ Models & Entities
প্রতিটি feature এর জন্য:
```dart
data/models/              # JSON serialization
domain/entities/          # Business objects
```

### 5️⃣ Repository Pattern
```dart
domain/repositories/      # Interfaces
data/repositories/        # Implementations
```

### 6️⃣ Use Cases
```dart
domain/usecases/
├── get_studios_usecase.dart
├── book_class_usecase.dart
└── ...
```

---

## 📦 Recommended Packages

### Essential
```yaml
# State Management
provider: ^6.1.0
# or
flutter_riverpod: ^2.4.0

# Navigation
go_router: ^12.0.0

# Network
dio: ^5.4.0
retrofit: ^4.0.0

# JSON Serialization
json_annotation: ^4.8.0
json_serializable: ^6.7.0

# Local Storage
shared_preferences: ^2.2.0
flutter_secure_storage: ^9.0.0
```

### UI Enhancement
```yaml
# Images
cached_network_image: ^3.3.0

# Loading
shimmer: ^3.0.0

# Icons
flutter_svg: ^2.0.0

# Date/Time
intl: ^0.18.0
```

### Development
```yaml
dev_dependencies:
  build_runner: ^2.4.0
  flutter_lints: ^3.0.0
```

---

## 🎯 Coding Standards

### File Naming
- ✅ `snake_case.dart` for files
- ✅ `PascalCase` for classes
- ✅ `camelCase` for variables/functions

### Widget Organization
```dart
class MyWidget extends StatelessWidget {
  // 1. Constructor
  const MyWidget({super.key});
  
  // 2. Build method
  @override
  Widget build(BuildContext context) {
    return Container();
  }
  
  // 3. Helper methods
  void _helperMethod() {}
}
```

### Import Order
```dart
// 1. Dart imports
import 'dart:async';

// 2. Flutter imports
import 'package:flutter/material.dart';

// 3. Package imports
import 'package:provider/provider.dart';

// 4. Project imports
import '../widgets/custom_button.dart';
```

---

## 🔧 Useful Commands

```bash
# Get dependencies
flutter pub get

# Run app
flutter run

# Build APK
flutter build apk --release

# Build iOS
flutter build ios --release

# Clean project
flutter clean

# Generate code (for json_serializable)
flutter pub run build_runner build --delete-conflicting-outputs

# Analyze code
flutter analyze

# Format code
dart format .
```

---

## 📝 Git Workflow

```bash
# Feature branch
git checkout -b feature/auth-login

# Commit
git add .
git commit -m "feat: implement login screen"

# Push
git push origin feature/auth-login
```

### Commit Message Convention
```
feat: new feature
fix: bug fix
docs: documentation
style: formatting
refactor: code restructuring
test: adding tests
chore: maintenance
```

---

## 🎓 Learning Resources

- [Flutter Documentation](https://flutter.dev/docs)
- [Clean Architecture](https://blog.cleancoder.com/uncle-bob/2012/08/13/the-clean-architecture.html)
- [Flutter Best Practices](https://flutter.dev/docs/development/ui/layout/best-practices)

---

**Happy Coding! 🚀**

*Last Updated: May 9, 2026*
