import 'package:devnology_challenge/app/modules/home/presenter/widgets/home_circular_button.dart';
import 'package:devnology_challenge/core/constants/app_constants_utils.dart';
import 'package:devnology_challenge/data/modules/home/response/event_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:devnology_challenge/app/modules/home/presenter/controller/home_controller.dart';
import 'package:devnology_challenge/core/enums/app_color_enum.dart';
import 'package:devnology_challenge/core/extentions/build_context_theme_extension.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ModularState<HomePage, HomeController> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: context.getThemeColor(
        appColorTheme: AppColorEnum.defaultNavy,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 12.0,
              vertical: 24.0,
            ),
            child: StreamBuilder<EventResponse>(
                stream: controller.homeStore.currentEventStream,
                builder: (context, eventSnapshot) {
                  return Container(
                    height: 200,
                    width: 300,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: context.getThemeColor(
                          appColorTheme: AppColorEnum.lighterPink,
                        ),
                      ),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: AnimatedSwitcher(
                      duration: AppConstantsUtils.defaultAnimationDuration,
                      child: eventSnapshot.connectionState !=
                              ConnectionState.waiting
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
                                    AppLocalizations.of(context)
                                            ?.homePageTitle ??
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
                                      horizontal: 16.0),
                                  child: Text(
                                    eventSnapshot.data?.activity ??
                                        AppConstantsUtils.emptyString,
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
                    ),
                  );
                }),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              HomeCircularButton(
                iconToShow: Icons.update,
                onTap: () => controller.getAEvent(),
              ),
              HomeCircularButton(
                iconToShow: Icons.settings_suggest,
                onTap: () => null,
              ),
              HomeCircularButton(
                iconToShow: Icons.bookmarks_outlined,
                onTap: () => null,
              ),
            ],
          )
        ],
      ),
    );
  }
}
