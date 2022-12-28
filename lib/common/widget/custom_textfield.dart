import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../resources/colors.dart';
import '../resources/styles.dart';
import '../utils/common_functions.dart';
import '../utils/dimen.dart';

abstract class TextFormFieldCustom extends StatefulWidget {
  final String? labelText;
  final String? hintText;
  final InputDecoration? decoration;
  final TextEditingController? controller;
  final TextInputAction? textInputAction;
  final TextInputType? keyboardType;
  final BuildContext? buildContext;
  final FocusNode? focusNode;
  final String? validation;
  final bool? isEnable;
  final bool? obscureText;
  final int? minLines;
  final int? maxLines;
  final Function? onFieldSubmitted;
  final Function? onChangeField;
  final String? optionalText;
  final TextCapitalization? textCapitalization;
  final Widget? rightWidget;
  final List<String>? listOfAddresses;
  final List<TextInputFormatter>? listOfInputFormatter;
  final Widget? button;
  final double? height;
  TextStyle? hintTextStyle;
  TextStyle? labelTextStyle;
  EdgeInsets? paddingForLabelText;
  EdgeInsets? contentPadding;
  double? borderRadius;
  Function? onPress;
  Function? onSuffixIconPress;
  Widget? suffixWidget;
  bool? autoFocus;
  String? errorText;
  bool? isError;
  int? maxLength;
  String? initialValue;
  bool? btnState;
  bool? showSuffixIcon = false;

  TextFormFieldCustom(
      {this.decoration,
        this.labelText,
        this.optionalText,
        this.rightWidget,
        this.minLines,
        this.maxLines,
        this.hintText,
        this.errorText = "",
        this.isError = false,
        this.onFieldSubmitted,
        this.onChangeField,
        this.button,
        this.hintTextStyle,
        this.borderRadius,
        this.labelTextStyle,
        this.paddingForLabelText,
        this.contentPadding,
        this.maxLength = 255,
        this.obscureText,
        this.autoFocus = false,
        this.isEnable,
        this.height,
        this.textCapitalization,
        this.listOfInputFormatter,
        this.focusNode,
        this.controller,
        this.validation,
        this.textInputAction,
        this.keyboardType,
        this.buildContext,
        this.suffixWidget,
        this.onPress,
        this.onSuffixIconPress,
        this.initialValue,
        this.btnState,
        this.showSuffixIcon = false,
        this.listOfAddresses});
}

class TextFieldSearchCustom extends TextFormFieldCustom {
  TextFieldSearchCustom(
      {InputDecoration? decoration,
        labelText,
        isEnable,
        focusNode,
        controller,
        maxLines,
        hintText,
        minLines,
        validation,
        obscureText,
        isError,
        autoFocus,
        maxLength,
        onFieldSubmitted,
        onChangeField,
        errorText,
        height,
        hintTextStyle,
        textCapitalization,
        listOfInputFormatter,
        optionalText,
        rightWidget,
        textInputAction,
        keyboardType,
        onSuffixIconPress,
        showSuffixIcon,
        buildContext})
      : super(
    decoration: decoration,
    labelText: labelText,
    hintText: hintText,
    isEnable: isEnable,
    focusNode: focusNode,
    isError: isError,
    height: height,
    errorText: errorText,
    maxLength: maxLength,
    onFieldSubmitted: onFieldSubmitted,
    onChangeField: onChangeField,
    obscureText: obscureText,
    autoFocus: autoFocus,
    optionalText: optionalText,
    hintTextStyle: hintTextStyle,
    listOfInputFormatter: listOfInputFormatter,
    rightWidget: rightWidget,
    textCapitalization: textCapitalization,
    minLines: minLines,
    maxLines: maxLines,
    controller: controller,
    validation: validation,
    textInputAction: textInputAction,
    keyboardType: keyboardType,
    onSuffixIconPress: onSuffixIconPress,
    showSuffixIcon: showSuffixIcon,
    buildContext: buildContext,
  );

  @override
  State<StatefulWidget> createState() => _TextFieldSearchCustomState();
}

class _TextFieldSearchCustomState extends State<TextFieldSearchCustom> {
  bool isMainFieldFocused = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        (widget.labelText?.isEmpty ?? true)
            ? Container()
            : Row(
          children: [
            Padding(
              padding:
              const EdgeInsets.symmetric(horizontal: Spacing.xSmall),
              child: Text(
                widget.labelText ?? "",
                style: TextStyles.textFieldLabelStyle
                    .copyWith(color: MAColors.textColor.withOpacity(.61)),
              ),
            ),
            const Spacer(),
            widget.optionalText != null
                ? Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0),
              child: Text(
                widget.optionalText ?? "",
                style: TextStyles.textFieldLabelStyle.copyWith(
                    color: MAColors.textColor.withOpacity(.61)),
              ),
            )
                : Container(),
            widget.rightWidget != null ? widget.rightWidget! : Container()
          ],
        ),
        const SizedBox(
          height: Spacing.xxxSmall,
        ),
        Focus(
          onFocusChange: (value) {
            isMainFieldFocused = value;
          },
          child: Center(
            child: Container(
              height: widget.height ?? Spacing.JUMBO50,
              padding: const EdgeInsets.only(
                //right: Spacing.xSmall,
                left: Spacing.xSmall,
              ),
              decoration: BoxDecoration(
                  color: MAColors.whiteColor,
                  borderRadius:
                  BorderRadius.circular(RadiusConst.circularRadius8),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        spreadRadius: 3,
                        blurRadius: 5,
                        offset: const Offset(1, 4))
                  ],
                  border: Border.all(width: 0.5, color: MAColors.textColor)),
              child: TextFormField(
                enabled: widget.isEnable ?? true,
                autofocus: widget.autoFocus ?? false,
                decoration:
                (widget.decoration ?? const InputDecoration()).copyWith(
                  fillColor: (widget.isEnable ?? true)
                      ? Colors.transparent
                      : MAColors.textColor,
                  prefixIcon: Container(
                    padding: const EdgeInsets.only(right: 10),
                    height: 10,
                    width: 10,
                    child: const Padding(
                        padding: EdgeInsets.all(Spacing.xSmall11),
                        child: Icon(
                          Icons.search,
                          color: MAColors.textColor,
                        )),
                  ),
                  border: InputBorder.none,
                  hintText: widget.hintText,
                  hintStyle: widget.hintTextStyle ??
                      TextStyles.textFieldStyle
                          .copyWith(color: MAColors.hintColor),
                  errorStyle: TextStyles.textFieldStyle
                      .copyWith(color: MAColors.alertRedColor),
                  errorBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  contentPadding: const EdgeInsets.only(
                      left: Spacing.xSmall,
                      right: Spacing.xSmall,
                      bottom: Spacing.normal14),
                ),
                controller: widget.controller,
                textAlignVertical: TextAlignVertical.bottom,
                textCapitalization: (widget.textCapitalization != null)
                    ? widget.textCapitalization!
                    : widget.keyboardType == TextInputType.name
                    ? TextCapitalization.words
                    : TextCapitalization.none,
                textInputAction: widget.textInputAction,
                inputFormatters: widget.listOfInputFormatter ?? [],
                cursorColor: MAColors.hintTextColor,
                obscureText: (widget.obscureText ?? false),
                obscuringCharacter: "*",
                minLines: widget.minLines ?? 1,
                maxLines: widget.maxLines ?? 1,
                maxLength: widget.maxLength,
                onChanged: (value) {
                  if (widget.onChangeField != null) {
                    widget.onChangeField!(value);
                    return;
                  }
                },
                onFieldSubmitted: (value) {
                  if (widget.onFieldSubmitted != null) {
                    widget.onFieldSubmitted!(value);
                    return;
                  }

                  if (widget.focusNode != null) {}

                  (widget.textInputAction != null &&
                      widget.textInputAction == TextInputAction.next)
                      ? FocusScope.of(widget.buildContext ?? context)
                      .nextFocus()
                      : FocusScope.of(widget.buildContext ?? context)
                      .nextFocus();
                },
                validator: (value) {
                  return widget.validation;
                },
                focusNode: widget.focusNode,
                keyboardType: widget.keyboardType,
                style: TextStyles.textFieldStyle
                    .copyWith(color: MAColors.textColor),
              ),
            ),
          ),
        ),
        SizedBox(
          height: (widget.isError ?? false) ? 10 : 0,
        ),
        (widget.isError ?? false) ? errorWidget(widget.errorText) : Container()
      ],
    );
  }
}
