import 'dart:convert';
import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  String? userPhoto;
  String? email;
  String? fullName;

  UserModel({
    this.userPhoto,
    this.email,
    this.fullName,
  });

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      userPhoto: map["user_photo"],
      email: map['email'] as String,
      fullName: map['fullName'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'user_photo': userPhoto,
      'email': email,
      'fullName': fullName,
    };
  }

  String toJson() => json.encode(toMap());

  UserModel copyWith({
    String? userPhoto,
    String? email,
    String? fullName,
  }) =>
      UserModel(
        userPhoto: userPhoto ?? this.userPhoto,
        email: email ?? this.email,
        fullName: fullName ?? this.fullName,
      );

  @override
  List<Object?> get props => [email, fullName, userPhoto];
}
