class TableRowData {
  final String id;
  final String date;
  final String name;
  final String category;
  final String problem;
  final String location;
  final String note;
  final bool isBending;
  

  TableRowData({
    required this.id,
    required this.date,
    required this.name,
    required this.category,
    required this.problem,
    required this.location,
    required this.note,
    this.isBending = false, 
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is TableRowData &&
        other.id == id &&
        other.date == date &&
        other.name == name &&
        other.category == category &&
        other.problem == problem &&
        other.location == location &&
        other.note == note &&
        other.isBending == isBending;
  }

  @override
  int get hashCode =>
      id.hashCode ^
      date.hashCode ^
      name.hashCode ^
      category.hashCode ^
      problem.hashCode ^
      location.hashCode ^
      note.hashCode ^
      isBending.hashCode;
}
