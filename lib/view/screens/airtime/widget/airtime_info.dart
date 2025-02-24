import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:viserpay/core/helper/string_format_helper.dart';
import 'package:viserpay/core/utils/dimensions.dart';
import 'package:viserpay/core/utils/my_color.dart';
import 'package:viserpay/core/utils/my_strings.dart';
import 'package:viserpay/data/controller/airtime/airtime_controller.dart';
import 'package:viserpay/view/components/divider/custom_divider.dart';
import 'package:viserpay/view/screens/add-money/add_money/widget/custom_row.dart';

class AirTimeInfoWidget extends StatelessWidget {
  const AirTimeInfoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AirtimeController>(
      builder: (controller) => Container(
        padding: const EdgeInsets.all(Dimensions.space17),
        margin: const EdgeInsets.symmetric(vertical: Dimensions.space15),
        decoration: BoxDecoration(color: MyColor.getCardBgColor(), borderRadius: BorderRadius.circular(Dimensions.mediumRadius), border: Border.all(color: MyColor.borderColor, width: .4)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomRow(
              showImage: true,
              isSvg: true,
              firstText: MyStrings.amount,
              lastText: "${StringConverter.formatNumber(controller.getAmount(), precision: 2)} ${controller.currency}",
            ),
            const CustomDivider(space: Dimensions.space15),
            // CustomRow(
            //   showImage: true,
            //   isSvg: true,
            //   firstText: MyStrings.charge,
            //   lastText: controller.charge,
            // ),
            // const CustomDivider(space: Dimensions.space15),
            // CustomRow(
            //   showImage: true,
            //   isSvg: true,
            //   firstText: MyStrings.conversionRate.tr,
            //   lastText: controller.conversionRate,
            // ),
            // const CustomDivider(space: Dimensions.space15),
            // CustomRow(
            //   showImage: true,
            //   isSvg: true,
            //   firstText: "${MyStrings.in_.tr} ${controller.selectedPaymentMethods.currency}",
            //   lastText: controller.inMethodPayable,
            // ),
            // const CustomDivider(space: Dimensions.space15),
            // CustomRow(
            //   showImage: true,
            //   isSvg: true,
            //   firstText: MyStrings.payable,
            //   lastText: controller.payableText,
            // ),
          ],
        ),
      ),
    );
  }
}
