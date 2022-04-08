import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/utils/palette.dart';

class CustomSnack {
  static SnackbarController error(message) {
    return Get.snackbar('Error', message,
        colorText: Colors.white, backgroundColor: Palette.RED);
  }

  static SnackbarController success(message) {
    return Get.snackbar('Success', message, backgroundColor: Palette.GREEN);
  }

  static SnackbarController alert(message) {
    return Get.snackbar('Alert', message, backgroundColor: Palette.YELLOW);
  }
}
