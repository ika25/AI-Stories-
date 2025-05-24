import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

class StoryScreen extends StatefulWidget {
  @override
  _StoryScreenState createState() => _StoryScreenState();
}

class _StoryScreenState extends State<StoryScreen> {
  final FlutterTts flutterTts = FlutterTts();
  String storyText = "";
  bool isPlaying = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // Get the arguments from previous screen
    final args = ModalRoute.of(context)!.settings.arguments as Map;
    final name = args['name'];
    final thing = args['thing'];

    // Mock story for now
    storyText =
        "Once upon a time, a brave child named $name found a magical $thing in their backyard. "
        "This wasn't just any $thing – it could talk and fly! Together, they went on amazing adventures, "
        "helping people and learning important lessons about kindness, courage, and friendship. "
        "And every night, the $thing would sing a lullaby to help $name sleep peacefully. The end.";
  }

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
      body: Padding(
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
// This code defines a StoryScreen widget that displays a generated story based on user input from the HomeScreen.
// It uses the FlutterTts package to read the story aloud. The story is constructed using the child's name and favorite thing passed from the previous screen.