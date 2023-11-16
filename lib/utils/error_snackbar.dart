import 'package:flutter/material.dart';
import 'package:order_tracking/utils/theme/theme.dart';

errorSnackBar({required String error}) {
  return SnackBar(
    backgroundColor: appTheme.colorScheme.error,
    elevation: 0,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(2)),
    behavior: SnackBarBehavior.fixed,
    content: Text(
      error,
      textAlign: TextAlign.center,
      style: AppTextStyles.bodyMedium.copyWith(color: appTheme.cardColor),
    ),
    duration: const Duration(seconds: 2),
  );
}
