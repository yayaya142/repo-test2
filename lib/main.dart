// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'theme.dart'; // Import our theme definitions
import 'theme_extensions.dart'; // Import our theme extensions
import 'constants.dart'; // Import our constants

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // Track if we're using dark mode
  bool _isDarkMode = false;

  // Toggle between light and dark themes
  void _toggleTheme() {
    setState(() {
      _isDarkMode = !_isDarkMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Theme Demo',
      // Use the appropriate theme based on _isDarkMode
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: _isDarkMode ? ThemeMode.dark : ThemeMode.light,
      home: MyHomePage(
        title: 'Flutter Theme Demo',
        toggleTheme: _toggleTheme,
        isDarkMode: _isDarkMode,
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    super.key,
    required this.title,
    required this.toggleTheme,
    required this.isDarkMode,
  });

  final String title;
  final VoidCallback toggleTheme;
  final bool isDarkMode;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This shows how to use our theme with the shorter syntax
    return Scaffold(
      appBar: AppBar(
        backgroundColor: context.colorScheme.inversePrimary,
        title: Text(widget.title),
        actions: [
          // Theme toggle button
          IconButton(
            icon: Icon(
              widget.isDarkMode ? Icons.light_mode : Icons.dark_mode,
              size: AppConstants.kIconSize,
            ),
            onPressed: widget.toggleTheme,
            tooltip: 'Toggle theme',
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Example 1: Using titleLarge style with extension syntax
            // This will be yellow in light mode and green in dark mode
            Text(
              'This is a Title (titleLarge)',
              style: context.textTheme.titleLarge,
            ),
            SizedBox(height: AppConstants.kSpacingMedium),

            // Example 2: Using titleMedium style
            Text(
              'This is a Subtitle (titleMedium)',
              style: context.textTheme.titleMedium,
            ),
            SizedBox(height: AppConstants.kSpacingMedium),

            // Example 3: Using bodyLarge style
            Text(
              'This is body text (bodyLarge)',
              style: context.textTheme.bodyLarge,
            ),
            SizedBox(height: AppConstants.kSpacingMedium),

            // Counter example
            Text(
              'You have pushed the button this many times:',
              style: context.textTheme.bodyMedium,
            ),
            Text(
              '$_counter',
              style: context.textTheme.headlineMedium,
            ),
            SizedBox(height: AppConstants.kSpacingLarge),

            // Example of using a themed card with constants
            Container(
              width: AppConstants.kCardWidth,
              margin: AppConstants.kPaddingMedium,
              child: Card(
                // Card already uses themed elevation and border radius from Theme.dart
                child: Padding(
                  padding: AppConstants.kPaddingMedium,
                  child: Column(
                    children: [
                      Text(
                        'Themed Card',
                        style: context.textTheme.titleMedium,
                      ),
                      SizedBox(height: AppConstants.kSpacingSmall),
                      Text(
                        'This card uses theme styling with constants',
                        style: context.textTheme.bodyMedium,
                      ),
                      SizedBox(height: AppConstants.kSpacingMedium),
                      // Example button that will use the themed button style
                      SizedBox(
                        height: AppConstants.kButtonHeight,
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: _incrementCounter,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.add, size: AppConstants.kIconSize),
                              SizedBox(width: AppConstants.kSpacingSmall),
                              Text('Increment'),
                            ],
                          ),
                        ),
                      ),
                      // Smaller button example
                      SizedBox(height: AppConstants.kSpacingSmall),
                      SizedBox(
                        height: AppConstants.kSmallButtonHeight,
                        child: ElevatedButton(
                          onPressed: () {},
                          child: Text('Small Button'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(
          Icons.add,
          size: AppConstants.kIconSize,
        ),
      ),
    );
  }
}
