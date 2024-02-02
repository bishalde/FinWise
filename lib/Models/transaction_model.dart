import 'dart:convert';

class TransactionModel {
  String? id;
  String? uid;
  String? type;
  String? description;
  int? amount;
  String? date;
  TransactionModel({
    this.id,
    this.uid,
    this.type,
    this.description,
    this.amount,
    this.date,
  });

  TransactionModel copyWith({
    String? id,
    String? uid,
    String? type,
    String? description,
    int? amount,
    String? date,
  }) {
    return TransactionModel(
      id: id ?? this.id,
      uid: uid ?? this.uid,
      type: type ?? this.type,
      description: description ?? this.description,
      amount: amount ?? this.amount,
      date: date ?? this.date,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'uid': uid,
      'type': type,
      'description': description,
      'amount': amount,
      'date': date,
    };
  }

  factory TransactionModel.fromMap(Map<String, dynamic> map) {
    return TransactionModel(
      id: map['id'],
      uid: map['uid'],
      type: map['type'],
      description: map['description'],
      amount: map['amount']?.toInt(),
      date: map['date'],
    );
  }

  String toJson() => json.encode(toMap());

  factory TransactionModel.fromJson(String source) => TransactionModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'TransactionModel(id: $id, uid: $uid, type: $type, description: $description, amount: $amount, date: $date)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is TransactionModel &&
      other.id == id &&
      other.uid == uid &&
      other.type == type &&
      other.description == description &&
      other.amount == amount &&
      other.date == date;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      uid.hashCode ^
      type.hashCode ^
      description.hashCode ^
      amount.hashCode ^
      date.hashCode;
  }
}
