import 'package:flutter/material.dart';
import 'package:shopywell/app/core/constants/app_color.dart';

class CustomTextfield extends StatelessWidget {
  const CustomTextfield({
    super.key,
    required this.controller,
    required this.hintText,
    this.keyboardType,
    this.labelText,
    this.readOnly = false,
    this.prefix,
    this.validator,
    this.suffix,
    this.onChanged,
  });

  final TextEditingController controller;
  final String hintText;
  final TextInputType? keyboardType;
  final String? labelText;
  final bool readOnly;
  final Widget? prefix;
  final Widget? suffix;
  final FormFieldValidator<String>? validator;
  final Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      readOnly: readOnly,
      controller: controller,
      keyboardType: keyboardType,
      onChanged: onChanged,
      decoration: InputDecoration(
        prefixIcon: prefix,
        suffixIcon: suffix,
        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 13),
        hintText: hintText,
        labelText: labelText,
        hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: AppColors.greyColor,
            ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(46),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(46),
          borderSide: BorderSide(color: AppColors.greyColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(46),
          borderSide: BorderSide(color: AppColors.primaryColor),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(46),
          borderSide: BorderSide(color: AppColors.redColor),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(46),
          borderSide: BorderSide(color: AppColors.redColor),
        ),
      ),
    );
  }
}

class CustomTextfieldPreference extends StatelessWidget {
  const CustomTextfieldPreference({
    super.key,
    required this.controller,
    required this.hintText,
    this.keyboardType,
  });

  final TextEditingController controller;
  final String hintText;
  final TextInputType? keyboardType;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        // style: TextStyle(color: AppColors.primaryColor, fontSize: 16),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 15),
          hintText: hintText,
          hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: AppColors.greyColor.withOpacity(0.7),
                fontSize: 14,
              ),
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(color: AppColors.greyColor.withOpacity(0.4)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(color: AppColors.primaryColor, width: 2),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(color: AppColors.redColor),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(color: AppColors.redColor, width: 2),
          ),
        ),
      ),
    );
  }
}
