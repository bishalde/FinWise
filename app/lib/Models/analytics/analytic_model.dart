import 'dart:convert';

import 'package:flutter/foundation.dart';

class AnalyticModel {
  final Debits debits;
  final Credits credits;
  AnalyticModel({
    required this.debits,
    required this.credits,
  });

  AnalyticModel copyWith({
    Debits? debits,
    Credits? credits,
  }) {
    return AnalyticModel(
      debits: debits ?? this.debits,
      credits: credits ?? this.credits,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'debits': debits.toMap(),
      'credits': credits.toMap(),
    };
  }

  factory AnalyticModel.fromMap(Map<String, dynamic> map) {
    return AnalyticModel(
      debits: Debits.fromMap(map['debits']),
      credits: Credits.fromMap(map['credits']),
    );
  }

  String toJson() => json.encode(toMap());

  factory AnalyticModel.fromJson(String source) => AnalyticModel.fromMap(json.decode(source));

  @override
  String toString() => 'AnalyticModel(debits: $debits, credits: $credits)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is AnalyticModel &&
      other.debits == debits &&
      other.credits == credits;
  }

  @override
  int get hashCode => debits.hashCode ^ credits.hashCode;
}

class Debits {
  final List<CategoryWithPercentage> categoryWithPercentages;
  final int total;
  Debits({
    required this.categoryWithPercentages,
    required this.total,
  });

  Debits copyWith({
    List<CategoryWithPercentage>? categoryWithPercentages,
    int? total,
  }) {
    return Debits(
      categoryWithPercentages: categoryWithPercentages ?? this.categoryWithPercentages,
      total: total ?? this.total,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'categoryWithPercentages': categoryWithPercentages.map((x) => x.toMap()).toList(),
      'total': total,
    };
  }

  factory Debits.fromMap(Map<String, dynamic> map) {
    return Debits(
      categoryWithPercentages: List<CategoryWithPercentage>.from(map['categoryWithPercentages']?.map((x) => CategoryWithPercentage.fromMap(x))),
      total: map['total']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory Debits.fromJson(String source) => Debits.fromMap(json.decode(source));

  @override
  String toString() => 'Debits(categoryWithPercentages: $categoryWithPercentages, total: $total)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is Debits &&
      listEquals(other.categoryWithPercentages, categoryWithPercentages) &&
      other.total == total;
  }

  @override
  int get hashCode => categoryWithPercentages.hashCode ^ total.hashCode;
}

class CategoryWithPercentage {
  final String category;
  final int value;
  final double percentage;
  final int count;
  CategoryWithPercentage({
    required this.category,
    required this.value,
    required this.percentage,
    required this.count,
  });

  CategoryWithPercentage copyWith({
    String? category,
    int? value,
    double? percentage,
    int? count,
  }) {
    return CategoryWithPercentage(
      category: category ?? this.category,
      value: value ?? this.value,
      percentage: percentage ?? this.percentage,
      count: count ?? this.count,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'category': category,
      'value': value,
      'percentage': percentage,
      'count': count,
    };
  }

  factory CategoryWithPercentage.fromMap(Map<String, dynamic> map) {
    return CategoryWithPercentage(
      category: map['category'] ?? '',
      value: map['value']?.toInt() ?? 0,
      percentage: map['percentage']?.toDouble() ?? 0.0,
      count: map['count']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory CategoryWithPercentage.fromJson(String source) => CategoryWithPercentage.fromMap(json.decode(source));

  @override
  String toString() {
    return 'CategoryWithPercentage(category: $category, value: $value, percentage: $percentage, count: $count)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is CategoryWithPercentage &&
      other.category == category &&
      other.value == value &&
      other.percentage == percentage &&
      other.count == count;
  }

  @override
  int get hashCode {
    return category.hashCode ^
      value.hashCode ^
      percentage.hashCode ^
      count.hashCode;
  }
}

class Credits {
  final List<CategoryWithPercentage> categoryWithPercentages;
  final int total;
  Credits({
    required this.categoryWithPercentages,
    required this.total,
  });

  Credits copyWith({
    List<CategoryWithPercentage>? categoryWithPercentages,
    int? total,
  }) {
    return Credits(
      categoryWithPercentages: categoryWithPercentages ?? this.categoryWithPercentages,
      total: total ?? this.total,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'categoryWithPercentages': categoryWithPercentages.map((x) => x.toMap()).toList(),
      'total': total,
    };
  }

  factory Credits.fromMap(Map<String, dynamic> map) {
    return Credits(
      categoryWithPercentages: List<CategoryWithPercentage>.from(map['categoryWithPercentages']?.map((x) => CategoryWithPercentage.fromMap(x))),
      total: map['total']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory Credits.fromJson(String source) => Credits.fromMap(json.decode(source));

  @override
  String toString() => 'Credits(categoryWithPercentages: $categoryWithPercentages, total: $total)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is Credits &&
      listEquals(other.categoryWithPercentages, categoryWithPercentages) &&
      other.total == total;
  }

  @override
  int get hashCode => categoryWithPercentages.hashCode ^ total.hashCode;
}