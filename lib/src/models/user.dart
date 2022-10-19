import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {

    String id;
    String email;
    String userCode;
    String name;
    String password;
    String sessionToken;

    User({
        required this.id,
        required this.email,
        required this.userCode,
        required this.name,
        required this.password,
        required this.sessionToken,
    });

    factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        email: json["email"],
        userCode: json["user_code"],
        name: json["name"],
        password: json["password"],
        sessionToken: json["session_token"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "user_code": userCode,
        "name": name,
        "password": password,
        "session_token": sessionToken,
    };
}
