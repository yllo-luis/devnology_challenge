import 'package:devnology_challenge/app/modules/home/presenter/home_module.dart';
import 'package:devnology_challenge/core/helpers/database/database_helper.dart';
import 'package:devnology_challenge/core/helpers/database/database_helper_contract.dart';
import 'package:devnology_challenge/core/helpers/launcher/launch_helper.dart';
import 'package:devnology_challenge/core/helpers/launcher/launcher_contract.dart';
import 'package:devnology_challenge/data/modules/home/service/home_service.dart';
import 'package:devnology_challenge/data/modules/home/service/home_service_contract.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'modules/saved_events/saved_events_module.dart';

class AppModule extends Module {
  @override
  List<Bind> get binds => List.from(
        [
          Bind.singleton<DatabaseHelperContract>(
            (i) => DatabaseHelper(),
          ),
          Bind.singleton<LauncherContract>(
            (i) => LaunchHelper(),
          ),
          Bind.singleton<HomeServiceContract>(
            (i) => HomeService(),
          )
        ],
      );

  @override
  List<ModularRoute> get routes => List.from(
        [
          ModuleRoute(
            Modular.initialRoute,
            module: HomeModule(),
          ),
          ModuleRoute(
            '/savedEvents/',
            module: SavedEventsModule(),
          )
        ],
      );
}
