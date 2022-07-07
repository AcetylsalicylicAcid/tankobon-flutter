import 'package:flutter/material.dart';

class GlobalState extends ChangeNotifier {
  String? _globalState;
  String? get globalState => _globalState;

  void setGlobalState(String? value) {
    _globalState = value;
    notifyListeners();
  }
}
