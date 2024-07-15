import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../constants/base_colors.dart';
import '../functions/base_funcations.dart';

class CustomTextFormField extends StatelessWidget {
  final String? labelText;
  final Widget? prefixIcon;

  final Widget? suffixIcon;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final VoidCallback? onPressed;
  final ValueChanged<String>? onChanged;
  final String? errorText;
  final FocusNode? focusNode;
  final bool? obscureText;

  final bool? enabled;
  final bool? readOnly;
  final GestureTapCallback? onTap;
  final ValueChanged<String>? onFieldSubmitted;
  final BoxConstraints? prefixIconConstraints;
  final BoxConstraints? suffixIconConstraints;
  final TextStyle? hintStyle;
  final double? height;
  final TextInputAction? textInputAction;
  final TextInputType? keyboardType;

  const CustomTextFormField({super.key,
    required this.labelText,
    this.prefixIcon,
    required this.controller,
    required this.onChanged,
    this.suffixIcon,
    this.validator,
    this.onPressed,
    this.errorText,
    this.focusNode,
    this.obscureText,
    this.enabled,
    this.onTap,
    this.onFieldSubmitted,
    this.prefixIconConstraints,
    this.suffixIconConstraints,
    this.readOnly, this.hintStyle, this.height, this.textInputAction,this.keyboardType});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // height: height ?? 48.h,
      width: 360.w,
      child: TextFormField(
        keyboardType:keyboardType ??  TextInputType.text,
        textInputAction:textInputAction ?? TextInputAction.next,
        readOnly: readOnly ?? false,
        onFieldSubmitted: onFieldSubmitted,
        onTap: onTap,
        textAlign: TextAlign.left,
        enabled: enabled,
        obscureText: obscureText ?? false,
        focusNode: focusNode,
        maxLines: 1,
        onChanged: onChanged,
        controller: controller,
        decoration: InputDecoration(

          focusedErrorBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(12.0)),
            borderSide: BorderSide(
              color: Colors.transparent,
            ),
          ),
          errorBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(12.0)),
            borderSide: BorderSide(
              color: BaseColors.whiteColor,
            ),
          ),
          focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(12.0)),
            borderSide: BorderSide(
              color: BaseColors.whiteColor,
              width: 2.0,
            ),
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 8),
          hintText: labelText ?? "",

          enabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(12.0)),
            borderSide: BorderSide(
              color: BaseColors.whiteColor,
              width: 2.0,
            ),
          ),
          filled: true,
          hintTextDirection: TextDirection.ltr,
          fillColor: BaseColors.whiteColor,
          prefixIconConstraints: prefixIconConstraints ??
              BoxConstraints(minWidth: 40.w, maxHeight: 20.h),
          suffixIconConstraints: suffixIconConstraints ??
              BoxConstraints(minWidth: 40.w,),
          prefixIcon: prefixIcon != null
              ? Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: prefixIcon)
              : null,
          hintStyle: hintStyle ??
              getTheme(context: context).textTheme.labelLarge?.copyWith(
                color: BaseColors.textHintColor.withOpacity(0.6),
              ),
          suffixIcon: suffixIcon != null ?
          InkWell(
            onTap: onPressed,
            child: Padding(
              padding: const EdgeInsets.all(0.0),
              child: suffixIcon,
            ),
          ) : null
          ,
          border: const OutlineInputBorder(),
        ),
        validator: validator,
      ),
    );
  }
}
