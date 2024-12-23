import 'dart:io';
import 'package:flutter/material.dart';

class WidgetSelectionModel extends ChangeNotifier {
  bool textbox = false;
  bool noWidgets = false;
  bool image = false;
  bool button = false;
  bool addWidget = false;
  bool saving = false;
  File? selectedImage;
  String? text;
  String? imageLink;

  void setText(String newText) {
    text = newText;
    notifyListeners();
  }

  void setImageLink(String newText) {
    imageLink = newText;
    notifyListeners();
  }

  void selectImage(File? image) {
    selectedImage = image;
    notifyListeners();
  }

  void toggleTextbox(bool newValue) {
    textbox = newValue;
    notifyListeners();
  }

  void toggleNoWidgets(bool newValue) {
    noWidgets = newValue;
    notifyListeners();
  }

  void toggleSaving(bool newValue) {
    saving = newValue;
    notifyListeners();
  }

  void toggleAddWidgets() {
    addWidget = !addWidget;
    notifyListeners();
  }

  void toggleImage(bool newValue) {
    image = newValue;
    notifyListeners();
  }

  void toggleButton(bool newValue) {
    button = newValue;
    notifyListeners();
  }
}
