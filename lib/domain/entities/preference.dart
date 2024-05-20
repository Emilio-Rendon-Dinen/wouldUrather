class Preference {
  final int id;
  final String? preferenceText;
  final int levelId;
  final int categoryId;

  const Preference({
    this.id = 0,
    this.preferenceText,
    this.levelId = 0,
    this.categoryId = 0,
  });

  static Preference? parse(Map? map) {
    if (map == null) return null;

    return Preference(
      id: map['id'],
      preferenceText: map['preferences_text'],
      levelId: map['level_id'],
      categoryId: map['category_id'],
    );
  }

  static List<Preference> parseList(dynamic data) {
    final List<Preference> list = [];
    if (data is List) {
      for (Map map in data) {
        final Preference? item = Preference.parse(map);
        if (item != null) {
          list.add(item);
        }
      }
    } else if (data is Map) {
      if (data.containsKey('dares') && data['dares'] is List) {
        final List<Preference> items = parseList(data['dares']);
        list.addAll(items);
      } else {
        final Preference? item = Preference.parse(data);
        if (item != null) {
          list.add(item);
        }
      }
    }
    return list;
  }

  Preference copyWith({
    int? id,
    String? preferenceText,
    int? levelId,
    int? categoryId,
  }) {
    return Preference(
      id: id ?? this.id,
      preferenceText: preferenceText ?? this.preferenceText,
      levelId: levelId ?? this.levelId,
      categoryId: categoryId ?? this.categoryId,
    );
  }

  Map<String, dynamic> toMap() => {
        'id': id,
        'preferences_text': preferenceText,
        'level_id': levelId,
        'category_id': categoryId,
      };
}
