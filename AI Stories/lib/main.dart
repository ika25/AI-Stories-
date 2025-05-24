import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'screens/story_screen.dart';
import 'screens/library_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Story Maker',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.deepPurple),
      initialRoute: '/',
      routes: {
        '/': (context) => HomeScreen(),
        '/story': (context) => StoryScreen(),
        '/library': (context) => LibraryScreen(),
      },
    );
  }
}
// This is the main entry point of the Flutter application.
// It sets up the MaterialApp with routes for the home screen, story screen, and library screen.