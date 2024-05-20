import 'package:dares_game/data/daos/category_dao.dart';
import 'package:dares_game/domain/entities/category.dart';

import 'package:flutter/material.dart';

class HomeNotifier extends ChangeNotifier {
  bool _isExecutingRequest = false;
  get isExecutingRequest => _isExecutingRequest;

  List<Category?> categories = [];
  final categoryDao = CategoryDao();

  void fetchCategories() async {
    _isExecutingRequest = true;
    try {
      categories = await categoryDao.readAll();
    } catch (e) {
      _isExecutingRequest = false;
    }
    _isExecutingRequest = false;
    notifyListeners();
  }
}
