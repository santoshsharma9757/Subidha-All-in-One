import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hamro_smart_life/constant/app_constant.dart';
import 'package:hamro_smart_life/constant/app_screen_utils.dart';
import 'package:hamro_smart_life/constant/app_text_style.dart';
import 'package:hamro_smart_life/utils/app_utils.dart';
import 'package:hamro_smart_life/utils/widgets/reusable_container_widget.dart';

class GameMainScreen extends StatefulWidget {
  GameMainScreen({super.key});

  @override
  State<GameMainScreen> createState() => _GameMainScreenState();
}

class _GameMainScreenState extends State<GameMainScreen> {
  List gameTitle = [
    {
      "title": "Word match Game",
      "icon": "assets/gamescreen/word_match.png",
      "slug": "word_game"
    },
    {
      "title": "Snack Game",
      "icon": "assets/gamescreen/snake.png",
      "slug": "snake_game"
    }
  ];

  gameNavigation(String game) {
    log("game value $game");
    switch (game) {
      case "word_game":
        return Navigator.pushNamed(context, "/word_match_game_screen");
      case "snake_game":
        return AppUtils.snackBar("Coming soon", context);
      // return Navigator.pushNamed(context, "/snack_game_screen");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.primary,
          title: const Text('Game'),
        ),
        body: ListView.builder(
            itemCount: gameTitle.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  gameNavigation(gameTitle[index]['slug']);
                },
                child: ReusableContainer(
                    width: AppScreenUtils.screenWidth(context),
                    height: AppScreenUtils.screenHeightPercentage(context, 0.1),
                    color: const Color(0xFFD6E9F7),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          gameTitle[index]['title'],
                          style: AppTextStyles.heading5,
                        ),
                        Image.asset(gameTitle[index]['icon'])
                      ],
                    )),
              );
            }));
  }
}
