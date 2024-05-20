class Level {
  final int id;
  final String levelName;
  final int categoryId;

  const Level({
    this.id = 0,
    this.levelName = '',
    this.categoryId = 0,
  });

  static Level? parse(Map? map) {
    if (map == null) return null;

    return Level(id: map['id'], levelName: map['name'], categoryId: map['category_id']);
  }

  static List<Level> parseList(dynamic data) {
    final List<Level> list = [];
    if (data is List) {
      for (Map map in data) {
        final Level? item = Level.parse(map);
        if (item != null) {
          list.add(item);
        }
      }
    } else if (data is Map) {
      if (data.containsKey('levels') && data['levels'] is List) {
        final List<Level> items = parseList(data['levels']);
        list.addAll(items);
      } else {
        final Level? item = Level.parse(data);
        if (item != null) {
          list.add(item);
        }
      }
    }
    return list;
  }

  Level copyWith({
    int? id,
    String? levelName,
    int? categoryId,
  }) {
    return Level(
      id: id ?? this.id,
      levelName: levelName ?? this.levelName,
      categoryId: categoryId ?? this.categoryId,
    );
  }

  Map<String, dynamic> toMap() => {
        'id': id,
        'name': levelName,
        'category_id': categoryId,
      };
}
