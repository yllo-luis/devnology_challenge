import 'package:flutter/material.dart';

import '../enums/app_color_enum.dart';

extension BuildContextThemeExtension on BuildContext {

  Color getThemeColor({AppColorEnum? appColorTheme}) {
    if (appColorTheme != null) {
      switch (appColorTheme) {
        case AppColorEnum.defaultNavy:
          return const Color(0xFF2A2F4F);
        case AppColorEnum.lightNavy:
          return const Color(0xFF917FB3);
        case AppColorEnum.lightPink:
          return const Color(0xFFE5BEEC);
        case AppColorEnum.lighterPink:
          return const Color(0xFFFDE2F3);
      }
    }
    return const Color(0xFFFFFFFF);
  }
}