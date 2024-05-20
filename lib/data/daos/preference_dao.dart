import 'package:dares_game/data/local_data_base/sql_helper.dart';
import 'package:dares_game/domain/entities/preference.dart';

class PreferenceDao {
  Future<List<Preference?>> readByCategoryIdAndLevelId(int categoryId, int identifier) async {
    final database = await SqlHelper.instance.database;

    final data = await database.rawQuery(
      'SELECT * FROM preferences WHERE category_id = $categoryId AND identifier = $identifier',
    );
    return data.map((e) => Preference.parse(e)).toList();
  }

  Future<List<Preference?>> readAll(int levelId) async {
    final database = await SqlHelper.instance.database;

    final data = await database.rawQuery(
      'SELECT * FROM preferences WHERE level_id = $levelId',
    );
    return data.map((e) => Preference.parse(e)).toList();
  }
}
