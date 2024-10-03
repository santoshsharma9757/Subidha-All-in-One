import 'dart:convert';
import 'dart:io';

import 'package:hamro_smart_life/services/app_exceptions.dart';
import 'package:http/http.dart' as http;

class NetworkServices {
  Future get(String url) async {
    dynamic responseJson;
    try {
      final response =
          await http.get(Uri.parse(url)).timeout(const Duration(seconds: 30));
      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }
    return responseJson;
  }

  dynamic returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
      case 201:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;
      case 400:
        throw BadRequestException("Something went wrong".toString());
      case 401:
        throw BadRequestException("Something went wrong".toString());
      case 500:
      case 404:
        throw UnauthorisedException("Page not found".toString());
      default:
        throw FetchDataException(
            'Error accured while communicating with server' +
                'with status code' +
                response.statusCode.toString());
    }
  }
}
