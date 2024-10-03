import 'package:flutter/material.dart';
import 'package:hamro_smart_life/view/main_screen.dart';
import 'package:hamro_smart_life/view/screens/compound_interest/compound_interest_screen.dart';
import 'package:hamro_smart_life/view/screens/game/component/snake_game.dart';
import 'package:hamro_smart_life/view/screens/game/component/word_matching_game.dart';
import 'package:hamro_smart_life/view/screens/game/main_game_screen.dart';
import 'package:hamro_smart_life/view/screens/quiz/quiz_list_screen.dart';
import 'package:hamro_smart_life/view/screens/quiz/quiz_screen.dart';
import 'package:hamro_smart_life/view/screens/simple_interest/simple_interest_screen.dart';
import 'package:hamro_smart_life/view/screens/todo/todo_screen.dart';

class AppRoutes {
  static Route<dynamic>? onGeneratedRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case "/main_screen":
        return MaterialPageRoute(builder: (context) => const MainScreen());
      case "/quiz_screen":
        return MaterialPageRoute(builder: (context) => const QuizScreen());
      case "/simple_interest":
        return MaterialPageRoute(
            builder: (context) => const SimpleInterestScreen());
      case "/compound_interest":
        return MaterialPageRoute(
            builder: (context) => const CompoundInterestScreen());
      case "/todo_screen":
        return MaterialPageRoute(builder: (context) => const TodoScreen());
      case "/game_screen":
        return MaterialPageRoute(builder: (context) => GameMainScreen());
      case "/word_match_game_screen":
        return MaterialPageRoute(builder: (context) => WordMatchingScreen());
      case "/snack_game_screen":
        return MaterialPageRoute(builder: (context) => SnakeGame());
      case "/quiz_list":
        Map<String, dynamic> args =
            routeSettings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
            builder: (context) => QuizListScreen(
                  quizCatId: args['quizCatId'],
                  quizCatName: args['quizCatName'],
                ));
      default:
        return null;
    }
  }
}
