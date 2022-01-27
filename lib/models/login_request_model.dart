import 'dart:convert';

LoginRequestModel loginRequestModelFromJson(String str) => LoginRequestModel.fromJson(json.decode(str));

String loginRequestModelToJson(LoginRequestModel data) => json.encode(data.toJson());

class LoginRequestModel {
    LoginRequestModel({
        this.username,
        this.password,
    });

    String? username;
    String? password;

    factory LoginRequestModel.fromJson(Map<String, dynamic> json) => LoginRequestModel(
        username: json["username"],
        password: json["password"],
    );

    Map<String, dynamic> toJson() => {
        "username": username,
        "password": password,
    };
}