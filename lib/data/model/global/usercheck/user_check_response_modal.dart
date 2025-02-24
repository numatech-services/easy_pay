import 'dart:convert';

import 'package:viserpay/data/model/global/meassage_model.dart';

UserCheckResponseModal userCheckResponseModalFromJson(String str) => UserCheckResponseModal.fromJson(json.decode(str));

String userCheckResponseModalToJson(UserCheckResponseModal data) => json.encode(data.toJson());

class UserCheckResponseModal {
  String? remark;
  String? status;
  Message? message;
  Data? data;

  UserCheckResponseModal({
    this.remark,
    this.status,
    this.message,
    this.data,
  });

  factory UserCheckResponseModal.fromJson(Map<String, dynamic> json) => UserCheckResponseModal(
        remark: json["remark"],
        status: json["status"].toString(),
        message: json["message"] == null ? null : Message.fromJson(json["message"]),
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "remark": remark,
        "status": status,
        "message": message?.toJson(),
        "data": data?.toJson(),
      };
}

class Data {
  User? user;

  Data({
    this.user,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        user: json["user"] == null ? null : User.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "user": user?.toJson(),
      };
}

class User {
  int? id;
  String? firstname;
  String? lastname;
  String? username;
  String? isicNum;
  String? email;
  String? countryCode;
  String? mobile;
  String? refBy;
  String? dialCode;

  String? image;
  String? status;
  String? kv;
  String? ev;
  String? sv;
  String? profileComplete;
  String? verCodeSendAt;
  String? ts;
  String? tv;
  String? tsc;
  String? banReason;
  String? createdAt;
  String? updatedAt;
  String? getImage;

  User({
    this.id,
    this.firstname,
    this.lastname,
    this.username,
    this.isicNum,
    this.email,
    this.countryCode,
    this.mobile,
    this.refBy,
    this.dialCode,
    this.image,
    this.status,
    this.kv,
    this.ev,
    this.sv,
    this.profileComplete,
    this.verCodeSendAt,
    this.ts,
    this.tv,
    this.tsc,
    this.banReason,
    this.createdAt,
    this.updatedAt,
    this.getImage,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        firstname: json["firstname"],
        lastname: json["lastname"],
        username: json["username"],
        isicNum: json["isic_num"].toString(),
        email: json["email"],
        countryCode: json["country_code"].toString(),
        mobile: json["mobile"].toString(),
        dialCode: json["dial_code"].toString(),
        refBy: json["ref_by"].toString(),
        image: json["image"].toString(),
        status: json["status"].toString(),
        kv: json["kv"].toString(),
        ev: json["ev"].toString(),
        sv: json["sv"].toString(),
        profileComplete: json["profile_complete"].toString(),
        verCodeSendAt: json["ver_code_send_at"].toString(),
        ts: json["ts"].toString(),
        tv: json["tv"].toString(),
        tsc: json["tsc"].toString(),
        banReason: json["ban_reason"].toString(),
        createdAt: json["created_at"].toString(),
        updatedAt: json["updated_at"].toString(),
        getImage: json["get_image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "firstname": firstname,
        "lastname": lastname,
        "username": username,
        "isicNum": isicNum,
        "email": email,
        "country_code": countryCode,
        "mobile": mobile,
        "ref_by": refBy,
        "image": image,
        "status": status,
        "kv": kv,
        "ev": ev,
        "sv": sv,
        "profile_complete": profileComplete,
        "ver_code_send_at": verCodeSendAt?.toString(),
        "ts": ts,
        "tv": tv,
        "tsc": tsc,
        "ban_reason": banReason,
        "created_at": createdAt?.toString(),
        "updated_at": updatedAt?.toString(),
        "get_image": getImage,
      };
}
