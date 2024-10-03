import 'dart:convert';
import 'dart:math';

import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';
import 'package:hamro_smart_life/constant/app_constant.dart';
import 'package:hamro_smart_life/constant/app_screen_utils.dart';
import 'package:hamro_smart_life/constant/app_text_style.dart';
import 'package:hamro_smart_life/view_model/quiz_notifier.dart';
import 'package:provider/provider.dart';

class QuizListScreen extends StatefulWidget {
  final String quizCatId;
  final String quizCatName;
  const QuizListScreen(
      {super.key, required this.quizCatId, required this.quizCatName});

  @override
  State<QuizListScreen> createState() => _QuizListScreenState();
}

class _QuizListScreenState extends State<QuizListScreen> {
  @override
  void initState() {
    final provider = Provider.of<QuizNotifier>(context, listen: false);
    provider.getQuiz(context, widget.quizCatId);
    super.initState();
  }

  Color generateRandomColorWithOpacity() {
    final random = Random();
    Color baseColor = Colors.primaries[random.nextInt(Colors.primaries.length)];
    return baseColor.withOpacity(0.5); // Random opacity between 0.0 and 1.0
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<QuizNotifier>(
          builder: (context, value, child) => value.isLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : _buildContainerSection(context, value)),
    );
  }

  _buildContainerSection(BuildContext context, QuizNotifier value) {
    return Stack(
      children: [
        _buildUI(context, value),
        Positioned(
            top: AppScreenUtils.screenHeightPercentage(context, 0.06),
            left: 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.arrow_back_ios_rounded,
                      color: Colors.white,
                      size: 20,
                    )),
                Padding(
                  padding: const EdgeInsets.only(left: AppPadding.large),
                  child: Text(
                    utf8.decode(latin1.encode(widget.quizCatName)),
                    style: AppTextStyles.heading6,
                  ),
                )
              ],
            )),
      ],
    );
  }

  _buildUI(BuildContext context, QuizNotifier value) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: AppColors.purple,
      child: Padding(
        padding: EdgeInsets.only(
            top: AppScreenUtils.screenHeightPercentage(context, 0.13)),
        child: SafeArea(
          child: Container(
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(17),
                    topRight: Radius.circular(17))),
            child: value.quiz.isEmpty
                ? const Center(child: Text("No Quiz Found"))
                : _buildListview(value),
          ),
        ),
      ),
    );
  }

  _buildListview(QuizNotifier value) {
    return ListView.builder(
        itemCount: value.quiz.length,
        itemBuilder: (context, index) {
          return _buildExpansionTile(index, value);
        });
  }

  _buildExpansionTile(int index, QuizNotifier value) {
    return Padding(
      padding: const EdgeInsets.only(
          left: AppPadding.medium,
          right: AppPadding.medium,
          top: AppPadding.small,
          bottom: AppIconSize.extrasmall),
      child: ExpansionTileCard(
        baseColor: generateRandomColorWithOpacity(),
        leading: CircleAvatar(child: Text('${index + 1}')),
        title: Text(
          utf8.decode(latin1.encode(value.quiz[index]['question'].toString())),
          style: AppTextStyles.heading5,
        ),
        subtitle: const Text(''),
        children: <Widget>[
          const Divider(
            thickness: 1.0,
            height: 1.0,
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 50.0, top: 20.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset("assets/quizscreen/ans_right.png",
                      width: 20, height: 20),
                  AppSpacing.horizontalExtraSmall,
                  Text(
                      "  ${utf8.decode(latin1.encode(value.quiz[index]['answer'].toString()))}",
                      style: AppTextStyles.heading3),
                ],
              ),
            ),
          ),
          AppSpacing.verticalMedium
        ],
      ),
    );
  }
}
