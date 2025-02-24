import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:viserpay/core/helper/shared_preference_helper.dart';
import 'package:viserpay/core/route/route.dart';
import 'package:viserpay/core/utils/messages.dart';
import 'package:viserpay/core/utils/my_strings.dart';
import 'package:viserpay/core/utils/util.dart';
import 'package:viserpay/data/controller/localization/localization_controller.dart';
import 'package:viserpay/data/model/general_setting/general_setting_response_model.dart';
import 'package:viserpay/data/model/global/response_model/response_model.dart';
import 'package:viserpay/data/repo/auth/general_setting_repo.dart';
import 'package:viserpay/view/components/snack_bar/show_custom_snackbar.dart';

class SplashController extends GetxController {
  GeneralSettingRepo repo;
  LocalizationController localizationController;
  bool isLoading = true;

  SplashController({required this.repo, required this.localizationController});

  gotoNextPage() async {
    await loadLanguage();

    noInternet = false;
    update();

    initSharedData();
    getGSData();
  }

  bool noInternet = false;
  void getGSData() async {
    await repo.loadAndStoreModuleSetting();

    ResponseModel response = await repo.getGeneralSetting();
    if (response.statusCode == 200) {
      GeneralSettingResponseModel model = GeneralSettingResponseModel.fromJson(jsonDecode(response.responseJson));
      if (model.status?.toLowerCase() == MyStrings.success) {
        repo.apiClient.storeGeneralSetting(model);
        repo.apiClient.storeQuickAmountList(model.data?.generalSetting?.quicAmount ?? []);
      } else {
        List<String> message = [MyStrings.somethingWentWrong];
        CustomSnackBar.error(errorList: model.message?.error ?? message);
      }
    } else {
      if (response.statusCode == 503) {
        noInternet = true;
        update();
      }
      CustomSnackBar.error(errorList: [response.message]);
    }

    isLoading = false;
    update();

    Future.delayed(const Duration(seconds: 1), () {
      Get.offAndToNamed(RouteHelper.loginScreen);
      // Get.offAndToNamed(RouteHelper.bottomNavBar);
    });
  }

  Future<bool> initSharedData() {
    if (!repo.apiClient.sharedPreferences.containsKey(SharedPreferenceHelper.countryCode)) {
      return repo.apiClient.sharedPreferences.setString(SharedPreferenceHelper.countryCode, MyStrings.myLanguages[0].countryCode);
    }
    if (!repo.apiClient.sharedPreferences.containsKey(SharedPreferenceHelper.languageCode)) {
      return repo.apiClient.sharedPreferences.setString(SharedPreferenceHelper.languageCode, MyStrings.myLanguages[0].languageCode);
    }
    return Future.value(true);
  }

  Future<void> loadLanguage() async {
    localizationController.loadCurrentLanguage();
    String languageCode = localizationController.locale.languageCode;
    ResponseModel response = await repo.getLanguage(languageCode);
    if (response.statusCode == 200) {
      try {
        Map<String, Map<String, String>> language = {};
        var resJson = jsonDecode(response.responseJson);
        saveLanguageList(response.responseJson);
        var value = resJson['data']['file'].toString() == '[]' ? {} : resJson['data']['file'];
        Map<String, String> json = {};
        printx(value);
        value.forEach((key, value) {
          json[key] = value.toString();
        });
        language['${localizationController.locale.languageCode}_${localizationController.locale.countryCode}'] = json;
        Get.addTranslations(Messages(languages: language).keys);
      } catch (e) {
        if (kDebugMode) {
          CustomSnackBar.error(errorList: [e.toString()]);
        }
      }
    } else {
      CustomSnackBar.error(errorList: [response.message]);
    }
  }

  void saveLanguageList(String languageJson) async {
    await repo.apiClient.sharedPreferences.setString(SharedPreferenceHelper.languageListKey, languageJson);
    return;
  }
}
