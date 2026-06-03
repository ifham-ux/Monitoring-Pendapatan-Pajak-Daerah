class Search {

  static List<T> filterList<T>({
    required List<T> items,
    required String query,
    required List<String> Function(T item) selector,
  }) {

  final lower = query.trim().toLowerCase();

  if (lower.isEmpty) {
    return items;
  }

  return items.where((item) {

    final searchableValues = selector(item);
    return searchableValues.any((value) {
      return value
        .toLowerCase()
        .contains(lower);
    });

  }).toList();
}
}