import 'package:flutter/material.dart';

import '../enums/app_color_enum.dart';

extension BuildContextThemeExtension on BuildContext {

  Color getThemeColor({AppColorEnum? appColorTheme}) {
    if (appColorTheme != null) {
      switch (appColorTheme) {
        case AppColorEnum.defaultOrange:
          return const Color(0xFFD65743);
        case AppColorEnum.darkSand:
          return const Color(0xFFCBA146);
        case AppColorEnum.backgroundBordeaux:
          return const Color(0xFF573139);
        case AppColorEnum.darkRed:
          return const Color(0xFF9B3644);
        case AppColorEnum.lightSand:
          return const Color(0xFFE1CC9D);
      }
    }
    return const Color(0xFFFFFFFF);
  }
}