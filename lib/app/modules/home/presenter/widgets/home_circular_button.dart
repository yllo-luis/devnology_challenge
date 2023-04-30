import 'package:devnology_challenge/core/constants/app_constants_utils.dart';
import 'package:devnology_challenge/core/enums/app_color_enum.dart';
import 'package:devnology_challenge/core/extentions/build_context_theme_extension.dart';
import 'package:flutter/material.dart';

class HomeCircularButton extends StatefulWidget {
  final IconData iconToShow;
  final Future Function() onTap;

  const HomeCircularButton({
    super.key,
    required this.iconToShow,
    required this.onTap,
  });

  @override
  State<HomeCircularButton> createState() => _HomeCircularButtonState();
}

class _HomeCircularButtonState extends State<HomeCircularButton> {
  bool isLoading = false;

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
        onTap: () {
          if (isLoading == false) {
            setState(() {
              isLoading = true;
            });
            widget.onTap().whenComplete(
                  () => setState(
                    () => isLoading = !isLoading,
                  ),
                );
          }
        },
        child: AnimatedSwitcher(
          duration: AppConstantsUtils.defaultAnimationDuration,
          child: isLoading == false
              ? Icon(
                  widget.iconToShow,
                  color: context.getThemeColor(
                    appColorTheme: AppColorEnum.lighterPink,
                  ),
                  size: 25,
                )
              : SizedBox(
                  height: 25,
                  width: 25,
                  child: CircularProgressIndicator(
                    color: context.getThemeColor(
                      appColorTheme: AppColorEnum.lightNavy,
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}
