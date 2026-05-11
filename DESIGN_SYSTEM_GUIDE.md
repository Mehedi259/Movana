# Movana Design System Guide

এই ডকুমেন্টে Figma ডিজাইন থেকে নেওয়া ডিজাইন প্যাটার্ন এবং কনসিস্টেন্সি গাইডলাইন রয়েছে।

## Color Palette

### Primary Colors
- **Primary Green**: `#009955` - Main brand color
- **Primary Dark**: `#0B2D1E` - Darker shade for gradients
- **Secondary**: `#03DAC6` - Accent color

### Background Colors
- **Background**: `#F8FAFC` - Main app background
- **Surface**: `#FFFFFF` - Card and container background
- **Surface Light**: `#F0FDF4` - Success/credit banner background

### Text Colors
- **Text Primary**: `#0F172A` - Main headings
- **Text Dark**: `#002212` - Important text
- **Text Secondary**: `#64748B` - Secondary text
- **Text Tertiary**: `#94A3B8` - Placeholder and hints

### Border Colors
- **Border**: `#E2E8F0` - Main borders
- **Border Light**: `#BFC9C1` - Lighter borders

### Success/Credit Colors
- **Success Background**: `#F0FDF4`
- **Success Light**: `#D9E6DA`
- **Success Text**: `#5B675E`

### Gradients
```dart
LinearGradient(
  begin: Alignment(0.00, 0.00),
  end: Alignment(1.00, 1.00),
  colors: [Color(0xFF0B2D1E), Color(0xFF009955)],
)
```

## Typography

### Font Families
- **Primary**: Inter (default for most text)
- **Secondary**: Lexend (for recommended items)
- **Navigation**: Poppins (for bottom navigation)

### Font Sizes & Weights
- **Large Heading**: 20px, Bold (700)
- **Section Heading**: 16px, Bold (700)
- **Body Text**: 14px, Regular (400)
- **Small Text**: 12px, Medium (500-600)
- **Tiny Text**: 10px, Regular (400)

## Spacing System

### Padding
- **Container Padding**: 20px horizontal
- **Card Padding**: 12px
- **Button Padding**: 8-14px horizontal, 5-6px vertical
- **Section Spacing**: 24px between sections
- **Item Spacing**: 12px between items
- **Small Spacing**: 8px

### Border Radius
- **Large Cards**: 20px
- **Medium Cards**: 12-16px
- **Small Cards**: 8px
- **Buttons**: 8-10px
- **Chips**: 4px
- **Navigation**: 32px

## Component Patterns

### Cards
```dart
Container(
  decoration: BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(12),
    boxShadow: [
      BoxShadow(
        color: Color(0x11000000),
        blurRadius: 12,
        offset: Offset(0, 2),
        spreadRadius: 0,
      ),
    ],
  ),
)
```

### Gradient Buttons
```dart
Container(
  decoration: BoxDecoration(
    gradient: LinearGradient(
      colors: [Color(0xFF0B2D1E), Color(0xFF009955)],
    ),
    borderRadius: BorderRadius.circular(8),
  ),
)
```

### Category Chips
```dart
Container(
  width: 82,
  padding: EdgeInsets.symmetric(horizontal: 14, vertical: 12),
  decoration: BoxDecoration(
    color: Colors.white,
    border: Border.all(width: 1, color: Color(0xFFE2E8F0)),
    borderRadius: BorderRadius.circular(16),
  ),
)
```

### Credit Badges
```dart
Container(
  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
  decoration: BoxDecoration(
    color: Color(0xFFD9E6DA),
    borderRadius: BorderRadius.circular(4),
  ),
  child: Text('⚡2 cr'),
)
```

## Layout Guidelines

### Responsive Design
- সব width fixed না রেখে `double.infinity` বা responsive units ব্যবহার করা হয়েছে
- Horizontal scrolling এর জন্য `SingleChildScrollView` ব্যবহার
- Flexible spacing এর জন্য `Spacer()` এবং `MainAxisAlignment.spaceBetween`

### Screen Structure
1. **SafeArea** - Status bar এর নিচে content
2. **SingleChildScrollView** - Vertical scrolling
3. **Padding** - 20px horizontal padding
4. **Sections** - 24px spacing between sections

### Bottom Navigation
- Floating style with rounded corners (32px)
- Active state: Light gray background (#DFDFDF)
- Shadow effect on active items
- Icon + Label layout

## Usage Examples

### Section Header
```dart
Row(
  mainAxisAlignment: MainAxisAlignment.spaceBetween,
  children: [
    Text(
      'Section Title',
      style: TextStyle(
        color: AppColors.textPrimary,
        fontSize: 16,
        fontWeight: FontWeight.w700,
      ),
    ),
    Text(
      'See all',
      style: TextStyle(
        color: AppColors.textDark,
        fontSize: 12,
        fontWeight: FontWeight.w500,
        decoration: TextDecoration.underline,
      ),
    ),
  ],
)
```

### Promo Banner
```dart
Container(
  height: 140,
  decoration: BoxDecoration(
    gradient: AppColors.primaryGradient,
    borderRadius: BorderRadius.circular(20),
  ),
  child: Padding(
    padding: EdgeInsets.all(20),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Badge
        // Title
        // Description
        // CTA Button
      ],
    ),
  ),
)
```

## Best Practices

1. **Consistency**: সব screen এ same color palette এবং spacing ব্যবহার করো
2. **Responsive**: Fixed width এর বদলে flexible layout ব্যবহার করো
3. **Shadows**: Subtle shadows (0x0F000000 - 0x11000000) ব্যবহার করো
4. **Border Radius**: Component size অনুযায়ী appropriate radius ব্যবহার করো
5. **Typography**: Proper font weight এবং size hierarchy maintain করো
6. **Spacing**: Consistent spacing system follow করো
7. **Colors**: AppColors class থেকে colors ব্যবহার করো, hardcoded colors avoid করো

## Files Updated

1. **lib/core/constants/app_colors.dart** - Updated with Figma colors
2. **lib/core/theme/app_theme.dart** - Updated theme with new colors
3. **lib/features/home/presentation/screens/home_screen.dart** - Redesigned home screen

## Next Steps

বাকি screens গুলোতে এই same design pattern apply করতে হবে:
- Search Screen
- Studio Details Screen
- Class Details Screen
- Bookings Screen
- Favorites Screen
- Profile Screen

প্রতিটি screen এ:
- Same color palette
- Same typography
- Same spacing system
- Same component styles
- Same bottom navigation (যেখানে applicable)
