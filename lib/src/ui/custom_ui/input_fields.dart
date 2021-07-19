import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gin_finans_app/src/values/app_colors.dart';

import 'input_decoration.dart';

// ignore: must_be_immutable
class InputFieldArea extends StatelessWidget {
  final String? hint;
  final String? error;
  final String? initialValue;
  final bool? obscure;
  final IconData? icon;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final FocusNode? firstFocus;
  final FocusNode? nextFocus;
  TextInputAction? textAction;
  TextInputType? inputType;
  OnValueChanged? onValueChanged;
  OnFieldError? onFieldError;
  OnKeyBoardKeyEvent? onKeyBoardKeyEvent;
  TextEditingController? textEditingController;
  String? inputFormatterType;
  bool? requiredTapEvent;
  bool? disabled = true;
  bool? isEmpty = false;
  String? prefixText;
  String? suffix;
  final RegExp? regex;
  final RegExp? onlyNumberRegex;
  final String? regexError;
  FormFieldValidator<String>? validator;
  int? maxLength;
  int? maxLines;
  String? counterText;
  final TextCapitalization? textCapitalization;
  double? borderRadius;

  /// calender date format
  String? dateFormat;

  /// Enable calender from  - to year
  int? fromYear = 80;
  int? toYear = 0;

  InputFieldArea(
      {this.hint,
      this.obscure,
      this.textEditingController,
      this.icon,
      this.disabled,
      this.isEmpty,
      this.error,
      this.suffix,
      this.maxLength,
      this.maxLines,
      this.counterText,
      this.regex,
      this.validator,
      this.onlyNumberRegex,
      this.textCapitalization,
      this.initialValue,
      this.firstFocus,
      this.regexError,
      this.nextFocus,
      this.textAction,
      this.inputType,
      this.onKeyBoardKeyEvent,
      this.onValueChanged,
      this.inputFormatterType,
      this.requiredTapEvent,
      this.suffixIcon,
      this.borderRadius,
      this.prefixIcon,
      this.prefixText,
      this.dateFormat,
      this.onFieldError,
      this.fromYear,
      this.toYear});

  Future<Null> _selectDate(BuildContext context) async {
    DateTime selectedDate = DateTime.now();
    int fromYr = selectedDate.year - fromYear!;
    int toYr = selectedDate.year - toYear!;
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime(toYr, selectedDate.month, selectedDate.day),
        firstDate: DateTime(fromYr, selectedDate.month, selectedDate.day),
        lastDate: DateTime(toYr, selectedDate.month, selectedDate.day));
    selectedDate = picked!;
    // String dob = new DateFormat(dateFormat).format(selectedDate);
    textEditingController!.text = selectedDate.timeZoneName;
    onValueChanged!(selectedDate.timeZoneName);
  }

  void selectedValue(BuildContext context) {
    if (requiredTapEvent != null && requiredTapEvent!) _selectDate(context);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: AppInputDecoration().getCommonPaddingForField(),
        child: TextFormField(
          obscureText: obscure!,
          enabled: disabled == null || !disabled!,
          initialValue: initialValue,
          onTap: () => selectedValue(context),
          keyboardType: inputType,
          style: Theme.of(context).textTheme.headline5!.copyWith(color: AppColors.labelBlack),
          controller: textEditingController,
          focusNode: firstFocus,
          maxLines: maxLines != null ? maxLines : 1,
          maxLength: maxLength != null ? maxLength : null,
          readOnly: requiredTapEvent != null,
          textCapitalization: textCapitalization == null ? TextCapitalization.none : textCapitalization!,
          onFieldSubmitted: (term) {
            onKeyBoardKeyEvent!(textAction!);
          },
          onChanged: (text) {
            onValueChanged!(text.trim());
          },
          inputFormatters: [
            new FilteringTextInputFormatter(RegExp(" "), allow: false),
          ],
          onSaved: (newVale) {
            onValueChanged!(newVale!.trim());
          },
          textInputAction: textAction,
          validator: validator??(String? val) => getValidate(val!.trim()),
          decoration: AppInputDecoration().getDecoration(
              prefix: prefixText ?? '',
              prefixIcon: prefixIcon ?? null,
              suffixIcon: suffixIcon ?? null,
              hint: hint!,
              floatingLabelBehavior: FloatingLabelBehavior.never,
              borderRadius: borderRadius ?? 10.0,
              counterText: counterText ?? "",
              suffix: Text(suffix ?? '')),
        ),
      ),
    );
  }

  String? getValidate(String? val) {
    if (isEmpty != null && isEmpty!) {
      if (val != null && val.isNotEmpty) {
        if (regex != null && !regex!.hasMatch(val)) {
          if (onFieldError != null) onFieldError!(firstFocus != null ? firstFocus! : FocusNode());
          return (regexError == null || regexError!.isEmpty) ? "error" : regexError;
        } else if (val.isEmpty) {
          if (onFieldError != null) onFieldError!(firstFocus != null ? firstFocus! : FocusNode());
          return error == null || error!.isEmpty ? "error" : error;
        }
      }
    } else {
      if (val == null || val.isEmpty) {
        if (onFieldError != null) onFieldError!(firstFocus != null ? firstFocus! : FocusNode());
        return error == null || error!.isEmpty ? "error" : error;
      } else if (regex != null && !regex!.hasMatch(val)) {
        if (onFieldError != null) onFieldError!(firstFocus != null ? firstFocus! : FocusNode());
        return (regexError == null || regexError!.isEmpty) ? "error" : regexError;
      }
    }
  }
}

typedef OnValueChanged = void Function(String newValue);
typedef OnFieldError = void Function(FocusNode focusNode);
typedef OnKeyBoardKeyEvent = void Function(TextInputAction event);

class LengthLimitingTextFieldFormatterFixed extends LengthLimitingTextInputFormatter {
  LengthLimitingTextFieldFormatterFixed(int maxLength) : super(maxLength);

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (maxLength != null && maxLength! > 0 && newValue.text.characters.length > maxLength!) {
      // If already at the maximum and tried to enter even more, keep the old
      // value.
      if (oldValue.text.characters.length == maxLength) {
        return oldValue;
      }
      // ignore: invalid_use_of_visible_for_testing_member
      return LengthLimitingTextInputFormatter.truncate(newValue, maxLength!);
    }
    return newValue;
  }
}

///Only two digit will allow after decimal
class DecimalTextInputFormatter extends TextInputFormatter {
  DecimalTextInputFormatter({required this.decimalRange}) : assert(decimalRange! > 0);

  final int? decimalRange;

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue, // unused.
    TextEditingValue newValue,
  ) {
    TextSelection newSelection = newValue.selection;
    String truncated = newValue.text;

    if (decimalRange != null) {
      String value = newValue.text;
      if (value.contains(".") && value.substring(value.indexOf(".") + 1).length > decimalRange!) {
        truncated = oldValue.text;
        newSelection = oldValue.selection;
      } else if (value == ".") {
        truncated = "0.";

        newSelection = newValue.selection.copyWith(
          baseOffset: math.min(truncated.length, truncated.length + 1),
          extentOffset: math.min(truncated.length, truncated.length + 1),
        );
      }
      return TextEditingValue(
        text: truncated,
        selection: newSelection,
        composing: TextRange.empty,
      );
    }
    return newValue;
  }
}
