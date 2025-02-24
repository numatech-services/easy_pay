import 'dart:convert';

import 'package:viserpay/data/model/global/meassage_model.dart';

MarchentExistingModel userCheckResponseModalFromJson(String str) => MarchentExistingModel.fromJson(json.decode(str));

String userCheckResponseModalToJson(MarchentExistingModel data) => json.encode(data.toJson());

class MarchentExistingModel {
  String? remark;
  String? status;
  Message? message;
  Data? data;

  MarchentExistingModel({
    this.remark,
    this.status,
    this.message,
    this.data,
  });

  factory MarchentExistingModel.fromJson(Map<String, dynamic> json) => MarchentExistingModel(
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
  Merchant? user;

  Data({
    this.user,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        user: json["merchant"] == null ? null : Merchant.fromJson(json["merchant"]),
      );

  Map<String, dynamic> toJson() => {
        "merchant": user?.toJson(),
      };
}

class Merchant {
  int? id;
  String? firstname;
  String? lastname;
  String? username;
  String? email;
  String? countryCode;
  String? mobile;
  String? refBy;
  Address? address;
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

  Merchant({
    this.id,
    this.firstname,
    this.lastname,
    this.username,
    this.email,
    this.countryCode,
    this.mobile,
    this.refBy,
    this.address,
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

  factory Merchant.fromJson(Map<String, dynamic> json) => Merchant(
        id: json["id"],
        firstname: json["firstname"],
        lastname: json["lastname"],
        username: json["username"],
        email: json["email"],
        countryCode: json["country_code"].toString(),
        mobile: json["mobile"].toString(),
        refBy: json["ref_by"].toString(),
        address: json["address"] == null ? null : Address.fromJson(json["address"]),
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
        createdAt: json["created_at"],
        updatedAt: json["updated_at"].toString(),
        getImage: json["get_image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "firstname": firstname,
        "lastname": lastname,
        "username": username,
        "email": email,
        "country_code": countryCode,
        "mobile": mobile,
        "ref_by": refBy,
        "address": address?.toJson(),
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

class Address {
  String? address;
  String? state;
  String? zip;
  String? country;
  String? city;

  Address({
    this.address,
    this.state,
    this.zip,
    this.country,
    this.city,
  });

  factory Address.fromJson(Map<String, dynamic> json) => Address(
        address: json["address"],
        state: json["state"],
        zip: json["zip"].toString(),
        country: json["country"],
        city: json["city"],
      );

  Map<String, dynamic> toJson() => {
        "address": address,
        "state": state,
        "zip": zip,
        "country": country,
        "city": city,
      };
}
