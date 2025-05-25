import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_tts/flutter_tts.dart';

class StoryScreen extends StatefulWidget {
  @override
  _StoryScreenState createState() => _StoryScreenState();
}

class _StoryScreenState extends State<StoryScreen> {
  final FlutterTts flutterTts = FlutterTts();

  String storyText = "";
  bool isLoading = true;
  bool isPlaying = false;

  // Call API when widget loads
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final args = ModalRoute.of(context)!.settings.arguments as Map;
    final name = args['name'];
    final thing = args['thing'];

    fetchStory(name, thing);
  }

  // Function to call your FastAPI backend
  Future<void> fetchStory(String name, String thing) async {
    final url = Uri.parse("http://10.0.2.2:8000/generate_story");

    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"name": name, "thing": thing}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          storyText = data['story'];
          isLoading = false;
        });
      } else {
        setState(() {
          storyText = "Failed to load story.";
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        storyText = "Error occurred: $e";
        isLoading = false;
      });
    }
  }

  // Text-to-speech function
  Future<void> _speak() async {
    await flutterTts.setLanguage("en-US");
    await flutterTts.setPitch(1.2);
    await flutterTts.setSpeechRate(0.45);
    await flutterTts.speak(storyText);
    setState(() => isPlaying = true);
  }

  Future<void> _stop() async {
    await flutterTts.stop();
    setState(() => isPlaying = false);
  }

  @override
  void dispose() {
    flutterTts.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Your Story")),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Text(
                        storyText,
                        style: TextStyle(fontSize: 18, height: 1.5),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton.icon(
                    icon: Icon(isPlaying ? Icons.stop : Icons.play_arrow),
                    label: Text(isPlaying ? "Stop Narration" : "Play Story"),
                    onPressed: isPlaying ? _stop : _speak,
                  )
                ],
              ),
            ),
    );
  }
}
// This code defines a StoryScreen widget that fetches a story from a FastAPI backend based on user input from the HomeScreen.
// It uses the FlutterTts package to read the story aloud. The story is constructed using the child's name and favorite thing passed from the previous screen.  
// This code defines a StoryScreen widget that displays a generated story based on user input from the HomeScreen.
// It uses the FlutterTts package to read the story aloud. The story is constructed using the child's name and favorite thing passed from the previous screen.