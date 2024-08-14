import 'package:flutter/material.dart';

class TextFieldProvider with ChangeNotifier {
  bool isTextFieldFocused = false;

  bool get getIsTextFieldFocused => isTextFieldFocused;

  void setFocus(bool value) {
    isTextFieldFocused = value;
    notifyListeners();
  }

  void resetFocus() {
    isTextFieldFocused = false;
  }
}