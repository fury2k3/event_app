import 'dart:convert';

UserInfo userInfoFromJson(String str) => UserInfo.fromJson(
      json.decode(str) as Map<String, dynamic>,
    );

String userInfoToJson(UserInfo data) => json.encode(data.toJson());

class UserInfo {
  UserInfo({
    this.token,
    this.userId,
    this.role,
  });

  factory UserInfo.fromJson(Map<String, dynamic> json) => UserInfo(
        token: json['token'] as String?,
        userId: json['userId'] as String?,
        role: json['role'] as String?,
      );
  String? token;
  String? userId;
  String? role;

  Map<String, dynamic> toJson() => {
        'token': token,
        'userId': userId,
        'role': role,
      };
}
