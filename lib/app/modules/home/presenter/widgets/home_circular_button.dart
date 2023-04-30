import 'package:devnology_challenge/core/enums/app_color_enum.dart';
import 'package:devnology_challenge/core/extentions/build_context_theme_extension.dart';
import 'package:flutter/material.dart';

class HomeCircularButton extends StatelessWidget {
  final IconData iconToShow;
  final Function onTap;

  const HomeCircularButton({
    super.key,
    required this.iconToShow,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: 50,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: context.getThemeColor(
            appColorTheme: AppColorEnum.lighterPink,
          ),
        ),
      ),
      child: GestureDetector(
        onTap: () => onTap(),
        child: Icon(
          iconToShow,
          color: context.getThemeColor(
            appColorTheme: AppColorEnum.lighterPink,
          ),
          size: 25,
        ),
      ),
    );
  }
}
