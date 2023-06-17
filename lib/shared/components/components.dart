import 'package:flutter/material.dart';
import 'package:get/get.dart';
void snackBar(
    {required String title,
    required String message,
  }) {
  Get.snackbar(title, "",
      messageText: AutoSizeText(
        message,
        
        maxLines: 1,
      ),
      backgroundColor: Colors.white);
}

AutoSizeText(String message, {required int maxLines}) {
}
