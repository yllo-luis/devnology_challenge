import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:devnology_challenge/core/constants/app_constants_utils.dart';
import 'package:devnology_challenge/core/enums/app_color_enum.dart';
import 'package:devnology_challenge/core/extentions/build_context_theme_extension.dart';
import 'package:devnology_challenge/data/modules/home/response/event_response.dart';

class HomeEventLayout extends StatelessWidget {
  final ConnectionState isLoading;
  final EventResponse? event;

  const HomeEventLayout({
    super.key,
    required this.isLoading,
    required this.event,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: AppConstantsUtils.defaultAnimationDuration,
      child: isLoading != ConnectionState.waiting
          ? Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    top: 16.0,
                    bottom: 24.0,
                    left: 24.0,
                    right: 24.0,
                  ),
                  child: Text(
                    AppLocalizations.of(context)?.homePageTitle ??
                        AppConstantsUtils.emptyString,
                    style: GoogleFonts.pacifico(
                      color: context.getThemeColor(),
                      fontSize: 24,
                    ),
                    softWrap: true,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                  ),
                  child: Text(
                    event?.activity ?? AppConstantsUtils.emptyString,
                    style: GoogleFonts.pacifico(
                      color: context.getThemeColor(),
                      fontSize: 20,
                    ),
                    textAlign: TextAlign.center,
                  ),
                )
              ],
            )
          : CircularProgressIndicator(
              color: context.getThemeColor(
                appColorTheme: AppColorEnum.lightNavy,
              ),
            ),
    );
  }
}
