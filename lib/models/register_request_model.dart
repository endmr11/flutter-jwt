import 'dart:convert';

RegisterRequestModel registerRequestModelFromJson(String str) => RegisterRequestModel.fromJson(json.decode(str));

String registerRequestModelToJson(RegisterRequestModel data) => json.encode(data.toJson());

class RegisterRequestModel {
    RegisterRequestModel({
        this.username,
        this.password,
        this.email,
    });

    String? username;
    String? password;
    String? email;

    factory RegisterRequestModel.fromJson(Map<String, dynamic> json) => RegisterRequestModel(
        username: json["username"],
        password: json["password"],
        email: json["email"],
    );

    Map<String, dynamic> toJson() => {
        "username": username,
        "password": password,
        "email": email,
    };
}
