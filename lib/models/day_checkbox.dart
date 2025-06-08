class DayCheckbox {
  String name;
  bool isChecked;
  int index;

  DayCheckbox({required this.name, required this.isChecked, required this.index});
  
   DayCheckbox copyWith({
    String? name,
    bool? isChecked,
    int? index,
  }) {
    return DayCheckbox(
      isChecked: isChecked ?? this.isChecked,
      name: name ?? this.name,
      index: index ?? this.index,
    );
  }
}