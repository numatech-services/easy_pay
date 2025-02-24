import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:viserpay/core/helper/date_converter.dart';
import 'package:viserpay/core/helper/string_format_helper.dart';
import 'package:viserpay/core/utils/dimensions.dart';
import 'package:viserpay/core/utils/my_color.dart';
import 'package:viserpay/core/utils/my_strings.dart';
import 'package:viserpay/core/utils/util.dart';
import 'package:viserpay/data/controller/add_money/add_money_history_controller.dart';
import 'package:viserpay/view/components/bottom-sheet/custom_bottom_sheet.dart';
import 'package:viserpay/view/components/column_widget/card_column.dart';
import 'package:viserpay/view/components/divider/custom_divider.dart';
import 'package:viserpay/view/screens/add-money/add_money_history/widget/add_money_history_bottom_sheet.dart';
import 'package:viserpay/view/screens/add-money/add_money_history/widget/status_widget.dart';

class AddMoneyHistoryCard extends StatelessWidget {
  final int index;
  const AddMoneyHistoryCard({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddMoneyHistoryController>(
      builder: (controller) => GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
          CustomBottomSheet(child: AddMoneyHistoryBottomSheet(index: index)).customBottomSheet(context);
        },
        child: Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.symmetric(horizontal: Dimensions.space15, vertical: Dimensions.space15),
          decoration: BoxDecoration(color: MyColor.colorWhite, borderRadius: BorderRadius.circular(Dimensions.defaultRadius), boxShadow: MyUtils.getCardShadow()),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CardColumn(header: MyStrings.trx, body: controller.depositList[index].trx ?? ""),
                  CardColumn(alignmentEnd: true, header: MyStrings.date.tr, body: DateConverter.isoStringToLocalDateOnly(controller.depositList[index].createdAt ?? "")),
                ],
              ),
              const CustomDivider(space: Dimensions.space10),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [CardColumn(header: MyStrings.amount.tr, body: "${StringConverter.formatNumber(controller.depositList[index].amount ?? "")} ${controller.currency}"), StatusWidget(status: controller.getStatusOrColor(index), color: controller.getStatusOrColor(index, isStatus: false))],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
