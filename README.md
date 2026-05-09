# 🏋️ Movana - Fitness Studio Booking App

একটি modern এবং feature-rich fitness studio booking application যা Flutter দিয়ে তৈরি।

## 📱 Features

- 🔐 Complete Authentication Flow (Login, Sign Up, Password Reset)
- 🎯 Onboarding Experience
- 🏠 Home Dashboard
- 🔍 Studio & Class Search
- 📅 Booking Management
- ❤️ Favorites
- 👤 User Profile
- 🏢 Studio Details
- 🎓 Class Details
- 📝 Reservation System

## 🚀 Quick Start

### Prerequisites

- Flutter SDK (latest stable version)
- Dart SDK
- Android Studio / VS Code
- iOS Simulator / Android Emulator

### Installation

```bash
# Clone the repository
git clone <your-repo-url>

# Navigate to project directory
cd movana

# Install dependencies
flutter pub get

# Run the app
flutter run
```

## 📁 Project Structure

এই প্রজেক্ট **Clean Architecture** এবং **Feature-First** approach অনুসরণ করে।

```
lib/
├── core/              # Core functionality (theme, constants, utils)
├── features/          # Feature modules (auth, home, search, etc.)
├── routes/            # Navigation configuration
├── shared/            # Shared widgets and utilities
└── main.dart          # App entry point
```

### 📊 Statistics

- **Total Screens**: 18
- **Features**: 8
- **Shared Widgets**: 5
- **Routes**: 18

## 📚 Documentation

বিস্তারিত documentation এর জন্য নিচের ফাইলগুলো দেখুন:

- 📄 [STRUCTURE_TREE.txt](STRUCTURE_TREE.txt) - Visual tree structure
- 📄 [README_STRUCTURE.md](README_STRUCTURE.md) - Basic structure overview
- 📄 [FOLDER_STRUCTURE_GUIDE.md](FOLDER_STRUCTURE_GUIDE.md) - Detailed guide
- 📄 [QUICK_START.md](QUICK_START.md) - Quick start with examples
- 📄 [PROJECT_SUMMARY.md](PROJECT_SUMMARY.md) - Complete summary

## 🎯 Architecture

**Clean Architecture + Feature-First**

```
Presentation Layer (UI)
        ↓
Domain Layer (Business Logic)
        ↓
Data Layer (API/Database)
```

## 🎨 Design System

- ✅ Consistent color palette
- ✅ Typography system
- ✅ Reusable components
- ✅ Theme configuration
- ✅ Custom widgets

## 🔧 Tech Stack

- **Framework**: Flutter
- **Language**: Dart
- **Architecture**: Clean Architecture
- **State Management**: (To be added)
- **Navigation**: Named Routes
- **UI**: Material Design

## 📱 Screens

### Authentication (10 screens)
1. Splash Screen
2. Onboarding (3 screens)
3. Login
4. Sign Up
5. Forgot Password
6. Verification
7. Reset Password
8. Reset Password Success

### Main App (5 screens)
9. Home
10. Search
11. Bookings
12. Favorites
13. Profile

### Details (3 screens)
14. Studio Details
15. Class Details
16. Reservation

## 🚀 Development

### Run the app

```bash
flutter run
```

### Build for production

```bash
# Android
flutter build apk --release

# iOS
flutter build ios --release
```

### Code formatting

```bash
dart format .
```

### Code analysis

```bash
flutter analyze
```

## 📦 Next Steps

- [ ] Add State Management (Provider/Riverpod/Bloc)
- [ ] Implement API Integration
- [ ] Add Data Layer
- [ ] Add Domain Layer
- [ ] Setup Local Storage
- [ ] Add Assets
- [ ] Implement UI Designs
- [ ] Add Tests

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## 📄 License

This project is licensed under the MIT License.

## 👨‍💻 Author

Your Name

## 🙏 Acknowledgments

- Flutter Team
- Material Design
- Community Contributors

---

**Happy Coding! 🎉**
