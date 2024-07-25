import 'dart:math';

import 'package:dares_game/data/daos/level_dao.dart';
import 'package:dares_game/data/daos/preference_dao.dart';
import 'package:dares_game/domain/entities/level.dart';
import 'package:dares_game/domain/entities/preference.dart';
import 'package:flutter/material.dart';

class PreferencesNotifier extends ChangeNotifier {
  final int categoryId;

  PreferencesNotifier({
    required this.categoryId,
  });

  bool _isExecutingRequest = false;
  get isExecutingRequest => _isExecutingRequest;

  Preference? firstPreference;
  Preference? secondPreference;

  final levelsDao = LevelDao();

  final preferenceDao = PreferenceDao();

  List<Level?> levels = [];

  void fetchLevels() async {
    _isExecutingRequest = true;

    try {
      if (categoryId == 5) {
        levels = await levelsDao.readAll();
      } else {
        levels = await levelsDao.readByCategoryId(categoryId);
      }
      getPreferences();
    } catch (er) {
      _isExecutingRequest = false;
    }
  }

  List<Preference?> preferences = [];

  List<int?> previousRandomLevels = [];

  String _title = '¿Que prefieres?';
  get title => _title;

  // obtiene el que prefieres
  void getPreferences() async {
    preferences.clear();
    // obtiene un número del 1 al máximo de los niveles [levels]
    final int randomLevel = Random().nextInt(levels.length) + 1;

    final bool allLevelsHasIterated = previousRandomLevels.length == levels.length;
    if (allLevelsHasIterated) {
      previousRandomLevels.clear();
      getPreferences();
      return;
    }

    if (previousRandomLevels.contains(randomLevel)) {
      getPreferences();
      return;
    }

    previousRandomLevels.add(randomLevel);

    try {
      if (categoryId == 5) {
        preferences = await preferenceDao.readAll(randomLevel);
      } else {
        preferences = await preferenceDao.readByCategoryIdAndLevelId(categoryId, randomLevel);
      }

      firstPreference = preferences.first;
      secondPreference = preferences.last;
    } catch (er) {
      _isExecutingRequest = false;
    }
    _title = preferences.first!.categoryId == 4 ? 'Verdad o reto' : '¿Que prefieres?';

    _isExecutingRequest = false;
    notifyListeners();
  }
}
