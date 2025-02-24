import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:viserpay/core/utils/dimensions.dart';
import 'package:viserpay/core/utils/my_color.dart';
import 'package:viserpay/core/utils/style.dart';
import 'package:viserpay/core/utils/util.dart';
import 'package:viserpay/view/components/text/label_text.dart';

class CustomTextField extends StatefulWidget {
  final String? labelText;
  final String? hintText;
  final String? instruction;
  final Function? onChanged;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final FocusNode? nextFocus;
  final FormFieldValidator? validator;
  final TextInputType? textInputType;
  final bool isEnable;
  final bool isPassword;
  final bool isShowSuffixIcon;
  final bool isIcon;
  final VoidCallback? onSuffixTap;
  final bool isSearch;
  final bool isCountryPicker;
  final TextInputAction inputAction;
  final bool needOutlineBorder;
  final bool readOnly;
  final bool needRequiredSign;
  final int? maxLines;
  final bool animatedLabel;
  final Color fillColor;
  Color? focusColor = MyColor.getTextFieldEnableBorder();
  final bool isRequired;
// edited /20-7-23
  final Widget? prefixicon;
  final Widget? suffixWidget;
  final BoxConstraints? suffixIconConstraints;
  final bool? isDense;
  final bool? isPin;
  // edited /29-7-2023
  final bool isborderNone;
  final VoidCallback? onSubmit;
  final VoidCallback? onTap;
  // edited /28-10-2023
  List<TextInputFormatter>? inputFormatters;
  final bool shadowBox;
  double? radius;
  CustomTextField({
    super.key,
    this.labelText,
    this.readOnly = false,
    this.fillColor = MyColor.transparentColor,
    this.focusColor,
    required this.onChanged,
    this.hintText,
    this.controller,
    this.focusNode,
    this.nextFocus,
    this.validator,
    this.textInputType,
    this.isEnable = true,
    this.isPassword = false,
    this.isShowSuffixIcon = false,
    this.isIcon = false,
    this.onSuffixTap,
    this.isSearch = false,
    this.isCountryPicker = false,
    this.inputAction = TextInputAction.next,
    this.needOutlineBorder = false,
    this.needRequiredSign = false,
    this.maxLines = 1,
    this.animatedLabel = false,
    this.isRequired = false,
    this.prefixicon,
    this.suffixWidget,
    this.suffixIconConstraints,
    this.isDense,
    this.isborderNone = false,
    this.isPin = false,
    this.onSubmit,
    this.instruction,
    this.radius = Dimensions.mediumRadius,
    this.inputFormatters,
    this.shadowBox = false,
    this.onTap,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool obscureText = true;

// build the state
  @override
  Widget build(BuildContext context) {
    return widget.needOutlineBorder
        ? widget.animatedLabel
            ? widget.shadowBox == false
                ? TextFormField(
                    maxLines: widget.maxLines,
                    readOnly: widget.readOnly,
                    style: regularDefault.copyWith(color: MyColor.getTextColor()),
                    //textAlign: TextAlign.left,
                    cursorColor: MyColor.getTextColor(),
                    controller: widget.controller,
                    autofocus: false,
                    textInputAction: widget.inputAction,
                    enabled: widget.isEnable,
                    focusNode: widget.focusNode,
                    validator: widget.validator,
                    keyboardType: widget.textInputType,
                    obscureText: widget.isPassword ? obscureText : false,
                    inputFormatters: widget.inputFormatters,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsetsDirectional.only(top: 5, start: 15, end: 15, bottom: 5),
                      labelText: widget.labelText?.tr ?? '',
                      labelStyle: regularDefault.copyWith(color: MyColor.getLabelTextColor()),
                      fillColor: widget.fillColor,
                      filled: true,
                      hintText: widget.hintText?.tr ?? '',
                      border: OutlineInputBorder(
                        borderSide: BorderSide(width: 0.5, color: MyColor.getTextFieldDisableBorder()),
                        borderRadius: BorderRadius.circular(widget.radius!),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          width: 0.5,
                          color: widget.focusColor ?? MyColor.getTextFieldEnableBorder(),
                        ),
                        borderRadius: BorderRadius.circular(widget.radius!),
                      ),
                      enabledBorder: OutlineInputBorder(borderSide: BorderSide(width: 0.5, color: MyColor.getTextFieldDisableBorder()), borderRadius: BorderRadius.circular(widget.radius!)),
                      suffixIconConstraints: widget.suffixIconConstraints,
                      suffixIcon: widget.isShowSuffixIcon
                          ? widget.isPassword
                              ? IconButton(icon: Icon(obscureText ? Icons.visibility_off : Icons.visibility, color: MyColor.hintTextColor, size: 20), onPressed: _toggle)
                              : widget.isIcon
                                  ? IconButton(
                                      onPressed: widget.onSuffixTap,
                                      icon: Icon(
                                        widget.isSearch
                                            ? Icons.search_outlined
                                            : widget.isCountryPicker
                                                ? Icons.arrow_drop_down_outlined
                                                : Icons.camera_alt_outlined,
                                        size: 25,
                                        color: MyColor.getPrimaryColor(),
                                      ),
                                    )
                                  : widget.suffixWidget
                          : null,
                    ),
                    onFieldSubmitted: (text) => widget.nextFocus != null ? FocusScope.of(context).requestFocus(widget.nextFocus) : null,
                    onChanged: (text) => widget.onChanged!(text),
                    onTap: widget.onTap,
                  )
                : Stack(
                    children: [
                      Container(
                        height: 47,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(color: MyColor.getCardBgColor(), borderRadius: BorderRadius.circular(widget.radius! + 2), boxShadow: MyUtils.getShadow2(blurRadius: 5)),
                      ),
                      TextFormField(
                        maxLines: widget.maxLines,
                        readOnly: widget.readOnly,
                        style: regularDefault.copyWith(color: MyColor.getTextColor()),
                        textAlign: TextAlign.left,
                        cursorColor: MyColor.colorBlack,
                        controller: widget.controller,
                        autofocus: false,
                        textInputAction: widget.inputAction,
                        enabled: widget.isEnable,
                        focusNode: widget.focusNode,
                        validator: widget.validator,
                        keyboardType: widget.textInputType,
                        obscureText: widget.isPassword ? obscureText : false,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.only(top: 5, left: 15, right: 15, bottom: 5),
                          labelText: widget.labelText,
                          labelStyle: regularDefault.copyWith(color: MyColor.getLabelTextColor()),
                          fillColor: widget.fillColor,
                          filled: true,
                          border: OutlineInputBorder(borderSide: const BorderSide(color: MyColor.textFieldDisableBorderColor, width: .5), borderRadius: BorderRadius.circular(widget.radius!)),
                          focusedBorder: OutlineInputBorder(borderSide: const BorderSide(color: MyColor.textFieldEnableBorderColor, width: .5), borderRadius: BorderRadius.circular(widget.radius!)),
                          enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: MyColor.getTextFieldDisableBorder(), width: 0.5), borderRadius: BorderRadius.circular(widget.radius!)),
                          focusedErrorBorder: OutlineInputBorder(borderSide: const BorderSide(color: MyColor.colorRed, width: .5), borderRadius: BorderRadius.circular(widget.radius!)),
                          errorBorder: OutlineInputBorder(borderSide: const BorderSide(color: MyColor.colorRed, width: .5), borderRadius: BorderRadius.circular(widget.radius!)),
                          suffixIcon: widget.isShowSuffixIcon
                              ? widget.isPassword
                                  ? IconButton(icon: Icon(obscureText ? Icons.visibility_off : Icons.visibility, color: MyColor.getPrimaryColor(), size: 20), onPressed: _toggle)
                                  : widget.isIcon
                                      ? IconButton(
                                          onPressed: widget.onSuffixTap,
                                          icon: Icon(
                                            widget.isSearch
                                                ? Icons.search_outlined
                                                : widget.isCountryPicker
                                                    ? Icons.arrow_drop_down_outlined
                                                    : Icons.camera_alt_outlined,
                                            size: 25,
                                            color: MyColor.getPrimaryColor(),
                                          ),
                                        )
                                      : null
                              : null,
                        ),
                        onFieldSubmitted: (text) => widget.nextFocus != null ? FocusScope.of(context).requestFocus(widget.nextFocus) : null,
                        onChanged: (text) => widget.onChanged!(text),
                        onTap: widget.onTap,
                      ),
                    ],
                  )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  LabelText(
                    text: widget.labelText.toString(),
                    isRequired: widget.isRequired,
                    instruction: widget.instruction,
                  ),
                  const SizedBox(height: Dimensions.textToTextSpace),
                  TextFormField(
                    maxLines: widget.maxLines,
                    readOnly: widget.readOnly,
                    style: regularDefault.copyWith(color: MyColor.getTextColor()),
                    //textAlign: TextAlign.left,
                    cursorColor: MyColor.getTextColor(),
                    controller: widget.controller,
                    autofocus: false,
                    textInputAction: widget.inputAction,
                    enabled: widget.isEnable,
                    focusNode: widget.focusNode,
                    validator: widget.validator,

                    keyboardType: widget.textInputType,
                    obscureText: widget.isPassword ? obscureText : false,
                    inputFormatters: widget.inputFormatters,

                    decoration: InputDecoration(
                      contentPadding: const EdgeInsetsDirectional.only(top: 5, start: 15, end: 15, bottom: 5),
                      hintText: widget.hintText != null ? widget.hintText!.tr : '',
                      hintStyle: regularLarge.copyWith(
                        color: MyColor.getHintTextColor().withOpacity(0.7),
                      ),
                      fillColor: MyColor.transparentColor,
                      filled: true,
                      border: OutlineInputBorder(borderSide: BorderSide(width: 0.5, color: MyColor.getTextFieldDisableBorder()), borderRadius: BorderRadius.circular(widget.radius!)),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          width: 0.5,
                          color: widget.focusColor ?? MyColor.getTextFieldEnableBorder(),
                        ),
                        borderRadius: BorderRadius.circular(widget.radius!),
                      ),
                      enabledBorder: OutlineInputBorder(borderSide: BorderSide(width: 0.5, color: MyColor.getTextFieldDisableBorder()), borderRadius: BorderRadius.circular(widget.radius!)),
                      prefixIcon: widget.prefixicon,
                      isDense: widget.isDense,
                      suffixIconConstraints: widget.suffixIconConstraints,
                      suffixIcon: widget.isShowSuffixIcon
                          ? widget.isPassword
                              ? const SizedBox.shrink()
                              : widget.isIcon
                                  ? IconButton(
                                      onPressed: widget.onSuffixTap,
                                      icon: Icon(
                                        widget.isSearch
                                            ? Icons.search_outlined
                                            : widget.isCountryPicker
                                                ? Icons.arrow_drop_down_outlined
                                                : Icons.camera_alt_outlined,
                                        size: 25,
                                        color: MyColor.getPrimaryColor(),
                                      ),
                                    )
                                  : widget.suffixWidget
                          : null,
                    ),
                    onFieldSubmitted: (text) => widget.nextFocus != null
                        ? FocusScope.of(context).requestFocus(widget.nextFocus)
                        : widget.onSubmit != null
                            ? widget.onSubmit!()
                            : null,
                    onChanged: (text) => widget.onChanged!(text),
                    onTap: widget.onTap,
                  )
                ],
              )
        : widget.isborderNone
            ? TextFormField(
                maxLines: widget.maxLines,
                readOnly: widget.readOnly,
                style: regularDefault.copyWith(color: MyColor.getTextColor()),
                //textAlign: TextAlign.left,
                cursorColor: MyColor.getPrimaryColor(),
                controller: widget.controller,
                autofocus: false,
                textInputAction: widget.inputAction,
                enabled: widget.isEnable,
                focusNode: widget.focusNode,
                validator: widget.validator,
                keyboardType: widget.textInputType,
                obscureText: widget.isPassword ? obscureText : false,
                inputFormatters: widget.inputFormatters,

                decoration: InputDecoration(
                  isDense: widget.isDense,
                  contentPadding: const EdgeInsetsDirectional.only(top: 5, start: 0, end: 0, bottom: 0),
                  labelText: widget.labelText?.tr,
                  labelStyle: regularDefault.copyWith(color: MyColor.getLabelTextColor()),
                  fillColor: MyColor.transparentColor,
                  filled: true,
                  border: InputBorder.none,
                  hintText: widget.hintText != null ? widget.hintText!.tr : '',
                  hintStyle: regularLarge.copyWith(
                    color: MyColor.getHintTextColor().withOpacity(0.7),
                  ),
                  suffixIcon: widget.isShowSuffixIcon
                      ? widget.isPassword
                          ? IconButton(icon: Icon(obscureText ? Icons.visibility_off : Icons.visibility, color: MyColor.hintTextColor, size: 20), onPressed: _toggle)
                          : widget.isIcon
                              ? IconButton(
                                  onPressed: widget.onSuffixTap,
                                  icon: Icon(
                                    widget.isSearch
                                        ? Icons.search_outlined
                                        : widget.isCountryPicker
                                            ? Icons.arrow_drop_down_outlined
                                            : Icons.camera_alt_outlined,
                                    size: 25,
                                    color: MyColor.getPrimaryColor(),
                                  ),
                                )
                              : widget.suffixWidget
                      : null,
                ),
                onFieldSubmitted: (text) => widget.nextFocus != null ? FocusScope.of(context).requestFocus(widget.nextFocus) : null,
                onChanged: (text) => widget.onChanged!(text),
                onTap: widget.onTap,
              )
            : TextFormField(
                maxLines: widget.maxLines,
                readOnly: widget.readOnly,
                style: regularDefault.copyWith(color: MyColor.getTextColor()),
                //textAlign: TextAlign.left,
                cursorColor: MyColor.getHintTextColor(),
                controller: widget.controller,
                autofocus: false,
                textInputAction: widget.inputAction,
                enabled: widget.isEnable,
                focusNode: widget.focusNode,
                validator: widget.validator,
                keyboardType: widget.textInputType,
                obscureText: widget.isPassword ? obscureText : false,
                inputFormatters: widget.inputFormatters,

                decoration: InputDecoration(
                  isDense: widget.isDense,
                  contentPadding: const EdgeInsetsDirectional.only(top: 5, start: 0, end: 0, bottom: 5),
                  labelText: widget.labelText?.tr,
                  labelStyle: regularDefault.copyWith(color: MyColor.getLabelTextColor()),
                  fillColor: MyColor.transparentColor,
                  filled: true,
                  border: UnderlineInputBorder(
                    borderSide: BorderSide(width: 0.5, color: MyColor.getTextFieldDisableBorder()),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      width: 0.5,
                      color: widget.focusColor ?? MyColor.getTextFieldEnableBorder(),
                    ),
                    borderRadius: BorderRadius.circular(widget.radius!),
                  ),
                  enabledBorder: UnderlineInputBorder(borderSide: BorderSide(width: 0.5, color: MyColor.getTextFieldDisableBorder())),
                  suffixIcon: widget.isShowSuffixIcon
                      ? widget.isPassword
                          ? IconButton(icon: Icon(obscureText ? Icons.visibility_off : Icons.visibility, color: MyColor.hintTextColor, size: 20), onPressed: _toggle)
                          : widget.isIcon
                              ? IconButton(
                                  onPressed: widget.onSuffixTap,
                                  icon: Icon(
                                    widget.isSearch
                                        ? Icons.search_outlined
                                        : widget.isCountryPicker
                                            ? Icons.arrow_drop_down_outlined
                                            : Icons.camera_alt_outlined,
                                    size: 25,
                                    color: MyColor.getPrimaryColor(),
                                  ),
                                )
                              : widget.suffixWidget
                      : null,
                ),
                onFieldSubmitted: (text) => widget.nextFocus != null ? FocusScope.of(context).requestFocus(widget.nextFocus) : null,
                onChanged: (text) => widget.onChanged!(text),
                onTap: widget.onTap,
              );
  }

  void _toggle() {
    setState(() {
      obscureText = !obscureText;
    });
  }
}
