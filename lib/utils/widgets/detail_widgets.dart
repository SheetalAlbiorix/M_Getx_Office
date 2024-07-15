import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:m_getx_office/utils/extensions/base_extensions.dart';

import '../constants/base_colors.dart';
import '../functions/base_funcations.dart';

Widget customIconWithText(String icon, String text, BuildContext context) {
  return Row(
    children: [
      SvgPicture.asset(icon),
      12.toHSB,
      SizedBox(
        width: 207.w,
        child: Text(
          maxLines: 2,
          text.replaceFirstMapped(
          RegExp(r"(\d{3})(\d{3})(\d{3})(\d)"),
          (Match m) => "${m[1]} ${m[2]} ${m[3]}0"
  ),
          style: getTheme(context: context).textTheme.titleMedium?.copyWith(
              color: BaseColors.allOfficeTextColor,
              fontSize: 12.sp,
              fontWeight: FontWeight.w400),
        ),
      ),
    ],
  );
}