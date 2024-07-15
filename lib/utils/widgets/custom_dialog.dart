import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:m_getx_office/utils/extensions/base_extensions.dart';


import '../constants/base_colors.dart';
import '../constants/base_strings.dart';
import '../functions/base_funcations.dart';

class CustomDialogScreen extends StatelessWidget {
  final String? title;
  final String? subTitle;
  final String? image;
  final Widget? widget;

  const CustomDialogScreen(
      {super.key, this.title, this.subTitle, this.image, this.widget});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: BaseColors.canvasColor,
      contentPadding: EdgeInsets.zero,
      alignment: Alignment.center,
      content: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              image ?? "",
              height: 176.w,
              width: 260.w,
            ),
            24.toVSB,
            Text(
              title ?? "",
              style: getTheme(context: context).textTheme.titleMedium?.copyWith(
                  fontSize: 24.sp,
                  fontFamily: BaseStrings.interRegular,
                  fontWeight: FontWeight.w600),
            ),
            10.toVSB,
            Text(
              subTitle ?? "",
              style: getTheme(context: context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: BaseColors.textAndIconColor),
              textAlign: TextAlign.center,
            ),
            20.toVSB,
            widget ?? const SizedBox.shrink(),
            48.toVSB,
          ],
        ),
      ),
    );
  }
}
