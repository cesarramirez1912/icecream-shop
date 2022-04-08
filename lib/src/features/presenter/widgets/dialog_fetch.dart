import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icecream_shop/src/features/presenter/widgets/stackbar.dart';

Future<void> dialogFecth(Function request, {String? text = 'Aguarde'}) async {
  Get.dialog(
    Center(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 5),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Padding(
                padding:
                    EdgeInsets.only(top: 15, bottom: 30, left: 8, right: 8),
                child: CircularProgressIndicator(),
              ),
              Flexible(
                child: Text(
                  text!,
                  style: const TextStyle(fontSize: 16),
                  overflow: TextOverflow.clip,
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    ),
    barrierDismissible: false,
  );

  try {
    await request();
  } catch (e) {
    Get.back();
    CustomSnack.error(e.toString());
  } finally {
    Get.back();
  }
}
