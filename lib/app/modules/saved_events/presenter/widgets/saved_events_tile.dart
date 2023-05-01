import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:devnology_challenge/core/constants/app_constants_utils.dart';
import 'package:devnology_challenge/core/enums/app_color_enum.dart';
import 'package:devnology_challenge/core/extentions/build_context_theme_extension.dart';
import 'package:devnology_challenge/data/modules/home/response/event_response.dart';

class SavedEventsTile extends StatelessWidget {
  final EventResponse event;
  final Function onTap;
  final Function onAltTap;

  const SavedEventsTile({
    super.key,
    required this.event,
    required this.onTap,
    required this.onAltTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: event.link?.isEmpty == true ? 160 : 200,
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      decoration: BoxDecoration(
        color: context.getThemeColor(
          appColorTheme: AppColorEnum.lightNavy,
        ),
        borderRadius: BorderRadius.circular(25),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    event.activity ?? AppConstantsUtils.emptyString,
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      color: context.getThemeColor(),
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                GestureDetector(
                  onTap: () => onAltTap(),
                  child: Icon(
                    Icons.delete,
                    color: context.getThemeColor(),
                  ),
                )
              ],
            ),
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Icon(
                  Icons.group,
                  color: context.getThemeColor(),
                ),
              ),
              Text(
                AppLocalizations.of(context)!.savedEventsCardPersonsTitle(
                  event.participants ?? AppConstantsUtils.emptyString,
                ),
                style: GoogleFonts.poppins(color: context.getThemeColor()),
              )
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Icon(
                  Icons.accessible_forward,
                  color: context.getThemeColor(),
                ),
              ),
              Text(
                event.accessibility == '1'
                    ? AppLocalizations.of(context)!
                        .savedEventsCardPersonsGoodAccessibilityTitle
                    : AppLocalizations.of(context)!
                        .savedEventsCardPersonsBadAccessibilityTitle,
                style: GoogleFonts.poppins(color: context.getThemeColor()),
              )
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Icon(
                  Icons.attach_money,
                  color: context.getThemeColor(),
                ),
              ),
              Text(
                event.price == '0'
                    ? AppLocalizations.of(context)!.savedEventsFreeActivityTitle
                    : event.price ?? AppConstantsUtils.emptyString,
                style: GoogleFonts.poppins(
                  color: context.getThemeColor(),
                ),
              )
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          event.link?.isNotEmpty == true
              ? GestureDetector(
                  onTap: () => onTap(),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Icon(
                          Icons.web,
                          color: context.getThemeColor(),
                        ),
                      ),
                      Text(
                        event.link ?? AppConstantsUtils.emptyString,
                        style: GoogleFonts.poppins(
                          color: context.getThemeColor(),
                        ),
                      )
                    ],
                  ),
                )
              : const SizedBox.shrink(),
        ],
      ),
    );
  }
}
