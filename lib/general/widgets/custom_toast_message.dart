import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

class CustomToast {
  static void showToastMessage({
    required String msg,
    required ToastificationType toastType,
    required Color toastColor,
  }) {
    toastification.show(
      type: toastType,
      title: Text(
        msg,
        style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
      ),
      icon: Icon(
        ToastificationType.success == toastType
            ? Icons.check_circle
            : Icons.info,
        color: toastColor,
        size: 28,
      ),
      style: ToastificationStyle.flatColored,
      autoCloseDuration: const Duration(seconds: 3),
      animationDuration: const Duration(milliseconds: 300),
      animationBuilder: (context, animation, alignment, child) {
        return FadeTransition(opacity: animation, child: child);
      },
      primaryColor: toastColor,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
      borderRadius: BorderRadius.circular(12),
      boxShadow: const [
        BoxShadow(
          color: Color(0x07000000),
          blurRadius: 16,
          offset: Offset(0, 16),
          spreadRadius: 0,
        ),
      ],
      showProgressBar: false,
    );
  }
}
