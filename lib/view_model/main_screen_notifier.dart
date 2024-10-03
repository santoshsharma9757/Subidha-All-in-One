import 'dart:developer';

import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/material.dart';
import 'package:hamro_smart_life/repository/main_screen_repo.dart';

class MainScreenNotifier extends ChangeNotifier {
  final _mainScreenRepo = MainScreenRepo();
  List<String> services = [
    "calculator",
    "quiz",
    "game_note",
    "games",
    "notes",
    "calendar",
    // "additional",
  ];

  List imageList = [
    "assets/mainscreen/banner1.jpg",
    "assets/mainscreen/banner2.jpg"
  ];
  CarouselSliderController controller = CarouselSliderController();
  int currentIndex = 0;

  List additionalServices = ["calendar", "news", "currency"];

  List iconsServices = [
    Icons.calendar_month,
    Icons.newspaper,
    Icons.currency_bitcoin
  ];

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  setIsLoading(bool value) {
    _isLoading = value;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      notifyListeners();
    });
  }
//carousel_banners

  List _carouselBanner = [];
  List get carouselBanner => _carouselBanner;

  setCarouselBanner(List value) {
    _carouselBanner = value;
    notifyListeners();
  }

  Future getCarouselBanner(BuildContext context) async {
    setIsLoading(true);
    try {
      final response = await _mainScreenRepo.getCarouselBanner(context);
      print("Response $response");
      setIsLoading(false);
      if (response != null) {
        setCarouselBanner(response['data']);
      }
    } catch (e) {
      setIsLoading(false);
      log('Erroer $e');
    }
  }
}
