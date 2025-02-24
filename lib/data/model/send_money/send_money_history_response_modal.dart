// To parse this JSON data, do
//
//     final sendMoneyHistoryResponseModel = sendMoneyHistoryResponseModelFromJson(jsonString);

import 'dart:convert';

import 'package:viserpay/data/model/global/meassage_model.dart';
import 'package:viserpay/data/model/send_money/send_money_response_modal.dart';

SendMoneyHistoryResponseModel sendMoneyHistoryResponseModelFromJson(String str) => SendMoneyHistoryResponseModel.fromJson(json.decode(str));

String sendMoneyHistoryResponseModelToJson(SendMoneyHistoryResponseModel data) => json.encode(data.toJson());

class SendMoneyHistoryResponseModel {
  String? remark;
  String? status;
  Message? message;
  Data? data;

  SendMoneyHistoryResponseModel({
    this.remark,
    this.status,
    this.message,
    this.data,
  });

  factory SendMoneyHistoryResponseModel.fromJson(Map<String, dynamic> json) => SendMoneyHistoryResponseModel(
        remark: json["remark"],
        status: json["status"],
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
  History? history;

  Data({
    this.history,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        history: json["history"] == null ? null : History.fromJson(json["history"]),
      );

  Map<String, dynamic> toJson() => {
        "history": history?.toJson(),
      };
}

class History {
  String? currentPage;
  List<LatestSendMoneyHistory>? data;
  String? nextPageUrl;

  History({
    this.currentPage,
    this.data,
    this.nextPageUrl,
  });

  factory History.fromJson(Map<String, dynamic> json) => History(
        currentPage: json["current_page"].toString(),
        data: json["data"] == null ? [] : List<LatestSendMoneyHistory>.from(json["data"]!.map((x) => LatestSendMoneyHistory.fromJson(x))),
        nextPageUrl: json["next_page_url"],
      );

  Map<String, dynamic> toJson() => {
        "current_page": currentPage,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
        "next_page_url": nextPageUrl,
      };
}
