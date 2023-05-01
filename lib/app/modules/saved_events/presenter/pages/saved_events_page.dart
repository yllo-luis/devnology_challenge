import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:devnology_challenge/core/enums/app_color_enum.dart';
import 'package:devnology_challenge/core/extentions/build_context_theme_extension.dart';
import 'package:devnology_challenge/data/modules/home/response/event_response.dart';
import 'package:devnology_challenge/app/modules/saved_events/presenter/controller/saved_events_controller.dart';
import 'package:devnology_challenge/app/modules/saved_events/presenter/widgets/saved_events_tile.dart';
import 'package:devnology_challenge/core/constants/app_constants_utils.dart';

class SavedEventsPage extends StatefulWidget {
  const SavedEventsPage({super.key});

  @override
  State<SavedEventsPage> createState() => _SavedEventsPageState();
}

class _SavedEventsPageState
    extends ModularState<SavedEventsPage, SavedEventsController> {
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: context.getThemeColor(
          appColorTheme: AppColorEnum.defaultNavy,
        ),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(
            Icons.arrow_back_ios,
          ),
        ),
      ),
      body: StreamBuilder<List<EventResponse>>(
        stream: controller.savedEventsStore.currentEventsStream,
        builder: (context, snapshot) {
          return AnimatedSwitcher(
            duration: AppConstantsUtils.defaultAnimationDuration,
            child: snapshot.connectionState != ConnectionState.waiting
                ? _mountPageLayout(
                    events: snapshot.data!,
                    controller: controller,
                  )
                : Center(
                    child: CircularProgressIndicator(
                      color: context.getThemeColor(
                        appColorTheme: AppColorEnum.defaultNavy,
                      ),
                    ),
                  ),
          );
        },
      ),
    );
  }
}

class _mountPageLayout extends StatelessWidget {
  final List<EventResponse> events;
  final SavedEventsController controller;

  const _mountPageLayout({
    super.key,
    required this.events,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 16.0,
        horizontal: 24.0,
      ),
      child: events.isNotEmpty == true
          ? ListView.separated(
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              itemBuilder: (context, index) {
                return SavedEventsTile(
                  event: events[index],
                  onTap: () => controller.openWebPage(
                    uri: events[index].link ?? AppConstantsUtils.emptyString,
                  ),
                  onAltTap: () => controller.deleteSavedEvent(
                    eventId: int.parse(
                      events[index].key ?? AppConstantsUtils.emptyString,
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) => SizedBox(height: 12),
              itemCount: events.length,
            )
          : Center(
              child: _mountEmptyListLayout(),
            ),
    );
  }
}

class _mountEmptyListLayout extends StatelessWidget {
  const _mountEmptyListLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(
          Icons.sentiment_dissatisfied,
          size: 70,
        ),
        Text(
          AppLocalizations.of(context)!.savedEventsEmptyListTitle,
          style: GoogleFonts.poppins(
            color: context.getThemeColor(
              appColorTheme: AppColorEnum.lightNavy,
            ),
            fontSize: 20,
          ),
          textAlign: TextAlign.center,
        )
      ],
    );
  }
}
