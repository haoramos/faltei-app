import 'package:faltei/services/database_service.dart';
import 'package:flutter/material.dart';

class AppViewModel extends ChangeNotifier {
  bool _isInitialized = false;

  bool get isInitialized => _isInitialized;

  Future<void> initialize() async {
    await DatabaseService().database;
    _isInitialized = true;
    notifyListeners();
  }
}
