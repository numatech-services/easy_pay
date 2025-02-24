import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:viserpay/core/utils/dimensions.dart';
import 'package:viserpay/core/utils/my_color.dart';
import 'package:viserpay/core/utils/style.dart';
import 'package:viserpay/view/components/text/label_text.dart';

class CustomAmountTextField extends StatefulWidget {
  const CustomAmountTextField({super.key, required this.labelText, required this.hintText, this.controller, this.chargeText = '', required this.currency, required this.onChanged, this.autoFocus = false, this.inputAction, this.readOnly = false, this.isRequired = false, this.labelWidget, this.fillColor, this.borderRadius});

  final bool isRequired;
  final String chargeText;
  final Widget? labelWidget;
  final String labelText;
  final String hintText;
  final String currency;
  final bool autoFocus;
  final bool readOnly;
  final Color? fillColor;
  final Function(String) onChanged;
  final TextEditingController? controller;
  final TextInputAction? inputAction;
  final BorderRadiusGeometry? borderRadius;

  @override
  State<CustomAmountTextField> createState() => _CustomAmountTextFieldState();
}

class _CustomAmountTextFieldState extends State<CustomAmountTextField> {
  bool isFocus = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.labelWidget == null) ...[
          LabelText(text: widget.labelText.tr, isRequired: widget.isRequired),
        ] else ...[
          widget.labelWidget!
        ],
        const SizedBox(height: 8),
        Container(
          height: 50,
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.symmetric(horizontal: Dimensions.space15, vertical: 6),
          decoration: BoxDecoration(color: widget.fillColor ?? MyColor.getTransparentColor(), border: Border.all(color: isFocus ? MyColor.getTextFieldEnableBorder() : MyColor.getTextFieldDisableBorder(), width: 0.5), borderRadius: widget.borderRadius ?? BorderRadius.circular(Dimensions.defaultRadius)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                flex: 5,
                child: FocusScope(
                  child: Focus(
                    onFocusChange: (focus) {
                      setState(() {
                        isFocus = focus;
                      });
                    },
                    child: TextFormField(
                      cursorColor: MyColor.colorBlack,
                      readOnly: widget.readOnly,
                      controller: widget.controller,
                      autofocus: widget.autoFocus,
                      style: regularDefault.copyWith(color: MyColor.getTextColor()),
                      //textAlign: TextAlign.left,
                      keyboardType: TextInputType.number,
                      textInputAction: widget.inputAction,
                      onChanged: widget.onChanged,
                      decoration: InputDecoration(
                          contentPadding: const EdgeInsetsDirectional.only(bottom: 16),
                          hintText: widget.hintText,
                          hintStyle: regularSmall.copyWith(color: MyColor.hintTextColor.withOpacity(0.7), height: 1.452),
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          focusedErrorBorder: InputBorder.none,
                          errorBorder: InputBorder.none),
                    ),
                  ),
                ),
              ),
              Container(
                // width: 48,
                padding: const EdgeInsets.all(Dimensions.space5),
                decoration: BoxDecoration(color: MyColor.getPrimaryColor().withOpacity(0.05), borderRadius: BorderRadius.circular(5)),
                alignment: Alignment.center,
                child: Text(widget.currency, textAlign: TextAlign.center, style: regularDefault.copyWith(color: MyColor.getPrimaryColor(), fontWeight: FontWeight.w500)),
              )
            ],
          ),
        ),
      ],
    );
  }
}
