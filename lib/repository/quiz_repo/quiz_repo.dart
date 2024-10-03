import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hamro_smart_life/constant/app_urls.dart';
import 'package:hamro_smart_life/services/network_services.dart';
import 'package:hamro_smart_life/utils/app_utils.dart';

class QuizRepo {
  final _networkService = NetworkServices();
  getQuizCategory(BuildContext context) async {
    try {
      final response = await _networkService
          .get(AppUrls.quizCategories)
          .catchError((error, stackTrace) {
        AppUtils.showMyDialog(error.toString(), context);
        if (kDebugMode) {
          print(error.toString());
        }
      });

      return response;
    } catch (e) {
      rethrow;
    }
  }


    getQuiz(BuildContext context,String quizCategoryId) async {
    try {
      String url ="${AppUrls.quizCategories}$quizCategoryId/quizzes/";
      print("QUIZ URL:$url");
      final response = await _networkService
          .get("${AppUrls.quizCategories}$quizCategoryId/quizzes")
          .catchError((error, stackTrace) {
        AppUtils.showMyDialog(error.toString(), context);
        if (kDebugMode) {
          print(error.toString());
        }
      });

      return response;
    } catch (e) {
      rethrow;
    }
  }



}
