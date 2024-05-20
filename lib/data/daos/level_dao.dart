import 'package:dares_game/data/local_data_base/sql_helper.dart';
import 'package:dares_game/domain/entities/level.dart';

class LevelDao {
  Future<List<Level?>> readByCategoryId(int id) async {
    final database = await SqlHelper.instance.database;

    final data = await database.rawQuery('SELECT * FROM levels WHERE category_id = $id');
    return data.map((e) => Level.parse(e)).toList();
  }

  Future<List<Level?>> readAll() async {
    final database = await SqlHelper.instance.database;

    final data = await database.rawQuery('SELECT * FROM levels');
    return data.map((e) => Level.parse(e)).toList();
  }
}
