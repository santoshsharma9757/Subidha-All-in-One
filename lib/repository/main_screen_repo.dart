import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hamro_smart_life/constant/app_urls.dart';
import 'package:hamro_smart_life/services/network_services.dart';
import 'package:hamro_smart_life/utils/app_utils.dart';

class MainScreenRepo {
  final _networkService = NetworkServices();
  getCarouselBanner(BuildContext context) async {
    try {
      final response = await _networkService
          .get(AppUrls.carouselBanner)
          .catchError((error, stackTrace) {
        AppUtils.showMyDialog(error.toString(), "Error", context);
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