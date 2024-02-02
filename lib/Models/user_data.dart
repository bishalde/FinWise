// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UserData {
  final String? firstName;
  final String? lastName;
  final String? dob;
  final String? email;
  final String? password;
  final String? phoneNumber;
  final String? address;
  final String? city;
  final String? state;
  final String? country;
  final String? zipCode;
  final String? uid;
  final String? gender;
  final String? upi;
  UserData({
    this.firstName,
    this.lastName,
    this.dob,
    this.email,
    this.password,
    this.phoneNumber,
    this.address,
    this.city,
    this.state,
    this.country,
    this.zipCode,
    this.uid,
    this.gender,
    this.upi,
  });

  UserData copyWith({
    String? firstName,
    String? lastName,
    String? dob,
    String? email,
    String? password,
    String? phoneNumber,
    String? address,
    String? city,
    String? state,
    String? country,
    String? zipCode,
    String? uid,
    String? gender,
    String? upi,
  }) {
    return UserData(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      dob: dob ?? this.dob,
      email: email ?? this.email,
      password: password ?? this.password,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      address: address ?? this.address,
      city: city ?? this.city,
      state: state ?? this.state,
      country: country ?? this.country,
      zipCode: zipCode ?? this.zipCode,
      uid: uid ?? this.uid,
      gender: gender ?? this.gender,
      upi: upi ?? this.upi,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'dob': dob,
      'email': email,
      'password': password,
      'phoneNumber': phoneNumber,
      'address': address,
      'city': city,
      'state': state,
      'country': country,
      'zipCode': zipCode,
      'uid': uid,
      'gender': gender,
      'upi': upi,
    };
  }

  factory UserData.fromMap(Map<String, dynamic> map) {
    return UserData(
      firstName: map['firstName'],
      lastName: map['lastName'],
      dob: map['dob'],
      email: map['email'],
      password: map['password'],
      phoneNumber: map['phoneNumber'],
      address: map['address'],
      city: map['city'],
      state: map['state'],
      country: map['country'],
      zipCode: map['zipCode'],
      uid: map['uid'],
      gender: map['gender'],
      upi: map['upi'],
    );
  }

  String toJson() => json.encode(toMap());

  factory UserData.fromJson(String source) =>
      UserData.fromMap(json.decode(source));

  @override
  String toString() {
    return 'UserData(firstName: $firstName, lastName: $lastName, dob: $dob, email: $email, password: $password, phoneNumber: $phoneNumber, address: $address, city: $city, state: $state, country: $country, zipCode: $zipCode, uid: $uid, gender: $gender, upi: $upi)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is UserData &&
      other.firstName == firstName &&
      other.lastName == lastName &&
      other.dob == dob &&
      other.email == email &&
      other.password == password &&
      other.phoneNumber == phoneNumber &&
      other.address == address &&
      other.city == city &&
      other.state == state &&
      other.country == country &&
      other.zipCode == zipCode &&
      other.uid == uid &&
      other.gender == gender &&
      other.upi == upi;
  }

  @override
  int get hashCode {
    return firstName.hashCode ^
      lastName.hashCode ^
      dob.hashCode ^
      email.hashCode ^
      password.hashCode ^
      phoneNumber.hashCode ^
      address.hashCode ^
      city.hashCode ^
      state.hashCode ^
      country.hashCode ^
      zipCode.hashCode ^
      uid.hashCode ^
      gender.hashCode ^
      upi.hashCode;
  }
}
