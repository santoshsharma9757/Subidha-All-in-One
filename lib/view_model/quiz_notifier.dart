import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hamro_smart_life/repository/quiz_repo/quiz_repo.dart';

class QuizNotifier extends ChangeNotifier {
  final _quizRepo = QuizRepo();

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  setIsLoading(bool value) {
    _isLoading = value;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      notifyListeners();
    });
  }

  List _quizCategory = [];
  List get quizCategory => _quizCategory;
  setQuizCategory(value) {
    _quizCategory = value;
    notifyListeners();
  }

  Future getQuizCategory(BuildContext context) async {
    setIsLoading(true);
    try {
      final response = await _quizRepo.getQuizCategory(context);
      setIsLoading(false);
      if (response != null) {
        setQuizCategory(response['data']);
      }
      log("quiz category list $_quizCategory");
    } catch (e) {
      setIsLoading(false);
      log('Erroer $e');
    }
  }



List _quiz=[];
 List get quiz => _quiz;

 setQuiz(List value) {
_quiz = value;
notifyListeners();
 } 


   Future getQuiz(BuildContext context,String quizCategoryId) async {
    setIsLoading(true);
    try {
      final response = await _quizRepo.getQuiz(context,quizCategoryId);
      
      setIsLoading(false);
      if (response != null) {
        setQuiz(response['quizzes']);
      }
      log("quiz list $_quiz");
    } catch (e) {
      setIsLoading(false);
      log('Erroer $e');
    }
  }





}
