abstract class LauncherContract {
  Future<void> launchUserBrowser({required Uri uriToLaunch});
  Future<void> launchCellPhone({required String numberToLaunch});
}