import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextField extends StatelessWidget {
  final void Function(String?)? onSaved;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final Widget prefixIcon;
  final Widget? suffixIcon;
  final String? hintText;
  final String? labelText;
  final TextInputType textInputType;
  final TextInputAction inputAction;
  final bool filled;
  final bool isHidden;
  final VoidCallback? onTap;
  final Function(String)? onChanged;
  final List<TextInputFormatter>? inputFormatter;
  final bool addBorder;
  const CustomTextField({
    Key? key,
    this.onSaved,
    this.addBorder = true,
    this.isHidden = false,
    this.filled = false,
    this.inputFormatter,
    this.validator,
    this.controller,
    this.onChanged,
    required this.prefixIcon,
    this.suffixIcon,
    this.hintText,
    this.labelText,
    this.textInputType = TextInputType.text,
    this.inputAction = TextInputAction.next,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      inputFormatters: inputFormatter,
      onSaved: onSaved,
      validator: validator,
      obscureText: isHidden,
      keyboardType: textInputType,
      controller: controller,
      textInputAction: inputAction,
      onTap: onTap,
      onChanged: onChanged,
      style: GoogleFonts.poppins(
        fontWeight: FontWeight.w700,
        fontSize: 20,
      ),
      decoration: InputDecoration(
        filled: filled,
        labelText: labelText,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        hintText: hintText,
        hintStyle: GoogleFonts.poppins(
          fontWeight: FontWeight.w700,
          fontSize: 20,
          color: Theme.of(context).hintColor
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(11),
          borderSide: BorderSide(
            width: 1,
            color: Theme.of(context).colorScheme.error,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(11),
          borderSide: BorderSide(
          width: 2,
          color: Theme.of(context).colorScheme.error,
        ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: addBorder
              ? BorderSide(
                  color: Get.isDarkMode ? Colors.white : Colors.black87,
                )
              : const BorderSide(
                  width: 0,
                  color: Colors.transparent,
                ),
        ),
        fillColor: Theme.of(context).cardColor,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: addBorder
              ? BorderSide(
                  color: Get.isDarkMode ? Colors.white : Colors.black87,
                  width: 2.0,
                )
              : const BorderSide(
                  width: 0,
                  color: Colors.transparent,
                ),
        ),
      ),
    );
  }
}
