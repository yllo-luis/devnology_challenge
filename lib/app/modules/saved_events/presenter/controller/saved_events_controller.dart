import 'package:devnology_challenge/app/modules/saved_events/presenter/store/saved_events_store.dart';
import 'package:devnology_challenge/core/helpers/launcher/launcher_contract.dart';
import 'package:devnology_challenge/domain/use_case/module/saved_events/delete_event_from_database_use_case.dart';
import 'package:devnology_challenge/domain/use_case/module/saved_events/get_event_from_database_use_case.dart';

class SavedEventsController {
  final GetEventFromDatabaseUseCase getEventFromDatabaseUseCase;
  final DeleteEventFromDatabaseUseCase deleteEventFromDatabaseUseCase;
  final SavedEventsStore savedEventsStore;
  final LauncherContract launcherHelper;

  SavedEventsController({
    required this.getEventFromDatabaseUseCase,
    required this.deleteEventFromDatabaseUseCase,
    required this.savedEventsStore,
    required this.launcherHelper,
  }) {
    init();
  }

  Future<void> init() async {
    await loadAllSavedEvents();
  }

  void dispose() {
    savedEventsStore.onDispose();
  }

  Future<void> loadAllSavedEvents() async {
    await getEventFromDatabaseUseCase.getEvent().then((value) {
      savedEventsStore.addEvents(events: value);
    }, onError: (error) {
      savedEventsStore.eventsController.addError(error);
    });
  }

  Future<bool> deleteSavedEvent({required int eventId}) async {
    final bool result = await deleteEventFromDatabaseUseCase
        .deleteSavedEvent(eventId: eventId)
        .whenComplete(
          () => loadAllSavedEvents(),
        );
    return result;
  }

  Future<void> openWebPage({required String uri}) async {
    launcherHelper.launchUserBrowser(
      uriToLaunch: Uri.parse(uri),
    );
  }
}
