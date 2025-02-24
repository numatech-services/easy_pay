import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import '../auth/sign_up_model/registration_response_model.dart';

class KycResponseModel {
  KycResponseModel({
    String? remark,
    String? status,
    Message? message,
    Data? data,
  }) {
    _remark = remark;
    _status = status;
    _message = message;
    _data = data;
  }

  KycResponseModel.fromJson(dynamic json) {
    _remark = json['remark'];
    _status = json['status'] != null ? json['status'].toString() : '';
    _message = json['message'] != null ? Message.fromJson(json['message']) : null;
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  String? _remark;
  String? _status;
  Message? _message;
  Data? _data;

  String? get remark => _remark;
  String? get status => _status;
  Message? get message => _message;
  Data? get data => _data;
}

class Data {
  Data({
    FormData? form,
    List<KycPendingData>? kycPendingData,
    String? path,
  }) {
    _form = form;
    _kycPendingData = kycPendingData;
    _path = path;
  }

  Data.fromJson(dynamic json) {
    _form = json['form'] != null ? FormData.fromJson(json['form']) : null;
    _kycPendingData = json['kyc_data'] == null ? [] : List<KycPendingData>.from(json["kyc_data"]!.map((x) => KycPendingData.fromJson(x)));
    _path = json["path"];
  }
  FormData? _form;
  String? _path;
  List<KycPendingData>? _kycPendingData;

  FormData? get form => _form;
  List<KycPendingData>? get kycPendingData => _kycPendingData;
  String? get path => _path;
}

class FormData {
  FormData({List<FormModel>? list}) {
    _list = list;
  }

  List<FormModel>? _list = [];
  List<FormModel>? get list => _list;

  FormData.fromJson(dynamic json) {
    var map = Map.from(json).map((key, value) => MapEntry(key, value));
    try {
      List<FormModel>? list = map.entries
          // .map(
          //   (e) => FormModel(e.value['name'], e.value['label'], e.value['is_required'].toString(), e.value['extensions'], (e.value['options'] as List).map((e) => e as String).toList(), e.value['type'].toString(), ''),
          // )
          // .toList();
          .map(
            (e) => FormModel(
              name: e.value['name'],
              label: e.value['label'],
              isRequired: e.value['is_required'].toString(),
              extensions: e.value['extensions'],
              instruction: e.value['instruction'],
              options: (e.value['options'] as List).map((e) => e as String).toList(),
              type: e.value['type'].toString(),
              textEditingController: TextEditingController(),
            ),
          )
          .toList();

      if (list.isNotEmpty) {
        list.removeWhere((element) => element.toString().isEmpty);
        _list?.addAll(list);
      }
      _list;
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }
}

class FormModel {
  String? name;
  String? label;
  String? isRequired;
  String? extensions;
  String? instruction;
  List<String>? options;
  String? type;
  dynamic selectedValue;
  TextEditingController? textEditingController;
  File? imageFile;
  List<String>? cbSelected;

  FormModel({
    this.name,
    this.label,
    this.isRequired,
    this.instruction,
    this.extensions,
    this.options,
    this.type,
    this.selectedValue,
    this.cbSelected,
    this.imageFile,
    this.textEditingController,
  });
}

class KycPendingData {
  String? name;
  String? type;
  String? value;

  KycPendingData({
    this.name,
    this.type,
    this.value,
  });

  factory KycPendingData.fromJson(Map<String, dynamic> json) => KycPendingData(
        name: json["name"],
        type: json["type"],
        value: json["value"] != null ? json["value"].toString() : '---',
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "type": type,
        "value": value,
      };
}
