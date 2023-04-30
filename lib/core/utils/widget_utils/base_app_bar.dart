import 'package:devnology_challenge/core/enums/app_color_enum.dart';
import 'package:devnology_challenge/core/extentions/build_context_theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';


class BaseAppBar extends StatefulWidget implements PreferredSizeWidget {
  final Widget? optionalLeading;

  const BaseAppBar({super.key, this.optionalLeading});

  @override
  State<BaseAppBar> createState() => _BaseAppBarState();

  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

class _BaseAppBarState extends State<BaseAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: context.getThemeColor(
        appColorTheme: AppColorEnum.lightPink,
      ),
      title: SizedBox(
        height: 45,
        child: Image.asset(
          'assets/launch_icon/WBC logo.jpeg',
        ),
      ),
      centerTitle: true,
      automaticallyImplyLeading: false,
      leading: widget.optionalLeading ??
          IconButton(
            onPressed: () => Modular.to.pop(),
            icon: const Icon(
              Icons.arrow_back_ios,
            ),
          ),
    );
  }
}
