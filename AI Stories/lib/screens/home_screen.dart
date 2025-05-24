import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  final nameController = TextEditingController();
  final favoriteThingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Create a Story")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: "Child's Name"),
            ),
            TextField(
              controller: favoriteThingController,
              decoration: InputDecoration(labelText: "Favorite Animal/Object"),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  '/story',
                  arguments: {
                    'name': nameController.text,
                    'thing': favoriteThingController.text,
                  },
                );
              },
              child: Text("Generate Story"),
            )
          ],
        ),
      ),
    );
  }
}
// This code defines a simple home screen for a Flutter app where users can input a child's name and their favorite thing to generate a story.
// It uses a TextField for input and a button to navigate to the story screen with the provided inputs as arguments.
