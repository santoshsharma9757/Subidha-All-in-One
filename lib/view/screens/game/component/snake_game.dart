import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hamro_smart_life/utils/widgets/reusable_appbar.dart';

class SnakeGame extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const ReusableAppBar(
        title: "Snack game",
        centerTitle: true,
      ),
      body: SnakeGameScreen(),
    );
  }
}

class SnakeGameScreen extends StatefulWidget {
  @override
  _SnakeGameScreenState createState() => _SnakeGameScreenState();
}

class _SnakeGameScreenState extends State<SnakeGameScreen> {
  static const int rows = 20;
  static const int columns = 20;
  final randomGen = Random();
  List<Point<int>> snake = [Point<int>(0, 1), Point<int>(0, 0)];
  Point<int> food = Point<int>(5, 5);
  String direction = 'up';
  Timer? timer;
  int score = 0;
  bool isGameOver = false;

  @override
  void initState() {
    super.initState();
    startGame();
  }

  void startGame() {
    snake = [Point<int>(0, 1), Point<int>(0, 0)];
    direction = 'up';
    score = 0;
    isGameOver = false;
    spawnFood();
    timer?.cancel();
    timer = Timer.periodic(Duration(milliseconds: 300), (Timer timer) {
      if (isGameOver) {
        timer.cancel();
      } else {
        setState(() {
          moveSnake();
          if (checkCollision()) {
            setState(() {
              isGameOver = true;
            });
            showGameOverScreen();
          }
        });
      }
    });
  }

  void spawnFood() {
    food = Point<int>(randomGen.nextInt(columns), randomGen.nextInt(rows));
  }

  void moveSnake() {
    Point<int> newHead;

    switch (direction) {
      case 'up':
        newHead = Point<int>(snake.first.x, snake.first.y - 1);
        break;
      case 'down':
        newHead = Point<int>(snake.first.x, snake.first.y + 1);
        break;
      case 'left':
        newHead = Point<int>(snake.first.x - 1, snake.first.y);
        break;
      case 'right':
        newHead = Point<int>(snake.first.x + 1, snake.first.y);
        break;
      default:
        newHead = snake.first;
    }

    snake.insert(0, newHead);

    if (newHead == food) {
      score += 10;
      spawnFood();
    } else {
      snake.removeLast();
    }
  }

  bool checkCollision() {
    // Check for collisions with the walls
    if (snake.first.x < 0 ||
        snake.first.y < 0 ||
        snake.first.x >= columns ||
        snake.first.y >= rows) {
      return true;
    }

    // Check for collisions with itself
    for (int i = 1; i < snake.length; i++) {
      if (snake[i] == snake.first) {
        return true;
      }
    }

    return false;
  }

  void showGameOverScreen() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Game Over'),
        content: Text('Your score: $score'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              startGame();
            },
            child: Text('Play Again'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onVerticalDragUpdate: (details) {
        if (details.primaryDelta != null) {
          if (direction != 'up' && details.primaryDelta! > 0) {
            direction = 'down';
          } else if (direction != 'down' && details.primaryDelta! < 0) {
            direction = 'up';
          }
        }
      },
      onHorizontalDragUpdate: (details) {
        if (details.primaryDelta != null) {
          if (direction != 'left' && details.primaryDelta! > 0) {
            direction = 'right';
          } else if (direction != 'right' && details.primaryDelta! < 0) {
            direction = 'left';
          }
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Stack(
          children: [
            Container(
              color: Colors.green[100],
              child: GridView.builder(
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: columns,
                ),
                itemCount: rows * columns,
                itemBuilder: (context, index) {
                  final x = index % columns;
                  final y = (index / columns).floor();

                  Point<int> point = Point<int>(x, y);
                  bool isSnakeBody = snake.contains(point);
                  bool isFood = point == food;

                  return Container(
                    margin: EdgeInsets.all(1.0),
                    decoration: BoxDecoration(
                      color: isSnakeBody
                          ? Colors.green[700]
                          : isFood
                              ? Colors.red
                              : Colors.green[200],
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                  );
                },
              ),
            ),
            if (isGameOver)
              Center(
                child: Text(
                  'Game Over',
                  style: TextStyle(
                    fontSize: 36,
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            Positioned(
              top: 10,
              left: 10,
              child: Text(
                'Score: $score',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }
}
