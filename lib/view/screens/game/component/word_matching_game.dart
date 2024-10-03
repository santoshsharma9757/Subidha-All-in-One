import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hamro_smart_life/constant/app_constant.dart';
import 'package:hamro_smart_life/constant/app_text_style.dart';
import 'package:hamro_smart_life/utils/widgets/reusable_appbar.dart';

class WordMatchingScreen extends StatefulWidget {
  @override
  _WordMatchingScreenState createState() => _WordMatchingScreenState();
}

class _WordMatchingScreenState extends State<WordMatchingScreen> {
  int currentLevel = 1;
  String? word;
  List<String>? shuffledWord;
  List<String>? originalWord;

  final List<String> words = [
    // Vegetables
    'TOMATO',
    'CARROT',
    'POTATO',
    'CUCUMBER',
    'SPINACH',

    // Fruits
    'APPLE',
    'BANANA',
    'ORANGE',
    'GRAPES',
    'MANGO',

    // Study-related
    'BOOK',
    'PENCIL',
    'SCHOOL',
    'TEACHER',
    'STUDENT'
  ];

  @override
  void initState() {
    super.initState();
    generateNewLevel();
  }

  void generateNewLevel() {
    setState(() {
      word = words[Random().nextInt(words.length)].toUpperCase();
      originalWord = word!.split('');
      shuffledWord = List<String>.from(originalWord!)..shuffle();
    });
  }

  Color generateRandomColorWithOpacity() {
    final random = Random();
    Color baseColor = Colors.primaries[random.nextInt(Colors.primaries.length)];
    return baseColor.withOpacity(0.5); // Random opacity between 0.0 and 1.0
  }

  @override
  Widget build(BuildContext context) {
    int gridSize = getGridSize();
    int rows = gridSize;
    int columns = (shuffledWord!.length / rows).ceil();

    return Scaffold(
      appBar: const ReusableAppBar(
        title: "Word matching game",
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          AppSpacing.verticalLarge,
          AppSpacing.verticalLarge,
          Text(
            'Level $currentLevel',
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.all(16.0),
            child: GridView.builder(
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: columns,
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
              ),
              itemCount: shuffledWord!.length,
              itemBuilder: (context, index) {
                return Draggable<String>(
                  data: shuffledWord![index],
                  feedback: Material(
                    color: Colors.transparent,
                    child: Text(
                      shuffledWord![index],
                      style: const TextStyle(fontSize: 24, color: Colors.black),
                    ),
                  ),
                  childWhenDragging: Opacity(
                    opacity: 0.5,
                    child: Text(
                      shuffledWord![index],
                      style: const TextStyle(fontSize: 24),
                    ),
                  ),
                  child: DragTarget<String>(
                    onAccept: (receivedLetter) {
                      setState(() {
                        int oldIndex = shuffledWord!.indexOf(receivedLetter);
                        String temp = shuffledWord![index];
                        shuffledWord![index] = receivedLetter;
                        shuffledWord![oldIndex] = temp;
                      });
                    },
                    builder: (context, acceptedLetters, rejectedLetters) {
                      return Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: generateRandomColorWithOpacity(),
                          // border: Border.all(color: Colors.),
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                        child: Text(
                          shuffledWord![index],
                          style: AppTextStyles.heading1,
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              if (shuffledWord!.join('') == originalWord!.join('')) {
                if (currentLevel < 5) {
                  setState(() {
                    currentLevel++;
                    generateNewLevel();
                  });
                  _showResultDialog(
                      context, "Correct! Moving to Level $currentLevel.");
                } else {
                  _showResultDialog(
                      context, "Congratulations! You've completed all levels!");
                }
              } else {
                _showResultDialog(context, "Try Again!");
              }
            },
            child: const Text('Check'),
          ),
        ],
      ),
    );
  }

  int getGridSize() {
    switch (currentLevel) {
      case 1:
        return 2;
      case 2:
        return 2;
      case 3:
        return 3;
      case 4:
        return 3;
      case 5:
        return 4;
      default:
        return 2;
    }
  }

  void _showResultDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}
