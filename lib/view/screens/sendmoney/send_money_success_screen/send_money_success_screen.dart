import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:viserpay/core/helper/date_converter.dart';
import 'package:viserpay/core/helper/shared_preference_helper.dart';
import 'package:viserpay/core/helper/string_format_helper.dart';
import 'package:viserpay/core/route/route.dart';
import 'package:viserpay/core/utils/my_color.dart';
import 'package:viserpay/core/utils/my_icon.dart';
import 'package:viserpay/core/utils/my_strings.dart';
import 'package:viserpay/core/utils/style.dart';
import 'package:viserpay/core/utils/user_inactivity.dart';
import 'package:viserpay/core/utils/util.dart';
import 'package:viserpay/data/controller/home/home_controller.dart';
import 'package:viserpay/data/model/global/response_model/response_model.dart';
import 'package:viserpay/data/model/send_money/send_money_submit_response_modal.dart';
import 'package:viserpay/data/services/api_service.dart';
import 'package:viserpay/view/components/card/cash_2colum.dart';
import 'package:viserpay/view/components/cash-card/user/user_card.dart';
import 'package:viserpay/view/components/custom_loader/custom_loader.dart';
import 'package:viserpay/view/components/divider/custom_divider.dart';
import 'package:viserpay/view/components/image/custom_svg_picture.dart';
import 'package:viserpay/view/components/snack_bar/show_custom_snackbar.dart';
import 'package:viserpay/view/components/will_pop_widget.dart';
import 'package:viserpay/view/components/dialog/app_dialog.dart';

class SendMoneySuccessScreen extends StatefulWidget {
  const SendMoneySuccessScreen({super.key});
 
  @override
  State<SendMoneySuccessScreen> createState() => _SendMoneySuccessScreenState();
}

class _SendMoneySuccessScreenState extends State<SendMoneySuccessScreen> {
  SendMoney? sendmoney;
  bool isLoading = false;
  String currency = "";
  String fullname = "";
  String isicNum = "";
  String ? idTrans;
  final InActivityTimer timer = InActivityTimer();
  @override
  void initState() {
    MyUtils.allScreen();
    timer.startTimer(context);
    ResponseModel data = Get.arguments[0];
    Get.put(ApiClient(sharedPreferences: Get.find()));
    currency = Get.find<ApiClient>().getCurrencyOrUsername(isSymbol: true);
    Get.put(ApiClient(sharedPreferences: Get.find()));
    fullname = Get.find<HomeController>().fullName;
    isicNum = Get.find<HomeController>().isicNum;

    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {
        isLoading = true;
      });
      SendMoneysubmitResponseModal modal = SendMoneysubmitResponseModal.fromJson(jsonDecode(data.responseJson));
      if (modal.status == "success") {
        if (modal.data != null) {
          setState(() {

            sendmoney = modal.data!.sendMoney; 
                getIdTrans();
            isLoading = false;
          });
          String date = DateConverter.localNumberdateOnly(modal.data?.sendMoney?.createdAt.toString() ?? "");
          String time = DateConverter.localTimeOnly(modal.data?.sendMoney?.createdAt.toString() ?? "");
          AppDialog().successDialog(
            details:  { 
              'senderName': fullname,
              'senderISIC': isicNum,
              'recipientName': '${ sendmoney?.receiverUser?.firstname ?? ""} ${ sendmoney?.receiverUser?.lastname ?? ""}',
              'recipientISIC': '${ sendmoney?.receiverUser?.isicNum ?? ""}',
              'amount': '$currency${StringConverter.formatNumber(sendmoney?.amount.toString() ?? "")}',
              'date': '${date} ${time}',
              },
            context,
            willPop: false,
            onTap: () {},
            title: MyStrings.sendMoney,
            cashDetails: NotificationListener<ScrollNotification>(
            onNotification: (_) {
          timer.handleUserInteraction(context);
          return false;
        },
              child: GestureDetector(
             onTap: () => timer.handleUserInteraction(context),
             onPanUpdate: (_) => timer.handleUserInteraction(context),
                child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: MyColor.borderColor,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Stack(
                      children: [
                        Column(
                          children: [
                            IntrinsicHeight(
                              child: CashDetailsColumn(
                                needBorder: false,
                                firstTitle: MyStrings.time.tr,
                                secondTitle: MyStrings.referenceID.tr,
                                total: "$time $date",
                                newBalance: "#${sendmoney?.trx.toString() ?? ""}",
                                totalStyle: semiBoldDefault.copyWith(
                                  fontWeight: FontWeight.w500,
                                  color: MyColor.getTextColor(),
                                ),
                                newBalanceStyle: semiBoldDefault.copyWith(),
                                space: 10,
                              ),
                            ),
                            const CustomDivider(),
                            IntrinsicHeight(
                              child: CashDetailsColumn(
                                needBorder: false,
                                firstTitle: MyStrings.total.tr,
                                secondTitle: MyStrings.newBalance.tr,
                                total: "$currency${StringConverter.formatNumber(sendmoney?.amount.toString() ?? "")}",
                                newBalance: "$currency${StringConverter.formatNumber(sendmoney?.postBalance ?? "")}",
                                space: 10,
                              ),
                            ),
                          ],
                        ),
                        Positioned.fill(
                          right: 0,
                          top: 55,
                          child: Align(
                            alignment: Alignment.topRight,
                            child: GestureDetector(
                              onTap: () {
                                Clipboard.setData(ClipboardData(text: sendmoney?.trx.toString() ?? "")).then((value) {
                                  CustomSnackBar.success(successList: [MyStrings.successfullyCopied.tr]);
                                });
                              },
                              child: const CustomSvgPicture(image: MyIcon.copy),
                            ),
                          ),
                        )
                      ],
                    )),
              ),
            ),
            userDetails: UserCard(
              title:"${sendmoney?.receiverUser?.firstname.toString() ?? ""} ${sendmoney?.receiverUser?.lastname.toString() ?? "" }",
              subtitle: sendmoney?.receiverUser?.mobile.toString() ?? "",
            ),
          );
        }
      }
    });
  }

  void getIdTrans() async{
   SharedPreferences prefs = await SharedPreferences.getInstance();
   idTrans = prefs.getString('idTrans');
   if(idTrans != null){
     bool? statusFeeIncluded = await MyUtils().loadFeeIncludedStatus();
    double? amount = double.tryParse(sendmoney?.amount.toString() ?? '0'); 
                   print("amount =====================: $amount"); 
    double  ?charge = double.tryParse(sendmoney?.charge.toString() ?? '0');
       print("charge =====================: $charge"); 
    double newAmount = amount! - charge!; 
               print("newAmount =====================: $newAmount"); 
      MyUtils().recordTransaction("Messae de succès", "Vous venez de recevoir une somme de ${newAmount.toString()} de la part de $fullname  ",true, "$idTrans",newAmount );
}
  }

  @override
  void dispose() {
    super.dispose();
    MyUtils.allScreen();
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
            onNotification: (_) {
          timer.handleUserInteraction(context);
          return false;
        },
      child: GestureDetector(
             onTap: () => timer.handleUserInteraction(context),
             onPanUpdate: (_) => timer.handleUserInteraction(context),
        child: WillPopWidget(
          nextRoute: RouteHelper.bottomNavBar,
          child: Scaffold(
              backgroundColor: MyColor.successBG,
              body: SizedBox(
                // color: MyColor.colorWhite,
                height: MediaQuery.of(context).size.height,
                child: const Center(
                  child: CustomLoader(
                    isFullScreen: true,
                  ),
                ),
              )),
        ),
      ),
    );
  }
}
