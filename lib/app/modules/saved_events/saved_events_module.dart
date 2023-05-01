import 'package:devnology_challenge/app/modules/saved_events/presenter/controller/saved_events_controller.dart';
import 'package:devnology_challenge/app/modules/saved_events/presenter/store/saved_events_store.dart';
import 'package:devnology_challenge/core/helpers/launcher/launch_helper.dart';
import 'package:devnology_challenge/core/helpers/launcher/launcher_contract.dart';
import 'package:devnology_challenge/domain/use_case/module/saved_events/delete_event_from_database_use_case.dart';
import 'package:devnology_challenge/domain/use_case/module/saved_events/get_event_from_database_use_case.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:devnology_challenge/app/modules/saved_events/presenter/pages/saved_events_page.dart';

class SavedEventsModule extends Module {
  @override
  List<ModularRoute> get routes => List.from(
        [
          ChildRoute(
            '/',
            child: (context, args) => const SavedEventsPage(),
          )
        ],
      );

  @override
  List<Bind> get binds => List.from([
        Bind.lazySingleton<GetEventFromDatabaseUseCase>(
          (i) => GetEventFromDatabaseUseCase(
            databaseHelper: i(),
          ),
        ),
        Bind.lazySingleton<DeleteEventFromDatabaseUseCase>(
          (i) => DeleteEventFromDatabaseUseCase(
            databaseHelper: i(),
          ),
        ),
        Bind.lazySingleton<SavedEventsStore>(
          (i) => SavedEventsStore(),
        ),
        Bind.lazySingleton<LauncherContract>(
          (i) => LaunchHelper(),
        ),
        Bind.lazySingleton<SavedEventsController>(
          (i) => SavedEventsController(
            getEventFromDatabaseUseCase: i(),
            deleteEventFromDatabaseUseCase: i(),
            savedEventsStore: i(),
            launcherHelper: i(),
          ),
        ),
      ]);
}
