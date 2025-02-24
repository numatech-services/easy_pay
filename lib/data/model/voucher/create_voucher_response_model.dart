import 'package:viserpay/data/model/global/user/user_model.dart';

import '../auth/sign_up_model/registration_response_model.dart';

class CreateVoucherResponseModel {
  CreateVoucherResponseModel({
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

  CreateVoucherResponseModel.fromJson(dynamic json) {
    _remark = json['remark'];
    _status = json['status'];
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

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['remark'] = _remark;
    map['status'] = _status;
    if (_message != null) {
      map['message'] = _message?.toJson();
    }
    if (_data != null) {
      map['data'] = _data?.toJson();
    }
    return map;
  }
}

class Data {
  Data({
    List<String>? otpType,
    GlobalUser? user,
    VoucherCharge? voucherCharge,
  }) {
    _otpType = otpType;
    _user = user;
    _voucherCharge = voucherCharge;
  }

  Data.fromJson(dynamic json) {
    _otpType = json['otp_type'] != null ? json['otp_type'].cast<String>() : [];
    _voucherCharge = json['voucher_charge'] != null ? VoucherCharge.fromJson(json['voucher_charge']) : null;
    _user = json['user'] != null ? GlobalUser.fromJson(json['user']) : null;
  }

  List<String>? _otpType;
  GlobalUser? _user;
  VoucherCharge? _voucherCharge;

  List<String>? get otpType => _otpType;
  GlobalUser? get user => _user;
  VoucherCharge? get voucherCharge => _voucherCharge;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['otp_type'] = _otpType;

    if (_voucherCharge != null) {
      map['voucher_charge'] = _voucherCharge?.toJson();
    }
    return map;
  }
}

class VoucherCharge {
  VoucherCharge({
    int? id,
    String? slug,
    String? fixedCharge,
    String? percentCharge,
    String? minLimit,
    String? maxLimit,
    String? agentCommissionFixed,
    String? agentCommissionPercent,
    String? merchantFixedCharge,
    String? merchantPercentCharge,
    String? monthlyLimit,
    String? dailyLimit,
    String? dailyRequestAcceptLimit,
    String? voucherLimit,
    String? cap,
    String? createdAt,
    String? updatedAt,
  }) {
    _id = id;
    _slug = slug;
    _fixedCharge = fixedCharge;
    _percentCharge = percentCharge;
    _minLimit = minLimit;
    _maxLimit = maxLimit;
    _agentCommissionFixed = agentCommissionFixed;
    _agentCommissionPercent = agentCommissionPercent;
    _merchantFixedCharge = merchantFixedCharge;
    _merchantPercentCharge = merchantPercentCharge;
    _monthlyLimit = monthlyLimit;
    _dailyLimit = dailyLimit;
    _dailyRequestAcceptLimit = dailyRequestAcceptLimit;
    _voucherLimit = voucherLimit;
    _cap = cap;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
  }

  VoucherCharge.fromJson(dynamic json) {
    _id = json['id'];
    _slug = json['slug'].toString();
    _fixedCharge = json['fixed_charge'].toString();
    _percentCharge = json['percent_charge'].toString();
    _minLimit = json['min_limit'].toString();
    _maxLimit = json['max_limit'].toString();
    _agentCommissionFixed = json['agent_commission_fixed'].toString();
    _agentCommissionPercent = json['agent_commission_percent'].toString();
    _merchantFixedCharge = json['merchant_fixed_charge'].toString();
    _merchantPercentCharge = json['merchant_percent_charge'].toString();
    _monthlyLimit = json['monthly_limit'].toString();
    _dailyLimit = json['daily_limit'].toString();
    _dailyRequestAcceptLimit = json['daily_request_accept_limit'].toString();
    _voucherLimit = json['voucher_limit'].toString();
    _cap = json['cap'].toString();
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }
  int? _id;
  String? _slug;
  String? _fixedCharge;
  String? _percentCharge;
  String? _minLimit;
  String? _maxLimit;
  String? _agentCommissionFixed;
  String? _agentCommissionPercent;
  String? _merchantFixedCharge;
  String? _merchantPercentCharge;
  String? _monthlyLimit;
  String? _dailyLimit;
  String? _dailyRequestAcceptLimit;
  String? _voucherLimit;
  String? _cap;
  String? _createdAt;
  String? _updatedAt;

  int? get id => _id;
  String? get slug => _slug;
  String? get fixedCharge => _fixedCharge;
  String? get percentCharge => _percentCharge;
  String? get minLimit => _minLimit;
  String? get maxLimit => _maxLimit;
  String? get agentCommissionFixed => _agentCommissionFixed;
  String? get agentCommissionPercent => _agentCommissionPercent;
  String? get merchantFixedCharge => _merchantFixedCharge;
  String? get merchantPercentCharge => _merchantPercentCharge;
  String? get monthlyLimit => _monthlyLimit;
  String? get dailyLimit => _dailyLimit;
  String? get dailyRequestAcceptLimit => _dailyRequestAcceptLimit;
  String? get voucherLimit => _voucherLimit;
  String? get cap => _cap;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['slug'] = _slug;
    map['fixed_charge'] = _fixedCharge;
    map['percent_charge'] = _percentCharge;
    map['min_limit'] = _minLimit;
    map['max_limit'] = _maxLimit;
    map['agent_commission_fixed'] = _agentCommissionFixed;
    map['agent_commission_percent'] = _agentCommissionPercent;
    map['merchant_fixed_charge'] = _merchantFixedCharge;
    map['merchant_percent_charge'] = _merchantPercentCharge;
    map['monthly_limit'] = _monthlyLimit;
    map['daily_limit'] = _dailyLimit;
    map['daily_request_accept_limit'] = _dailyRequestAcceptLimit;
    map['voucher_limit'] = _voucherLimit;
    map['cap'] = _cap;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    return map;
  }
}

class Wallets {
  Wallets({
    int? id,
    String? userId,
    String? userType,
    String? currencyId,
    String? currencyCode,
    String? balance,
    String? createdAt,
    String? updatedAt,
    Currency? currency,
  }) {
    _id = id;
    _userId = userId;
    _userType = userType;
    _currencyId = currencyId;
    _currencyCode = currencyCode;
    _balance = balance;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _currency = currency;
  }

  Wallets.fromJson(dynamic json) {
    _id = json['id'];
    _userId = json['user_id'].toString();
    _userType = json['user_type'].toString();
    _currencyId = json['currency_id'].toString();
    _currencyCode = json['currency_code'].toString();
    _balance = json['balance'] != null ? json['balance'].toString() : "";
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _currency = json['currency'] != null ? Currency.fromJson(json['currency']) : null;
  }
  int? _id;
  String? _userId;
  String? _userType;
  String? _currencyId;
  String? _currencyCode;
  String? _balance;
  String? _createdAt;
  String? _updatedAt;
  Currency? _currency;

  int? get id => _id;
  String? get userId => _userId;
  String? get userType => _userType;
  String? get currencyId => _currencyId;
  String? get currencyCode => _currencyCode;
  String? get balance => _balance;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  Currency? get currency => _currency;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['user_id'] = _userId;
    map['user_type'] = _userType;
    map['currency_id'] = _currencyId;
    map['currency_code'] = _currencyCode;
    map['balance'] = _balance;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    if (_currency != null) {
      map['currency'] = _currency?.toJson();
    }
    return map;
  }
}

class Currency {
  Currency({
    int? id,
    String? currencyCode,
    String? currencySymbol,
    String? currencyFullName,
    String? currencyType,
    String? rate,
    String? isDefault,
    String? status,
    String? createdAt,
    String? updatedAt,
    String? voucherMinLimit,
    String? voucherMaxLimit,
  }) {
    _id = id;
    _currencyCode = currencyCode;
    _currencySymbol = currencySymbol;
    _currencyFullName = currencyFullName;
    _currencyType = currencyType;
    _rate = rate;
    _isDefault = isDefault;
    _status = status;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _voucherMinLimit = voucherMinLimit;
    _voucherMaxLimit = voucherMaxLimit;
  }

  Currency.fromJson(dynamic json) {
    _id = json['id'];
    _currencyCode = json['currency_code'].toString();
    _currencySymbol = json['currency_symbol'].toString();
    _currencyFullName = json['currency_fullname'].toString();
    _currencyType = json['currency_type'].toString();
    _rate = json['rate'].toString();
    _isDefault = json['is_default'].toString();
    _status = json['status'].toString();
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _voucherMinLimit = json['voucher_min_limit'] != null ? json['voucher_min_limit'].toString() : "";
    _voucherMaxLimit = json['voucher_max_limit'] != null ? json['voucher_max_limit'].toString() : "";
  }
  int? _id;
  String? _currencyCode;
  String? _currencySymbol;
  String? _currencyFullName;
  String? _currencyType;
  String? _rate;
  String? _isDefault;
  String? _status;
  String? _createdAt;
  String? _updatedAt;
  String? _voucherMinLimit;
  String? _voucherMaxLimit;

  int? get id => _id;
  String? get currencyCode => _currencyCode;
  String? get currencySymbol => _currencySymbol;
  String? get currencyFullName => _currencyFullName;
  String? get currencyType => _currencyType;
  String? get rate => _rate;
  String? get isDefault => _isDefault;
  String? get status => _status;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  String? get voucherMinLimit => _voucherMinLimit;
  String? get voucherMaxLimit => _voucherMaxLimit;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['currency_code'] = _currencyCode;
    map['currency_symbol'] = _currencySymbol;
    map['currency_fullname'] = _currencyFullName;
    map['currency_type'] = _currencyType;
    map['rate'] = _rate;
    map['is_default'] = _isDefault;
    map['status'] = _status;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    map['voucher_min_limit'] = _voucherMinLimit;
    map['voucher_max_limit'] = _voucherMaxLimit;
    return map;
  }
}
