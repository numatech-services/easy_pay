import 'package:viserpay/environment.dart';

import '../auth/sign_up_model/registration_response_model.dart';

class GeneralSettingResponseModel {
  GeneralSettingResponseModel({
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

  GeneralSettingResponseModel.fromJson(dynamic json) {
    _remark = json['remark'].toString();
    _status = json['status'].toString();
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
    GeneralSetting? generalSetting,
  }) {
    _generalSetting = generalSetting;
  }

  Data.fromJson(dynamic json) {
    _generalSetting = json['general_setting'] != null ? GeneralSetting.fromJson(json['general_setting']) : null;
  }
  GeneralSetting? _generalSetting;

  GeneralSetting? get generalSetting => _generalSetting;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_generalSetting != null) {
      map['general_setting'] = _generalSetting?.toJson();
    }
    return map;
  }
}

class GeneralSetting {
  GeneralSetting({
    int? id,
    String? siteName,
    String? loginMethod,
    List<String>? quickAmount,
    String? otpVerification,
    String? otpExpiration,
    String? curText,
    String? curSym,
    String? emailFrom,
    String? qrCodeTemplate,
    String? emailTemplate,
    String? smsBody,
    String? firebaseTemplate,
    String? smsFrom,
    String? baseColor,
    FirebaseConfig? firebaseConfig,
    GlobalShortcodes? globalShortcodes,
    String? fiatCurrencyApi,
    String? cryptoCurrencyApi,
    // CronRun? cronRun,
    String? kv,
    String? ev,
    String? en,
    String? sv,
    String? sn,
    String? pn,
    String? detectActivity,
    String? enableLanguage,
    String? forceSsl,
    String? maintenanceMode,
    String? securePassword,
    String? agree,
    String? multiLanguage,
    String? registration,
    String? activeTemplate,
    String? systemInfo,
    dynamic createdAt,
    String? updatedAt,
  }) {
    _id = id;
    _siteName = siteName;
    _loginMethod = loginMethod;
    _quickAmount = quickAmount;
    _otpVerification = otpVerification;
    _otpExpiration = otpExpiration;
    _curText = curText;
    _curSym = curSym;
    _emailFrom = emailFrom;
    _qrCodeTemplate = qrCodeTemplate;
    _emailTemplate = emailTemplate;
    _smsBody = smsBody;
    _firebaseTemplate = firebaseTemplate;
    _smsFrom = smsFrom;
    _baseColor = baseColor;
    _firebaseConfig = firebaseConfig;
    _globalShortcodes = globalShortcodes;
    _fiatCurrencyApi = fiatCurrencyApi;
    _cryptoCurrencyApi = cryptoCurrencyApi;
    // _cronRun = cronRun;
    _kv = kv;
    _ev = ev;
    _en = en;
    _sv = sv;
    _sn = sn;
    _pn = pn;
    _detectActivity = detectActivity;
    _enableLanguage = enableLanguage;
    _forceSsl = forceSsl;
    _maintenanceMode = maintenanceMode;
    _securePassword = securePassword;
    _agree = agree;
    _multiLanguage = multiLanguage;
    _registration = registration;
    _activeTemplate = activeTemplate;
    _systemInfo = systemInfo;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
  }

  GeneralSetting.fromJson(dynamic json) {
    _id = json['id'];
    _siteName = json['site_name'];
    _loginMethod = json['user_login_method'].toString();
    if (json['quick_amounts'] != null) {
      _quickAmount = [];
      json['quick_amounts'].forEach((v) {
        _quickAmount?.add(v.toString());
      });
    }
    //_quickAmount = json["quick_amounts"] == null ? [] : List<String>.from(json["quick_amounts"]!.map((x) => x));
    _otpVerification = json['otp_verification'].toString();
    _otpExpiration = json['otp_expiration'] == null? Environment.otpTime.toString() : json['otp_expiration'].toString() ;
    _curText = json['cur_text'].toString();
    _curSym = json['cur_sym'].toString();
    _emailFrom = json['email_from'].toString();
    _qrCodeTemplate = json['qr_code_template'].toString();
    _emailTemplate = json['email_template'].toString();
    _smsBody = json['sms_body'].toString();
    _firebaseTemplate = json['firebase_template'].toString();
    _smsFrom = json['sms_from'].toString();
    _baseColor = json['base_color'].toString();
    _fiatCurrencyApi = json['fiat_currency_api'].toString();
    _cryptoCurrencyApi = json['crypto_currency_api'].toString();
    // _cronRun = json['cron_run'] != null ? CronRun.fromJson(json['cron_run']) : null;
    _kv = json['kv'].toString();
    _ev = json['ev'].toString();
    _en = json['en'].toString();
    _sv = json['sv'].toString();
    _sn = json['sn'].toString();
    _pn = json['pn'].toString();
    _detectActivity = json['detect_activity'].toString();
    _enableLanguage = json['enable_language'].toString();
    _forceSsl = json['force_ssl'].toString();
    _maintenanceMode = json['maintenance_mode'].toString();
    _securePassword = json['secure_password'].toString();
    _agree = json['agree'].toString();
    _multiLanguage = json['multi_language'].toString();
    _registration = json['registration'].toString();
    _activeTemplate = json['active_template'].toString();
    _systemInfo = json['system_info'].toString();
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }

  int? _id;
  String? _siteName;
  String? _loginMethod;
  List<String>? _quickAmount;
  String? _otpVerification;
  String? _otpExpiration;
  String? _curText;
  String? _curSym;
  String? _emailFrom;
  String? _qrCodeTemplate;
  String? _emailTemplate;
  String? _smsBody;
  String? _firebaseTemplate;
  String? _smsFrom;
  String? _baseColor;
  FirebaseConfig? _firebaseConfig;
  GlobalShortcodes? _globalShortcodes;
  String? _fiatCurrencyApi;
  String? _cryptoCurrencyApi;
  // CronRun? _cronRun;
  String? _kv;
  String? _ev;
  String? _en;
  String? _sv;
  String? _sn;
  String? _pn;
  String? _detectActivity;
  String? _enableLanguage;
  String? _forceSsl;
  String? _maintenanceMode;
  String? _securePassword;
  String? _agree;
  String? _multiLanguage;
  String? _registration;
  String? _activeTemplate;
  String? _systemInfo;
  String? _createdAt;
  String? _updatedAt;

  int? get id => _id;
  String? get siteName => _siteName;
  String? get loginMethod => _loginMethod;
  List<String> get quicAmount => _quickAmount ?? [];
  String? get otpVerification => _otpVerification;
  String? get otpExpiration => _otpExpiration;
  String? get curText => _curText;
  String? get curSym => _curSym;
  String? get emailFrom => _emailFrom;
  String? get qrCodeTemplate => _qrCodeTemplate;
  String? get emailTemplate => _emailTemplate;
  String? get smsBody => _smsBody;
  String? get firebaseTemplate => _firebaseTemplate;
  String? get smsFrom => _smsFrom;
  String? get baseColor => _baseColor;
  FirebaseConfig? get firebaseConfig => _firebaseConfig;
  GlobalShortcodes? get globalShortcodes => _globalShortcodes;
  String? get fiatCurrencyApi => _fiatCurrencyApi;
  String? get cryptoCurrencyApi => _cryptoCurrencyApi;
  // CronRun? get cronRun => _cronRun;
  String? get kv => _kv;
  String? get ev => _ev;
  String? get en => _en;
  String? get sv => _sv;
  String? get sn => _sn;
  String? get pn => _pn;
  String? get detectActivity => _detectActivity;
  String? get enableLanguage => _enableLanguage;
  String? get forceSsl => _forceSsl;
  String? get maintenanceMode => _maintenanceMode;
  String? get securePassword => _securePassword;
  String? get agree => _agree;
  String? get multiLanguage => _multiLanguage;
  String? get registration => _registration;
  String? get activeTemplate => _activeTemplate;
  String? get systemInfo => _systemInfo;
  dynamic get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['site_name'] = _siteName;
    map['user_login_method'] = _loginMethod;
    map['quick_amounts'] = _quickAmount == null ? [] : List<String>.from(_quickAmount!.map((x) => x));
    map['otp_verification'] = _otpVerification;
    map['otp_expiration'] = _otpExpiration;
    map['cur_text'] = _curText;
    map['cur_sym'] = _curSym;
    map['email_from'] = _emailFrom;
    map['qr_code_template'] = _qrCodeTemplate;
    map['email_template'] = _emailTemplate;
    map['sms_body'] = _smsBody;
    map['firebase_template'] = _firebaseTemplate;
    map['sms_from'] = _smsFrom;
    map['base_color'] = _baseColor;
    if (_firebaseConfig != null) {
      map['firebase_config'] = _firebaseConfig?.toJson();
    }
    if (_globalShortcodes != null) {
      map['global_shortcodes'] = _globalShortcodes?.toJson();
    }
    map['fiat_currency_api'] = _fiatCurrencyApi;
    map['crypto_currency_api'] = _cryptoCurrencyApi;
    // if (_cronRun != null) {
    //   map['cron_run'] = _cronRun?.toJson();
    // }
    map['kv'] = _kv;
    map['ev'] = _ev;
    map['en'] = _en;
    map['sv'] = _sv;
    map['sn'] = _sn;
    map['pn'] = _pn;
    map['detect_activity'] = _detectActivity;
    map['enable_language'] = _enableLanguage;
    map['force_ssl'] = _forceSsl;
    map['maintenance_mode'] = _maintenanceMode;
    map['secure_password'] = _securePassword;
    map['agree'] = _agree;
    map['multi_language'] = _multiLanguage;
    map['registration'] = _registration;
    map['active_template'] = _activeTemplate;
    map['system_info'] = _systemInfo;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    return map;
  }
}

// class CronRun {
//   CronRun({
//     String? fiatCron,
//     String? cryptoCron,
//   }) {
//     _fiatCron = fiatCron;
//     _cryptoCron = cryptoCron;
//   }

//   CronRun.fromJson(dynamic json) {
//     _fiatCron = json['fiat_cron'].toString();
//     _cryptoCron = json['crypto_cron'].toString();
//   }
//   String? _fiatCron;
//   String? _cryptoCron;

//   String? get fiatCron => _fiatCron;
//   String? get cryptoCron => _cryptoCron;

//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     map['fiat_cron'] = _fiatCron;
//     map['crypto_cron'] = _cryptoCron;
//     return map;
//   }
// }

class GlobalShortcodes {
  GlobalShortcodes({
    String? siteName,
    String? siteCurrency,
    String? currencySymbol,
  }) {
    _siteName = siteName;
    _siteCurrency = siteCurrency;
    _currencySymbol = currencySymbol;
  }

  GlobalShortcodes.fromJson(dynamic json) {
    _siteName = json['site_name'];
    _siteCurrency = json['site_currency'] != null ? json['site_currency'].toString() : '';
    _currencySymbol = json['currency_symbol'] != null ? json['currency_symbol'].toString() : '';
  }

  String? _siteName;
  String? _siteCurrency;
  String? _currencySymbol;

  String? get siteName => _siteName;
  String? get siteCurrency => _siteCurrency;
  String? get currencySymbol => _currencySymbol;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['site_name'] = _siteName;
    map['site_currency'] = _siteCurrency;
    map['currency_symbol'] = _currencySymbol;
    return map;
  }
}

class FirebaseConfig {
  FirebaseConfig({
    String? apiKey,
    String? authDomain,
    String? projectId,
    String? storageBucket,
    String? messagingSenderId,
    String? appId,
    String? measurementId,
    String? serverKey,
  }) {
    _apiKey = apiKey;
    _authDomain = authDomain;
    _projectId = projectId;
    _storageBucket = storageBucket;
    _messagingSenderId = messagingSenderId;
    _appId = appId;
    _measurementId = measurementId;
    _serverKey = serverKey;
  }

  FirebaseConfig.fromJson(dynamic json) {
    _apiKey = json['apiKey'].toString();
    _authDomain = json['authDomain'].toString();
    _projectId = json['projectId'].toString();
    _storageBucket = json['storageBucket'].toString();
    _messagingSenderId = json['messagingSenderId'].toString();
    _appId = json['appId'].toString();
    _measurementId = json['measurementId'].toString();
    _serverKey = json['serverKey'].toString();
  }
  String? _apiKey;
  String? _authDomain;
  String? _projectId;
  String? _storageBucket;
  String? _messagingSenderId;
  String? _appId;
  String? _measurementId;
  String? _serverKey;

  String? get apiKey => _apiKey;
  String? get authDomain => _authDomain;
  String? get projectId => _projectId;
  String? get storageBucket => _storageBucket;
  String? get messagingSenderId => _messagingSenderId;
  String? get appId => _appId;
  String? get measurementId => _measurementId;
  String? get serverKey => _serverKey;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['apiKey'] = _apiKey;
    map['authDomain'] = _authDomain;
    map['projectId'] = _projectId;
    map['storageBucket'] = _storageBucket;
    map['messagingSenderId'] = _messagingSenderId;
    map['appId'] = _appId;
    map['measurementId'] = _measurementId;
    map['serverKey'] = _serverKey;
    return map;
  }
}
