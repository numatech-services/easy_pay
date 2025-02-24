import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:viserpay/core/utils/dimensions.dart';
import 'package:viserpay/core/utils/my_color.dart';
import 'package:viserpay/core/utils/style.dart';
import '../../../../core/helper/string_format_helper.dart';

class FilterRowWidget extends StatefulWidget {
  final String text;
  final bool fromTrx;
  final Color iconColor;
  final Callback press;
  final bool isFilterBtn;
  final Color bgColor;
  final Color borderColor;
  final Color textColor;
  const FilterRowWidget({super.key, this.bgColor = MyColor.transparentColor, this.isFilterBtn = false, this.iconColor = MyColor.primaryColor, this.borderColor = MyColor.textFieldDisableBorderColor, this.textColor = MyColor.colorBlack, required this.text, required this.press, this.fromTrx = false});

  @override
  State<FilterRowWidget> createState() => _FilterRowWidgetState();
}

class _FilterRowWidgetState extends State<FilterRowWidget> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.press,
      child: Container(
        height: 50,
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(Dimensions.defaultRadius), color: widget.isFilterBtn ? MyColor.primaryColor : widget.bgColor, border: Border.all(color: widget.borderColor, width: widget.isFilterBtn ? 0 : 0.5)),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            widget.fromTrx
                ? Expanded(
                    child: Text(
                      StringConverter.replaceUnderscoreWithSpace(widget.text).tr,
                      // StringConverter.replaceUnderscoreWithSpace(widget.text).tr,
                      style: regularDefault.copyWith(overflow: TextOverflow.ellipsis, color: widget.isFilterBtn ? MyColor.colorBlack : MyColor.colorBlack),
                    ),
                  )
                : Expanded(
                    child: Text(
                      widget.text.tr,
                      style: regularDefault.copyWith(color: widget.textColor, overflow: TextOverflow.ellipsis),
                    ),
                  ),
            const SizedBox(
              width: 20,
            ),
            Icon(Icons.arrow_drop_down, color: widget.iconColor)
          ],
        ),
      ),
    );
  }
}
