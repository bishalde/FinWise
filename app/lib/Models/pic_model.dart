// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UserVerify {
  final String? userId;
  UserVerify({
    this.userId,
  });

  UserVerify copyWith({
    String? userId,
  }) {
    return UserVerify(
      userId: userId ?? this.userId,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userId': userId,
    };
  }

  factory UserVerify.fromMap(Map<String, dynamic> map) {
    return UserVerify(
      userId: map['userId'] != null ? map['userId'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserVerify.fromJson(String source) =>
      UserVerify.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'UserVerify(userId: $userId)';

  @override
  bool operator ==(covariant UserVerify other) {
    if (identical(this, other)) return true;
  
    return 
      other.userId == userId;
  }

  @override
  int get hashCode => userId.hashCode;
}
