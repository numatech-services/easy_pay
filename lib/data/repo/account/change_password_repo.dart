import 'dart:convert';

import 'package:get/get.dart';
import 'package:viserpay/core/utils/method.dart';
import 'package:viserpay/core/utils/my_strings.dart';
import 'package:viserpay/core/utils/url_container.dart';
import 'package:viserpay/data/model/authorization/authorization_response_model.dart';
import 'package:viserpay/data/model/global/response_model/response_model.dart';
import 'package:viserpay/data/services/api_service.dart';
import 'package:viserpay/view/components/snack_bar/show_custom_snackbar.dart';

class ChangePasswordRepo {
  ApiClient apiClient;

  ChangePasswordRepo({required this.apiClient});
  String token = '', tokenType = '';

  Future<bool> changePassword(String currentPass, String password) async {
    final params = modelToMap(currentPass, password);
    String url = '${UrlContainer.baseUrl}${UrlContainer.changePasswordEndPoint}';

    ResponseModel responseModel = await apiClient.request(url, Method.postMethod, params, passHeader: true);
    if (responseModel.statusCode == 200) {
      AuthorizationResponseModel model = AuthorizationResponseModel.fromJson(jsonDecode(responseModel.responseJson));
      if (model.message?.success != null && model.message!.success!.isNotEmpty) {
        CustomSnackBar.success(successList: model.message?.success ?? [MyStrings.pin.tr]);

        return true;
      } else {
        CustomSnackBar.error(errorList: model.message?.error ?? [MyStrings.requestFail.tr]);
        return false;
      }
    } else {
      //handle error
      return false;
    }
  }

  modelToMap(String currentPassword, String newPass) {
    Map<String, dynamic> map2 = {'current_password': currentPassword, 'password': newPass, 'password_confirmation': newPass};
    return map2;
  }
}
