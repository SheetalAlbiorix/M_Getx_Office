import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';



extension DoubleExtension on int {
  /// Vertical Spaced SizedBox
  Widget get toVSB {
    return SizedBox(height: toDouble().h);
  }

  /// Horizontal Spaced SizedBox
  Widget get toHSB {
    return SizedBox(width: toDouble().w);
  }

}
///media_query_extensions
extension MediaQueryExtensions on BuildContext {
  double screenHeightPercentage(double percentage) {
    return MediaQuery.of(this).size.height * percentage;
  }

  double screenWidthPercentage(double percentage) {
    return MediaQuery.of(this).size.width * percentage;
  }
}

