import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:devnology_challenge/app/modules/home/presenter/widgets/home_circular_button.dart';
import 'package:devnology_challenge/app/modules/home/presenter/widgets/home_event_layout.dart';
import 'package:devnology_challenge/data/modules/home/response/event_response.dart';
import 'package:devnology_challenge/app/modules/home/presenter/controller/home_controller.dart';
import 'package:devnology_challenge/core/enums/app_color_enum.dart';
import 'package:devnology_challenge/core/enums/app_home_dialog_type.dart';
import 'package:devnology_challenge/core/extentions/build_context_theme_extension.dart';
import 'package:devnology_challenge/app/modules/home/presenter/widgets/home_slide_selection.dart';
import 'package:google_fonts/google_fonts.dart';

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
                    child: HomeEventLayout(
                      isLoading: eventSnapshot.connectionState,
                      event: eventSnapshot.data,
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
                onTap: () => Future(
                  () => showOptionsDialog(),
                ),
              ),
              HomeCircularButton(
                iconToShow: Icons.bookmarks_outlined,
                onTap: () => Future(() => null),
              ),
            ],
          )
        ],
      ),
    );
  }

  void showOptionsDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(
          contentPadding: const EdgeInsets.symmetric(
            vertical: 12.0,
            horizontal: 12,
          ),
          children: [
            HomeSlideSelection(
              sliderNotifier: controller.homeStore.participantsNotifier,
              homeDialogType: AppHomeDialogType.participants,
              onChanged: (value) =>
                  controller.homeStore.participantsNotifier.value = value,
            ),
            HomeSlideSelection(
              sliderNotifier: controller.homeStore.accessibilityNotifier,
              homeDialogType: AppHomeDialogType.accessibility,
              onChanged: (value) =>
                  controller.homeStore.accessibilityNotifier.value = value,
            ),
            HomeSlideSelection(
              sliderNotifier: controller.homeStore.priceNotifier,
              homeDialogType: AppHomeDialogType.price,
              onChanged: (value) =>
                  controller.homeStore.priceNotifier.value = value,
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TextButton(
                  onPressed: () => controller.resetDialogData().whenComplete(
                        () => Navigator.pop(context),
                      ),
                  child: Text(
                    AppLocalizations.of(context)!.homeDialogCancelButtonTitle,
                    style: GoogleFonts.poppins(),
                  ),
                  style: TextButton.styleFrom(
                    foregroundColor: context.getThemeColor(
                      appColorTheme: AppColorEnum.defaultNavy,
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text(
                    AppLocalizations.of(context)!.homeDialogSaveButtonTitle,
                    style: GoogleFonts.poppins(),
                  ),
                  style: ButtonStyle(
                    elevation: MaterialStateProperty.resolveWith(
                      (_) => 0,
                    ),
                    backgroundColor: MaterialStateProperty.resolveWith(
                      (_) => context.getThemeColor(
                        appColorTheme: AppColorEnum.lightNavy,
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        );
      },
    );
  }
}
