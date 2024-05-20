class Category {
  final int id;
  final String categoryName;
  final String identifier;

  const Category({
    this.id = 0,
    this.categoryName = '',
    this.identifier = '',
  });

  static Category? parse(Map? map) {
    if (map == null) return null;

    return Category(id: map['id'], categoryName: map['name'], identifier: map['identifier']);
  }

  static List<Category> parseList(dynamic data) {
    final List<Category> list = [];
    if (data is List) {
      for (Map map in data) {
        final Category? item = Category.parse(map);
        if (item != null) {
          list.add(item);
        }
      }
    } else if (data is Map) {
      if (data.containsKey('categories') && data['categories'] is List) {
        final List<Category> items = parseList(data['categories']);
        list.addAll(items);
      } else {
        final Category? item = Category.parse(data);
        if (item != null) {
          list.add(item);
        }
      }
    }
    return list;
  }

  Category copyWith({
    int? id,
    String? categoryName,
    String? identifier,
  }) {
    return Category(
      id: id ?? this.id,
      categoryName: categoryName ?? this.categoryName,
      identifier: identifier ?? this.identifier,
    );
  }

  Map<String, dynamic> toMap() => {
        'id': id,
        'name': categoryName,
        'identifier': identifier,
      };
}
