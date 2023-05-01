import 'package:devnology_challenge/app/modules/home/presenter/controller/home_controller.dart';
import 'package:devnology_challenge/app/modules/home/presenter/pages/home_page.dart';
import 'package:devnology_challenge/app/modules/home/presenter/store/home_store.dart';
import 'package:devnology_challenge/domain/use_case/module/home/get_count_saved_events_use_case.dart';
import 'package:devnology_challenge/domain/use_case/module/home/get_event_use_case.dart';
import 'package:devnology_challenge/domain/use_case/module/home/save_events_on_database_use_case.dart';
import 'package:flutter_modular/flutter_modular.dart';

class HomeModule extends Module {
  @override
  List<Bind> binds = List.from([
    Bind.lazySingleton<GetEventUseCase>(
      (i) => GetEventUseCase(
        homeService: i(),
      ),
    ),
    Bind.lazySingleton<GetCountSavedEvents>(
      (i) => GetCountSavedEvents(
        databaseHelper: i(),
      ),
    ),
    Bind.lazySingleton<SaveEventsOnDatabaseUseCase>(
      (i) => SaveEventsOnDatabaseUseCase(
        databaseHelper: i(),
      ),
    ),
    Bind.lazySingleton<HomeStore>(
      (i) => HomeStore(),
    ),
    Bind.lazySingleton<HomeController>(
      (i) => HomeController(
        homeStore: i(),
        getCountSavedEvents: i(),
        saveEventsOnDatabaseUseCase: i(),
        getEventUseCase: i(),
        launcherHelper: i(),
      ),
    )
  ]);

  @override
  List<ModularRoute> get routes => List.from(
        [
          ChildRoute(
            Modular.initialRoute,
            child: (context, args) => const HomePage(),
          )
        ],
      );
}
