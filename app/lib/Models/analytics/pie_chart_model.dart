import 'dart:convert';

class PieChartModel {
  final String title;
  final double value;
  PieChartModel({
    required this.title,
    required this.value,
  });



  PieChartModel copyWith({
    String? title,
    double? value,
  }) {
    return PieChartModel(
      title: title ?? this.title,
      value: value ?? this.value,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'value': value,
    };
  }

  factory PieChartModel.fromMap(Map<String, dynamic> map) {
    return PieChartModel(
      title: map['title'] ?? '',
      value: map['value']?.toDouble() ?? 0.0,
    );
  }

  String toJson() => json.encode(toMap());

  factory PieChartModel.fromJson(String source) => PieChartModel.fromMap(json.decode(source));

  @override
  String toString() => 'PieChartModel(title: $title, value: $value)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is PieChartModel &&
      other.title == title &&
      other.value == value;
  }

  @override
  int get hashCode => title.hashCode ^ value.hashCode;
}
