import 'dart:async';
import 'dart:io';

import 'package:http/http.dart';

class ExceptionHandler {
  static String handleApiException(dynamic error) {
    if (error is ClientException) {
      return "Server unreachable, please check your internet connection or try again later";
    }
    if (error is SocketException) {
      return "Seem like internet is down, Please check your internet and try again!";
    } else if (error is TimeoutException) {
      return "Server unreachable";
    } else if (error is HttpException) {
      return 'Opps, there seems to be a problem we are working on it!';
    } else if (error is FormatException) {
      return error.message;
    } else {
      return "An unexpected error occurred: $error";
    }
  }
}
