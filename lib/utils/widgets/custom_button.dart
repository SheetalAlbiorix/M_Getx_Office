import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constants/base_colors.dart';
import '../constants/base_strings.dart';
import '../functions/base_funcations.dart';

class CustomButton extends StatelessWidget {

  final String? labelText;

final MainAxisAlignment? mainAxisAlignment;
  final VoidCallback? onPressed;
  final Color? disabledBackgroundColor;
  final Color? BackgroundColor;
  const CustomButton({super.key,  this.disabledBackgroundColor, required this.labelText,required  this.onPressed, this.mainAxisAlignment, this.BackgroundColor,});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(

      style: ElevatedButton.styleFrom(
        disabledBackgroundColor: disabledBackgroundColor ,
          fixedSize: Size(232.w, 48.w),
          backgroundColor: BackgroundColor ??
          BaseColors.btnColor,
          elevation: 3),
      onPressed: onPressed,
      child: Text(

        overflow: TextOverflow.ellipsis,
        labelText ??"",
        style: getTheme(context: context)
            .textTheme
            .titleMedium
            ?.copyWith(
          fontWeight: FontWeight.w500,
          fontSize: 14.sp,
          color: BaseColors.whiteColor,
          fontFamily: BaseStrings.interRegular,
        ),
      ),
    );
  }
}
