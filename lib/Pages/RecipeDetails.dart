import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

import '../Recipe.dart';

class RecipeDetailsPage extends StatefulWidget {
  final String imageUrl;
  final String title;
  final String ingredients;
  final String instructions;

  RecipeDetailsPage({
    required this.imageUrl,
    required this.title,
    required this.ingredients,
    required this.instructions,
  });
  @override
  State<RecipeDetailsPage> createState() => _RecipeDetailsPageState(imageUrl,title,ingredients,instructions);
}
class _RecipeDetailsPageState extends State<RecipeDetailsPage>{
  final String imageUrl;
  final String title;
  final String ingredients;
  final String instructions;
  final FlutterTts flutterTts = FlutterTts();

  Future<void> speakRecipe() async {
    await flutterTts.setLanguage("en-US");
    await flutterTts.setPitch(1.0);
    await flutterTts.setSpeechRate(1.0);
    await flutterTts.speak("${title}. ${ingredients}. ${instructions}");
  }

  _RecipeDetailsPageState(this.imageUrl,this.title,this.instructions,this.ingredients);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Recipe Details'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(child: Image.network(imageUrl)),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Ingredients:',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(ingredients),
                  SizedBox(height: 16),
                  Text(
                    'Instructions:',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(instructions),
                ],
              ),
            ),
            IconButton(
              icon: Icon(Icons.speaker),
              onPressed: () {
                speakRecipe();
                // Handle speaker button press here
                // You can add text-to-speech functionality or any other action.
              },
            ),
          ],
        ),
      ),
    );
  }

}
