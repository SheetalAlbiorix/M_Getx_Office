
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constants/base_colors.dart';
import '../constants/base_strings.dart';
import '../functions/base_funcations.dart';

class AnimatedButton extends StatelessWidget {
  final bool busy;
  final String? title;
  final VoidCallback? onPressed;
  final bool enabled;
  double? width;
  double? height;
  final TextAlign? textAlign;
   AnimatedButton(
      {super.key,
      required this.title,
      this.busy = false,
      required this.onPressed,
      this.enabled = false,

      this.height,this.textAlign});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: InkWell(
        child: AnimatedContainer(
          height: height,
          width:  busy == false ? 350.w : 66.w,
          curve: Curves.easeIn,
          duration: const Duration(seconds: 1),
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(
              horizontal: 8,
              vertical: busy ? 10 : 0),
          decoration: BoxDecoration(
            color: enabled == false ? Colors.grey.shade400 : BaseColors.backgroundColor,
            borderRadius: BorderRadius.circular(30),
          ),
          child: !busy
              ? Row(
            children: [
              Expanded(
                child: Text(
                  textAlign: textAlign,
                  overflow: TextOverflow.ellipsis,
                  title ??"",
                  style: getTheme(context: context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(
                    fontSize: 18.sp,
                    color: BaseColors.whiteColor,
                    fontFamily: BaseStrings.interRegular,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.zero,
                width: 48.w,
                height: 48.w,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(48),
                ),
                child: SizedBox(
                  height: 17.26.h,
                  width: 21.3.w,
                  child: const Icon(
                    Icons.arrow_forward,
                    color: BaseColors.backgroundColor,
                  ),
                ),
              ),
            ],
          )
              : const CircularProgressIndicator(
                  strokeWidth: 3,
                  valueColor:
                      AlwaysStoppedAnimation<Color>(BaseColors.whiteColor)),
        ),
      ),
    );
  }
}
