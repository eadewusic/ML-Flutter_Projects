import 'package:flutter/material.dart'; // Importing the Material Design package for Flutter.
import 'screens/user_input.dart'; // Importing the User Input screen.

void main() {
  runApp(
      const MyApp()); // Entry point of the application, runs the MyApp widget.
}

class MyApp extends StatelessWidget {
  const MyApp(
      {super.key}); // Constructor for MyApp, allowing optional key parameter.

  @override
  Widget build(BuildContext context) {
    // Building the widget tree for the app.
    return MaterialApp(
      title: 'Carbon Footprint Calculator', // Title of the application.
      theme: ThemeData(
        primarySwatch:
            Colors.green, // Setting the primary color theme to green.
        scaffoldBackgroundColor:
            Colors.white, // Setting the background color for the scaffold.
      ),
      home:
          const DailyHabitsScreen(), // Setting the default screen to DailyHabitsScreen.
    );
  }
}
