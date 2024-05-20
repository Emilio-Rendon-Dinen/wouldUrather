import 'package:dares_game/data/local_data_base/sql_helper.dart';
import 'package:dares_game/domain/entities/category.dart';

class CategoryDao {
  Future<List<Category?>> readAll() async {
    final database = await SqlHelper.instance.database;

    final data = await database.rawQuery('SELECT * FROM categories');
    return data.map((e) => Category.parse(e)).toList();
  }
}
