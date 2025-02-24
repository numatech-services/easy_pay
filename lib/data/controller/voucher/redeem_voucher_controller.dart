import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../core/utils/my_strings.dart';
import '../../../view/components/snack_bar/show_custom_snackbar.dart';
import '../../model/authorization/authorization_response_model.dart';
import '../../model/global/response_model/response_model.dart';
import '../../repo/voucher/redeem_voucher_repo.dart';


class RedeemVoucherController extends GetxController{

  RedeemVoucherRepo redeemVoucherRepo;
  RedeemVoucherController({required this.redeemVoucherRepo});

  bool isLoading = true;
  TextEditingController codeController = TextEditingController();

  bool submitLoading = false;
  Future<void> submitRedeemVoucher() async{
    submitLoading = true;
    update();

    String voucherCode = codeController.text;

    ResponseModel responseModel = await redeemVoucherRepo.submitRedeemVoucher(voucherCode: voucherCode);
    if(responseModel.statusCode == 200){
      AuthorizationResponseModel model = AuthorizationResponseModel.fromJson(jsonDecode(responseModel.responseJson));
      if(model.status.toString().toLowerCase() == MyStrings.success.toLowerCase()){
        Get.back();
        CustomSnackBar.success(successList: model.message?.success ?? [MyStrings.requestSuccess]);
      }
      else{
        CustomSnackBar.error(errorList: model.message?.error ?? [MyStrings.enterVoucherCode]);
      }
    }
    else{
      CustomSnackBar.error(errorList: [responseModel.message]);
    }

    submitLoading = false;
    update();
  }
}