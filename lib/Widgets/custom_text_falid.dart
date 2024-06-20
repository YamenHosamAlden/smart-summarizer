import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';
import 'package:smartsummarizer/Core/Constants/app_colors.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController controller;
  final String? hintText;
  final TextInputType textInputType;
  final int? maxLine;
  final FocusNode? focusNode;
  final FocusNode? nextNode;
  final TextInputAction? textInputAction;
  final bool isPhoneNumber;
  final String? Function(String?)? validator;
  final Color? fillColor;
  final TextCapitalization capitalization;
  final bool amountIcon;
  final bool? isDense;
  final bool enabled;
  final TextDirection? textDirection;
  final TextAlign textAlign;

  final bool isDescription;
  final bool isPassword;
  final Function(String text)? onChanged;
  final Widget? prefixIcon;
  final bool? isPos;

  final bool variant;
  final Color? iconColor;

  const CustomTextField({
    super.key,
    required this.controller,
    this.isDense,
    this.hintText,
    this.textAlign = TextAlign.start,
    this.validator,
    required this.textInputType,
    this.textDirection,
    this.maxLine,
    this.focusNode,
    this.enabled = true,
    this.iconColor,
    this.nextNode,
    this.textInputAction,
    this.isPhoneNumber = false,
    this.capitalization = TextCapitalization.none,
    this.fillColor,
    this.amountIcon = false,
    this.isDescription = false,
    this.onChanged,
    this.prefixIcon,
    this.isPassword = false,
    this.isPos = false,
    this.variant = false,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _obscureText = true;
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(context) {
    return TextFormField(
      enabled: widget.enabled,
      cursorColor: Theme.of(context).primaryColor,
      style: TextStyle(
        color: Theme.of(context).primaryColor,
        fontSize: 13.sp,
      ),
      controller: widget.controller,
      maxLines: widget.maxLine ?? 1,
      textCapitalization: widget.capitalization,
      focusNode: widget.focusNode,
      obscureText: widget.isPassword ? _obscureText : false,
      onChanged: widget.onChanged,
      inputFormatters:
          (widget.textInputType == TextInputType.phone || widget.isPhoneNumber)
              ? <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(RegExp('[0-9+]'))
                ]
              : null,
      //  [FilteringTextInputFormatter.allow(RegExp(r'[0-9.]'))],

      keyboardType: widget.textInputType,
      textInputAction: widget.textInputAction ?? TextInputAction.next,
      onFieldSubmitted: (v) {
        FocusScope.of(context).requestFocus(widget.nextNode);
      },
      validator: widget.validator,
      textAlign: widget.textAlign,
      textDirection: widget.textDirection,
      decoration: InputDecoration(
        prefixIconConstraints: BoxConstraints(
          minWidth: widget.variant ? 5 : 20,
          minHeight: widget.variant ? 5 : 20,
        ),
        prefixIcon: widget.prefixIcon,
        suffixIconConstraints: BoxConstraints(
          minWidth: widget.variant
              ? 5
              : widget.isPos!
                  ? 0
                  : 40,
          minHeight: widget.variant ? 5 : 20,
        ),
        suffixIcon: widget.isPassword
            ? GestureDetector(
                onTap: _toggle,
                child: Icon(
                  _obscureText ? Icons.visibility_off : Icons.visibility,
                  color: AppColors.borderColor,
                ))
            : const SizedBox.shrink(),
        hintText: widget.hintText ?? '',
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: AppColors.greyColor, width: 1.5),
          borderRadius: BorderRadius.circular(2.w),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: AppColors.primaryColor, width: 1.5),
          borderRadius: BorderRadius.circular(2.w),
        ),
        errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(2.w),
            borderSide: const BorderSide(color: AppColors.redColor,width: 1.5)),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(2.w),
            borderSide:
                const BorderSide(color: AppColors.greyColor, width: 1.5)),
        filled: widget.fillColor != null,
        fillColor: widget.fillColor,
        isDense: widget.isDense,
        contentPadding: EdgeInsets.symmetric(
            vertical: 1.5.h, horizontal: widget.variant ? 0 : 2.h),
        alignLabelWithHint: true,
        counterText: '',
        hintStyle: TextStyle(color: AppColors.hintColor, fontSize: 12.sp),
        errorStyle: const TextStyle(height: 1.5),
      ),
    );
  }
}
