# Flutter Theme System Guide

This guide explains our project's theming system and how to use it consistently across the application.

## Overview

Our theming system consists of four key components:

1. **Theme.dart** - Defines light and dark themes
2. **theme_extensions.dart** - Provides shorter syntax for accessing theme properties
3. **constants.dart** - Contains app-wide styling constants
4. **Usage in widgets** - How to apply themes and constants in your UI

## 1. Theme Definition (Theme.dart)

`Theme.dart` contains our application's theme definitions, including colors, text styles, and component styling.

### How it works

We define two themes: `lightTheme` and `darkTheme`, each with specific color schemes and styling.

```dart
class AppTheme {
  // Light theme definition
  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    // Colors, text styles, component themes...
  );

  // Dark theme definition
  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    // Colors, text styles, component themes...
  );
}
```

### Key Themed Elements

- **ColorScheme** - Core color palette
- **TextTheme** - Text styles for various purposes
- **CardTheme** - Card styling
- **ButtonTheme** - Button styling

### Adding New Theme Elements

To add new styled elements to the theme:

1. Find the appropriate theme property in the `ThemeData` class
2. Add it to both `lightTheme` and `darkTheme` with appropriate values

**Example: Adding a new chip theme**

```dart
// Light theme
static final ThemeData lightTheme = ThemeData(
  // Existing theme properties...
  
  // Add chip theme
  chipTheme: ChipThemeData(
    backgroundColor: Colors.grey[200],
    labelStyle: TextStyle(color: Colors.black87),
    padding: AppConstants.kPaddingSmall,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(AppConstants.kRadiusSmall),
    ),
  ),
);

// Dark theme
static final ThemeData darkTheme = ThemeData(
  // Existing theme properties...
  
  // Add chip theme
  chipTheme: ChipThemeData(
    backgroundColor: Colors.grey[800],
    labelStyle: TextStyle(color: Colors.white70),
    padding: AppConstants.kPaddingSmall,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(AppConstants.kRadiusSmall),
    ),
  ),
);
```

## 2. Theme Extensions (theme_extensions.dart)

Theme extensions provide a shorter, more convenient way to access theme properties throughout your app.

### How it works

The extension adds properties to the `BuildContext` for accessing theme data:

```dart
extension ThemeExtension on BuildContext {
  ThemeData get theme => Theme.of(this);
  TextTheme get textTheme => Theme.of(this).textTheme;
  ColorScheme get colorScheme => Theme.of(this).colorScheme;
}
```

### Usage

Traditional way:
```dart
Text('Hello', style: Theme.of(context).textTheme.titleLarge);
```

With extension:
```dart
Text('Hello', style: context.textTheme.titleLarge);
```

### Adding New Extensions

You can extend the `ThemeExtension` class to add more shortcuts:

```dart
extension ThemeExtension on BuildContext {
  // Existing extensions...
  
  // Add new extension for card theme
  CardTheme get cardTheme => Theme.of(this).cardTheme;
  
  // Add extension for button theme
  ButtonThemeData get buttonTheme => Theme.of(this).buttonTheme;
  
  // Add direct access to common colors
  Color get primaryColor => Theme.of(this).colorScheme.primary;
  Color get backgroundColor => Theme.of(this).colorScheme.background;
}
```

## 3. Constants (constants.dart)

The `constants.dart` file contains app-wide styling constants that don't change between light and dark themes.

### What's included

- Spacing values
- Border radius values
- Standard widget dimensions
- Standard paddings
- Animation durations

### How to use constants

```dart
// Adding spacing between widgets
SizedBox(height: AppConstants.kSpacingMedium)

// Setting border radius
Container(
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(AppConstants.kRadiusMedium)
  )
)

// Using standard padding
Padding(
  padding: AppConstants.kPaddingMedium,
  child: YourWidget(),
)
```

### Adding New Constants

To add new constants, simply add them to the `AppConstants` class:

```dart
// Add constants for avatar sizes
static const double kAvatarSizeSmall = 32.0;
static const double kAvatarSizeMedium = 48.0;
static const double kAvatarSizeLarge = 64.0;

// Add constants for text field heights
static const double kTextFieldHeight = 56.0;
```

## 4. Using the Theme System

### Setting up the theme

In your `main.dart`, configure the app to use the themes:

```dart
MaterialApp(
  theme: AppTheme.lightTheme,
  darkTheme: AppTheme.darkTheme,
  themeMode: _isDarkMode ? ThemeMode.dark : ThemeMode.light,
  // ...
)
```

### Using text styles

```dart
// Using a title text style
Text(
  'Page Title',
  style: context.textTheme.titleLarge,
)

// Using a body text style
Text(
  'This is the body content',
  style: context.textTheme.bodyMedium,
)
```

### Using themed components

Cards automatically use the theme:

```dart
Card(
  // No need to specify elevation or border radius - it comes from theme
  child: Padding(
    padding: AppConstants.kPaddingMedium,
    child: Text('Card content', style: context.textTheme.bodyMedium),
  ),
)
```

Buttons automatically use the theme:

```dart
ElevatedButton(
  onPressed: () {},
  // Button already uses theme colors and styling
  child: Text('Click Me'),
)
```

### Consistent spacing and sizing

```dart
Column(
  children: [
    Text('First item'),
    SizedBox(height: AppConstants.kSpacingMedium),
    Text('Second item'),
    SizedBox(height: AppConstants.kSpacingMedium),
    SizedBox(
      width: double.infinity,
      height: AppConstants.kButtonHeight,
      child: ElevatedButton(
        onPressed: () {},
        child: Text('Full Width Button'),
      ),
    ),
  ],
)
```

## Complete Example

Here's a complete example showing how all elements work together:

```dart
class MyProfileWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: AppConstants.kCardWidth,
      child: Card(
        // Card uses theme-defined elevation and border radius
        child: Padding(
          padding: AppConstants.kPaddingMedium,
          child: Column(
            children: [
              // Title text with theme-defined style
              Text(
                'User Profile',
                style: context.textTheme.titleLarge, 
                // This will be yellow in light mode, green in dark mode
              ),
              SizedBox(height: AppConstants.kSpacingMedium),
              
              // Body text with theme-defined style
              Text(
                'Edit your personal information below',
                style: context.textTheme.bodyLarge,
              ),
              SizedBox(height: AppConstants.kSpacingLarge),
              
              // Themed button with consistent height
              SizedBox(
                height: AppConstants.kButtonHeight,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {},
                  // Button already uses theme colors and shape
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.edit, size: AppConstants.kIconSize),
                      SizedBox(width: AppConstants.kSpacingSmall),
                      Text('Edit Profile'),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
```

## Best Practices

1. **Always use theme styles for text** - Don't hardcode text styles
2. **Use constants for spacing** - For consistent layout across the app
3. **Let components use theme by default** - Many components like Button, Card, etc. will use the theme automatically
4. **Keep light and dark themes in sync** - Every style in the light theme should have a corresponding style in the dark theme
5. **Use the theme extensions** for cleaner code
6. **When adding new UI elements**, consider if they should be part of the theme

By following this guide, you'll help maintain a consistent look and feel throughout our application, while making it easy to update the design system in the future.