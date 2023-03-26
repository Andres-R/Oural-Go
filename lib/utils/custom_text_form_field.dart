import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';

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
      style: TextStyle(color: Colors.black),
      cursorColor: Colors.black,
      textInputAction: next ? TextInputAction.next : TextInputAction.done,
      onSaved: (value) {
        controller.text = value!;
      },
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(horizontal: 16),
        enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(30.0)),
          borderSide: BorderSide(color: Colors.black),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(30.0)),
          borderSide: BorderSide(color: Colors.black),
        ),
        prefixText: enableCurrencyMode ? _currency : '',
        prefixIcon: Icon(icon, color: Colors.black),
        hintText: hint,
        hintStyle: TextStyle(color: Colors.grey),
        //labelText: hint,
        //labelStyle: TextStyle(color: Colors.grey.shade700),
        fillColor: Colors.white,
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
      color: Colors.white,
      child: Align(
        alignment: Alignment.centerRight,
        child: MaterialButton(
          onPressed: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: Text(
            "Done",
            style: TextStyle(
              color: Colors.black,
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
