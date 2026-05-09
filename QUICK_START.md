# 🚀 Quick Start Guide - Movana

## ⚡ দ্রুত শুরু করুন

### 1️⃣ Dependencies Install করুন

```bash
flutter pub get
```

### 2️⃣ App Run করুন

```bash
flutter run
```

---

## 📱 Screen Navigation Example

### কিভাবে একটি screen থেকে অন্য screen এ যাবেন:

```dart
// Method 1: Using route name
Navigator.pushNamed(context, AppRoutes.home);

// Method 2: Using extension (recommended)
context.pushNamed(AppRoutes.home);

// Method 3: With arguments
Navigator.pushNamed(
  context, 
  AppRoutes.studioDetails,
  arguments: {'studioId': '123'},
);
```

---

## 🎨 কিভাবে একটি নতুন Screen তৈরি করবেন

### Step 1: Screen File তৈরি করুন

```dart
// lib/features/your_feature/presentation/screens/your_screen.dart

import 'package:flutter/material.dart';

class YourScreen extends StatelessWidget {
  const YourScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Screen'),
      ),
      body: const Center(
        child: Text('Your Content Here'),
      ),
    );
  }
}
```

### Step 2: Route যোগ করুন

**`lib/core/constants/app_routes.dart`** এ:
```dart
static const String yourScreen = '/your-screen';
```

**`lib/routes/app_router.dart`** এ:
```dart
import '../features/your_feature/presentation/screens/your_screen.dart';

// generateRoute method এর switch case এ যোগ করুন:
case AppRoutes.yourScreen:
  return MaterialPageRoute(builder: (_) => const YourScreen());
```

---

## 🎨 Shared Widgets ব্যবহার করুন

### Custom Button

```dart
import '../../shared/widgets/custom_button.dart';

CustomButton(
  text: 'Login',
  onPressed: () {
    // Your action
  },
  isLoading: false,
)
```

### Loading Indicator

```dart
import '../../shared/widgets/loading_indicator.dart';

const LoadingIndicator()
```

### Empty State

```dart
import '../../shared/widgets/empty_state.dart';

EmptyState(
  message: 'No bookings found',
  description: 'You haven\'t booked any classes yet',
  icon: Icons.calendar_today,
  actionText: 'Browse Classes',
  onActionPressed: () {
    // Navigate to search
  },
)
```

### Error View

```dart
import '../../shared/widgets/error_view.dart';

ErrorView(
  message: 'Failed to load data',
  onRetry: () {
    // Retry logic
  },
)
```

---

## 🎨 Theme & Colors ব্যবহার

### Colors

```dart
import '../../core/constants/app_colors.dart';

Container(
  color: AppColors.primary,
  child: Text(
    'Hello',
    style: TextStyle(color: AppColors.textPrimary),
  ),
)
```

### Theme

```dart
// Access theme
final theme = Theme.of(context);
final textTheme = theme.textTheme;

// Or using extension
final theme = context.theme;
final textTheme = context.textTheme;

Text(
  'Title',
  style: textTheme.titleLarge,
)
```

---

## 🔧 Form Validation

### Using Validators

```dart
import '../../core/utils/validators.dart';

TextFormField(
  validator: Validators.email,
  decoration: const InputDecoration(
    labelText: 'Email',
  ),
)

// Or custom validation
TextFormField(
  validator: (value) => Validators.required(value, 'Name'),
)
```

---

## 🎯 Extensions ব্যবহার

### String Extensions

```dart
import '../../core/utils/extensions.dart';

String name = 'john';
print(name.capitalize()); // John

String email = 'test@example.com';
print(email.isValidEmail); // true
```

### Context Extensions

```dart
import '../../core/utils/extensions.dart';

// Navigation
context.push(const HomeScreen());
context.pushNamed(AppRoutes.home);
context.pop();

// Screen size
double width = context.screenWidth;
double height = context.screenHeight;

// Show snackbar
context.showSnackBar('Success!');
context.showSnackBar('Error!', isError: true);

// Hide keyboard
context.hideKeyboard();
```

### DateTime Extensions

```dart
import '../../core/utils/extensions.dart';

DateTime now = DateTime.now();
print(now.formattedDate);  // 09/05/2026
print(now.formattedTime);  // 02:30 PM
print(now.isToday);        // true
```

---

## 📝 Complete Screen Example

```dart
import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_routes.dart';
import '../../core/utils/extensions.dart';
import '../../core/utils/validators.dart';
import '../../shared/widgets/custom_button.dart';
import '../../shared/widgets/loading_indicator.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleLogin() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);
      
      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));
      
      if (mounted) {
        setState(() => _isLoading = false);
        context.showSnackBar('Login successful!');
        context.pushReplacementNamed(AppRoutes.home);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: _isLoading
          ? const LoadingIndicator()
          : SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Logo or Image
                    const SizedBox(height: 40),
                    Icon(
                      Icons.fitness_center,
                      size: 80,
                      color: AppColors.primary,
                    ),
                    const SizedBox(height: 40),
                    
                    // Email Field
                    TextFormField(
                      controller: _emailController,
                      validator: Validators.email,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        labelText: 'Email',
                        prefixIcon: Icon(Icons.email),
                      ),
                    ),
                    const SizedBox(height: 16),
                    
                    // Password Field
                    TextFormField(
                      controller: _passwordController,
                      validator: Validators.password,
                      obscureText: true,
                      decoration: const InputDecoration(
                        labelText: 'Password',
                        prefixIcon: Icon(Icons.lock),
                      ),
                    ),
                    const SizedBox(height: 24),
                    
                    // Login Button
                    CustomButton(
                      text: 'Login',
                      onPressed: _handleLogin,
                      isLoading: _isLoading,
                    ),
                    const SizedBox(height: 16),
                    
                    // Forgot Password
                    TextButton(
                      onPressed: () {
                        context.pushNamed(AppRoutes.forgotPassword);
                      },
                      child: const Text('Forgot Password?'),
                    ),
                    
                    // Sign Up
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Don\'t have an account?'),
                        TextButton(
                          onPressed: () {
                            context.pushNamed(AppRoutes.signUp);
                          },
                          child: const Text('Sign Up'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
```

---

## 🎯 Common Patterns

### 1. StatefulWidget with Loading State

```dart
class MyScreen extends StatefulWidget {
  const MyScreen({super.key});

  @override
  State<MyScreen> createState() => _MyScreenState();
}

class _MyScreenState extends State<MyScreen> {
  bool _isLoading = false;
  String? _error;
  List<dynamic> _data = [];

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      // Load data
      await Future.delayed(const Duration(seconds: 2));
      setState(() {
        _data = []; // Your data
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const LoadingIndicator();
    }

    if (_error != null) {
      return ErrorView(
        message: _error!,
        onRetry: _loadData,
      );
    }

    if (_data.isEmpty) {
      return const EmptyState(
        message: 'No data found',
      );
    }

    return ListView.builder(
      itemCount: _data.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(_data[index].toString()),
        );
      },
    );
  }
}
```

### 2. Bottom Navigation

```dart
class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = const [
    HomeScreen(),
    SearchScreen(),
    BookingsScreen(),
    FavoritesScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: 'Bookings',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorites',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
```

---

## 🐛 Debugging Tips

### Print Statements

```dart
print('Debug: $variable');
debugPrint('Debug message');
```

### Check Build Context

```dart
if (mounted) {
  setState(() {
    // Update state
  });
}
```

### Hot Reload vs Hot Restart

- **Hot Reload**: `r` - দ্রুত UI changes দেখার জন্য
- **Hot Restart**: `R` - পুরো app restart করার জন্য

---

## 📚 Additional Resources

- [Flutter Docs](https://flutter.dev/docs)
- [Dart Docs](https://dart.dev/guides)
- [Material Design](https://material.io/design)

---

**এখন আপনি ready! 🎉**

কোন প্রশ্ন থাকলে README_STRUCTURE.md এবং FOLDER_STRUCTURE_GUIDE.md দেখুন।
