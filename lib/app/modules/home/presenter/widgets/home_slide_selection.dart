import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:devnology_challenge/core/constants/app_constants_utils.dart';
import 'package:devnology_challenge/core/enums/app_color_enum.dart';
import 'package:devnology_challenge/core/enums/app_home_dialog_type.dart';
import 'package:devnology_challenge/core/extentions/build_context_theme_extension.dart';
import 'package:intl/intl.dart';

class HomeSlideSelection extends StatefulWidget {
  final ValueNotifier<double> sliderNotifier;
  final AppHomeDialogType homeDialogType;
  final Function(double value) onChanged;

  const HomeSlideSelection({
    super.key,
    required this.sliderNotifier,
    required this.homeDialogType,
    required this.onChanged,
  });

  @override
  State<HomeSlideSelection> createState() => _HomeSlideSelectionState();
}

class _HomeSlideSelectionState extends State<HomeSlideSelection> {
  IconData icon = Icons.hourglass_empty;
  String label = AppConstantsUtils.emptyString;
  double minValue = 0;
  double maxValue = 0;
  final formatCurrency = new NumberFormat.simpleCurrency();

  @override
  void initState() {
    validateTypeAndBuild();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<double>(
      valueListenable: widget.sliderNotifier,
      builder: (context, value, _) {
        return Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Icon(
                icon,
                color: context.getThemeColor(
                  appColorTheme: AppColorEnum.lightNavy,
                ),
                size: 32,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: Text(
                    getCorrectLabel(),
                    style: GoogleFonts.poppins(),
                    textAlign: TextAlign.start,
                  ),
                ),
                Slider(
                  inactiveColor: context
                      .getThemeColor(appColorTheme: AppColorEnum.lightPink)
                      .withOpacity(0.4),
                  overlayColor: MaterialStateProperty.resolveWith(
                    (states) => context
                        .getThemeColor(
                          appColorTheme: AppColorEnum.lightPink,
                        )
                        .withOpacity(0.4),
                  ),
                  activeColor: context.getThemeColor(
                    appColorTheme: AppColorEnum.lightPink,
                  ),
                  label: value.toString(),
                  value: value,
                  onChanged: (value) => widget.onChanged(
                    value.roundToDouble(),
                  ),
                  min: minValue,
                  max: maxValue,
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Text(
                value.round().toString(),
                style: GoogleFonts.poppins(
                  color: context.getThemeColor(
                    appColorTheme: AppColorEnum.defaultNavy,
                  ),
                ),
              ),
            )
          ],
        );
      },
    );
  }

  void validateTypeAndBuild() async {
    switch (widget.homeDialogType) {
      case AppHomeDialogType.participants:
        minValue = AppConstantsUtils.minParticipantsValue;
        maxValue = AppConstantsUtils.maxParticipantsValue;
        icon = Icons.group;
        break;
      case AppHomeDialogType.accessibility:
        minValue = AppConstantsUtils.minAccessibilityValue;
        maxValue = AppConstantsUtils.maxAccessibilityValue;
        icon = Icons.accessible_forward;
        break;
      case AppHomeDialogType.price:
        minValue = AppConstantsUtils.minPriceValue;
        maxValue = AppConstantsUtils.maxPriceValue;
        icon = Icons.attach_money;
        break;
    }
  }

  String getCorrectLabel() {
    switch (widget.homeDialogType) {
      case AppHomeDialogType.participants:
        return AppLocalizations.of(context)!.homeDialogParticipansTitle;
      case AppHomeDialogType.accessibility:
        return AppLocalizations.of(context)!.homeDialogAccessibilityTitle;
      case AppHomeDialogType.price:
        return AppLocalizations.of(context)!.homeDialogPriceTitle;
    }
  }
}
