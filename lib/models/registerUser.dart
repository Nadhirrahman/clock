// To parse this JSON data, do
//
//     final registerUser = registerUserFromJson(jsonString);

import 'dart:convert';

RegisterUser registerUserFromJson(String str) => RegisterUser.fromJson(json.decode(str));

String registerUserToJson(RegisterUser data) => json.encode(data.toJson());

class RegisterUser {
    RegisterUser({
        required this.email,
        required this.password,
        required this.role,
    });

    String email;
    String password;
    int role;

    factory RegisterUser.fromJson(Map<String, dynamic> json) => RegisterUser(
        email: json["email"],
        password: json["password"],
        role: json["role"],
    );

    Map<String, dynamic> toJson() => {
        "email": email,
        "password": password,
        "role": role,
    };
}
