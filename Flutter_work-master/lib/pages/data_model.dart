import 'package:flutter/material.dart';

class DataModel extends ChangeNotifier {
  final List<Map<String, String>> _entries = [];

  List<Map<String, String>> get entries => _entries;

  void addEntry(String name, String regno) {
    _entries.add({'name': name, 'regno': regno});
    notifyListeners();
  }

  void deleteEntry(int index) {
    _entries.removeAt(index);
    notifyListeners(); 
  }
}