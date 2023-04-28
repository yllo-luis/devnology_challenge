import 'package:devnology_challenge/core/constants/app_constants_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CustomErrorWidget extends StatelessWidget {
  final FlutterErrorDetails errorDetails;

  const CustomErrorWidget({
    super.key,
    required this.errorDetails,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Material(
        color: Colors.white,
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(top: 24.0),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12.0),
                    child: Text(
                      AppLocalizations.of(context)?.onErrorTitle ??
                          AppConstantsUtils.emptyString,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 24.0),
                    child: Text(
                      AppLocalizations.of(context)?.onErrorSubtitle ??
                          AppConstantsUtils.emptyString,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Text(
                    errorDetails.summary.value.toString(),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
