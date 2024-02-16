import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_multi_formatter/formatters/currency_input_formatter.dart';

// ignore: must_be_immutable
class TextFieldWidget extends StatelessWidget {
  TextFieldWidget({
    Key? key,
    required this.texttFieldController,
    required this.hintText,
    this.obscureText = false,
    this.formatPrice = false,
    this.allowBlanks = false,
    this.enabled = true,
    this.onSubmitted,
    this.onChanged,
    this.textInputType = TextInputType.name,
    this.prefixIcon,
    this.suffixIcon,
    this.contentPadding = 15,
  }) : super(key: key);

  final TextEditingController texttFieldController;
  final String hintText;
  Widget? prefixIcon;
  Widget? suffixIcon;
  bool? obscureText;
  bool? formatPrice;
  bool? allowBlanks;
  Function(String)? onSubmitted;
  Function(String)? onChanged;
  bool? enabled;
  double contentPadding;
  TextInputType? textInputType;

  List<TextInputFormatter>? inputFormatList() {
    if (allowBlanks == false) {
      if (formatPrice == true) {
        return [
          FilteringTextInputFormatter.deny(RegExp(r"\s\b|\b\s")),
          CurrencyInputFormatter(
              trailingSymbol: 'Tsh',
              useSymbolPadding: true,
              mantissaLength: 3 // the length of the fractional side
              )
        ];
      } else {
        return [
          FilteringTextInputFormatter.deny(RegExp(r"\s\b|\b\s")),
        ];
      }
    } else if (formatPrice == true) {
      if (allowBlanks == true) {
        return [
          FilteringTextInputFormatter.deny(RegExp(r"\s\b|\b\s")),
          CurrencyInputFormatter(
              trailingSymbol: 'Tsh',
              useSymbolPadding: true,
              mantissaLength: 3 // the length of the fractional side
              )
        ];
      } else {
        return [
          CurrencyInputFormatter(
              trailingSymbol: 'Tsh',
              useSymbolPadding: true,
              mantissaLength: 3 // the length of the fractional side
              )
        ];
      }
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: textInputType,
      controller: texttFieldController,
      obscureText: obscureText!,
      onSubmitted: onSubmitted,
      onChanged: onChanged,
      inputFormatters: inputFormatList(),
      decoration: InputDecoration(
        hintText: hintText,
        suffixIcon: suffixIcon,

        disabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(width: 0.0),
            borderRadius: BorderRadius.circular(8)),
        hintStyle: const TextStyle(
          fontSize: 10,
        ),

        filled: true,
        isDense: true,
        enabled: enabled!,
        // focusColor: Colors.transparent,
        contentPadding: EdgeInsets.all(contentPadding),
        border: OutlineInputBorder(
            borderSide: const BorderSide(width: 0.0),
            borderRadius: BorderRadius.circular(8)),
      ),
    );
  }
}
