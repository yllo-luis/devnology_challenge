import 'package:devnology_challenge/app/modules/home/presenter/home_module.dart';
import 'package:devnology_challenge/core/helpers/database/database_helper.dart';
import 'package:devnology_challenge/core/helpers/database/database_helper_contract.dart';
import 'package:devnology_challenge/core/helpers/launcher/launch_helper.dart';
import 'package:devnology_challenge/core/helpers/launcher/launcher_contract.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppModule extends Module {
  @override
  List<Bind> get binds => List.from(
        [
          Bind.singleton<DatabaseHelperContract>(
            (i) => DatabaseHelper(),
          ),
          Bind.singleton<LauncherContract>(
            (i) => LaunchHelper(),
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
        ],
      );
}
