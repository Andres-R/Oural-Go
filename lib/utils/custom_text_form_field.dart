import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:oural_go/utils/constants.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    Key? key,
    required this.controller,
    required this.hint,
    required this.icon,
    required this.obscureText,
    required this.inputType,
    required this.enableCurrencyMode,
    required this.next,
    required this.focusNode,
  }) : super(key: key);

  final String hint;
  final IconData icon;
  final TextEditingController controller;
  final TextInputType inputType;
  final bool obscureText;
  final bool enableCurrencyMode;
  final bool next;
  final FocusNode? focusNode;

  static const String _locale = 'en';

  String get _currency {
    return NumberFormat.compactSimpleCurrency(locale: _locale).currencySymbol;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: inputType,
      focusNode: focusNode,
      style: TextStyle(color: kTextColor),
      cursorColor: Colors.black,
      textInputAction: next ? TextInputAction.next : TextInputAction.done,
      onSaved: (value) {
        controller.text = value!;
      },
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(horizontal: kPadding),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(kBorderRadius + 5)),
          borderSide: BorderSide(color: kThemeColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(kBorderRadius + 5)),
          borderSide: BorderSide(color: kThemeColor),
        ),
        prefixText: enableCurrencyMode ? _currency : '',
        prefixIcon: Icon(icon, color: kThemeColor),
        hintText: hint,
        hintStyle: TextStyle(color: kAccentColor),
        //labelText: hint,
        //labelStyle: TextStyle(color: Colors.grey.shade700),
        fillColor: kMainBGcolor,
        filled: true,
        //floatingLabelBehavior: FloatingLabelBehavior.never,
      ),
      inputFormatters: enableCurrencyMode
          ? [
              CurrencyTextInputFormatter(
                decimalDigits: 2,
                symbol: '',
              ),
            ]
          : [],
    );
  }
}

class InputDoneView extends StatelessWidget {
  const InputDoneView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: kMainBGcolor,
      child: Align(
        alignment: Alignment.centerRight,
        child: MaterialButton(
          onPressed: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: Text(
            "Done",
            style: TextStyle(
              color: kTextColor,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}

class KeyboardOverlay {
  static OverlayEntry? _overlayEntry;

  static showOverlay(BuildContext context) {
    if (_overlayEntry != null) {
      return;
    }

    OverlayState? overlayState = Overlay.of(context);
    _overlayEntry = OverlayEntry(
      builder: (context) {
        return Positioned(
          bottom: MediaQuery.of(context).viewInsets.bottom,
          right: 0.0,
          left: 0.0,
          child: const InputDoneView(),
        );
      },
    );

    overlayState!.insert(_overlayEntry!);
  }

  static removeOverlay() {
    if (_overlayEntry != null) {
      _overlayEntry!.remove();
      _overlayEntry = null;
    }
  }
}
