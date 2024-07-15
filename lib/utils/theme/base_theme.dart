
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constants/base_colors.dart';
import '../constants/base_strings.dart';



class ThemeStyle {

  static String fontFamily = BaseStrings.interRegular;
  static ThemeData themeData(bool isDarkTheme, BuildContext context) {
    return ThemeData(
      primaryColor: BaseColors.canvasColor,
      scaffoldBackgroundColor: BaseColors.canvasColor,
      hintColor: BaseColors.searchBarHintTextColor,
      textTheme:  TextTheme(
        displayLarge:TextStyle(color: BaseColors.widgetColor,
            fontSize: 18.sp,
            fontWeight: FontWeight.w100,
            fontFamily:fontFamily
        ),
        displayMedium: TextStyle(color: BaseColors.widgetColor,
            fontSize: 14.sp,
            fontWeight: FontWeight.w100,
            fontFamily:fontFamily
        ),
        displaySmall: TextStyle(color: BaseColors.widgetColor,
            fontSize: 12.sp,
            fontWeight: FontWeight.w100,
            fontFamily:fontFamily
        ),
        bodyLarge:TextStyle(color: BaseColors.widgetColor,
            fontSize: 18.sp,
            fontWeight: FontWeight.w700,
            fontFamily:fontFamily
        ),
          bodyMedium: TextStyle(color: BaseColors.widgetColor,
          fontSize: 14.sp,
          fontWeight: FontWeight.w400,
          fontFamily:fontFamily
      ),
        bodySmall: TextStyle(color: BaseColors.widgetColor,
            fontSize: 12.sp,
            fontWeight: FontWeight.w100,
            fontFamily:fontFamily
        ),
          titleLarge: TextStyle(color: BaseColors.allOfficeTextColor,
          fontSize: 18.sp,
          fontWeight: FontWeight.w600,
          fontFamily:fontFamily
      ),
          titleMedium: TextStyle(color: BaseColors.widgetColor,
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              fontFamily:fontFamily
          ),
        titleSmall: TextStyle(
            color: BaseColors.blackColor,
            fontSize: 14.sp,
            fontWeight: FontWeight.w100,
            fontFamily:fontFamily
        ),
        headlineLarge: TextStyle(color: BaseColors.widgetColor,
            fontSize: 18.sp,
            fontWeight: FontWeight.w100,
            fontFamily:fontFamily
        ),
        headlineMedium: TextStyle(color: BaseColors.allOfficeTextColor,
            fontSize: 28.sp,
            fontWeight: FontWeight.w600,
            fontFamily:fontFamily
        ),
       headlineSmall: TextStyle(color: BaseColors.widgetColor,
           fontSize: 24.sp,
           fontWeight: FontWeight.w600,
           fontFamily:fontFamily
       ),
        labelLarge: TextStyle(color: BaseColors.widgetColor,
          fontSize: 14.sp,
          fontWeight: FontWeight.w700,
          fontFamily:fontFamily
      ),
        labelMedium: TextStyle(color: BaseColors.widgetColor,
            fontSize: 14.sp,
            fontWeight: FontWeight.w100,
            fontFamily:fontFamily
        ),
        labelSmall: TextStyle(color: BaseColors.widgetColor,
            fontSize: 10.sp,
            fontWeight: FontWeight.w100,
            fontFamily:fontFamily
        ),
      ),
      splashColor: Colors.transparent,
      highlightColor:Colors.transparent,
      appBarTheme: const AppBarTheme(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
      ),

    );
  }
}







