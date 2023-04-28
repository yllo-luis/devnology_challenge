import 'package:devnology_challenge/core/helpers/launcher/launcher_contract.dart';
import 'package:url_launcher/url_launcher.dart';

class LaunchHelper implements LauncherContract {
  @override
  Future<void> launchCellPhone({required String numberToLaunch}) async {
    final phoneToLaunch = Uri(
      scheme: 'tel',
      path: numberToLaunch,
    );

    launchUrl(phoneToLaunch);
  }

  @override
  Future<void> launchUserBrowser({required Uri uriToLaunch}) async => await launchUrl(
    uriToLaunch
  );
}