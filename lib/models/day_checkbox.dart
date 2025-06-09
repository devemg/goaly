class DayCheckbox {
  String name;
  int key;

  DayCheckbox({required this.name, required this.key});
  
   DayCheckbox copyWith({
    String? name,
    int? key,
  }) {
    return DayCheckbox(
      name: name ?? this.name,
      key: key ?? this.key,
    );
  }
}