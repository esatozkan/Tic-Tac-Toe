import 'package:flutter/material.dart';
import 'package:tic_tac_toe/data/constants/constants.dart';

ScaffoldFeatureController<SnackBar, SnackBarClosedReason>
    snackbarInformation(context, String text) {
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: Theme.of(context).colorScheme.surface,
      duration: const Duration(seconds: 1),
      content: Center(
        child: Text(
          text,
          style: TextStyle(
            fontFamily: "poppins",
            fontSize: 14,
            color: wrongColor,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    ),
  );
}
