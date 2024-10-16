import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hamro_smart_life/constant/app_constant.dart';
import 'package:hamro_smart_life/constant/app_screen_utils.dart';
import 'package:hamro_smart_life/constant/app_text_style.dart';
import 'package:hamro_smart_life/constant/app_urls.dart';
import 'package:hamro_smart_life/utils/widgets/reusable_appbar.dart';
import 'package:hamro_smart_life/utils/widgets/reusable_container_widget.dart';
import 'package:hamro_smart_life/utils/widgets/reusable_grid_view.dart';
import 'package:hamro_smart_life/view_model/quiz_notifier.dart';
import 'package:provider/provider.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  @override
  void initState() {
    final provider = Provider.of<QuizNotifier>(context, listen: false);
    provider.getQuizCategory(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const ReusableAppBar(
          title: "Quiz",
          centerTitle: true,
        ),
        body: Consumer<QuizNotifier>(
          builder: (context, value, child) => value.isLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : _buildGrildviewSection(value),
        ));
  }

  _buildGrildviewSection(QuizNotifier value) {
    return ReusableGridView(
      crossAxisCount: 2,
      crossAxisSpacing: 5.0,
      mainAxisSpacing: 5.0,
      childAspectRatio: 1.0,
      itemCount: value.quizCategory.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, '/quiz_list', arguments: {
              "quizCatId": value.quizCategory[index]['id'],
              "quizCatName": value.quizCategory[index]['title']
            });
          },
          child: _buildCard(value, index),
        );
      },
    );
  }

  _buildCard(QuizNotifier value, int index) {
    return ReusableContainer(
      color: AppColors.purple,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: AppScreenUtils.screenHeightPercentage(context, 0.13),
            child: CachedNetworkImage(
              imageUrl: AppUrls.baseUrl2 + value.quizCategory[index]['image'],
              imageBuilder: (context, imageProvider) => Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: imageProvider,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              placeholder: (context, url) => const Center(
                  child: CircularProgressIndicator(strokeWidth: 2)),
              errorWidget: (context, url, error) => const Center(
                child: Text("Loading..."),
              ),
              fit: BoxFit.cover,
            ),
          ),
          AppSpacing.verticalMedium,
          FittedBox(
              child: Text(
            utf8.decode(latin1.encode(value.quizCategory[index]['title'])),
            style: AppTextStyles.heading4,
          )),
        ],
      ),
    );
  }
}
