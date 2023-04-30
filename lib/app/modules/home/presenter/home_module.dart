import 'package:devnology_challenge/app/modules/home/presenter/controller/home_controller.dart';
import 'package:devnology_challenge/app/modules/home/presenter/pages/home_page.dart';
import 'package:devnology_challenge/app/modules/home/presenter/store/home_store.dart';
import 'package:devnology_challenge/domain/use_case/module/home/get_event_use_case.dart';
import 'package:flutter_modular/flutter_modular.dart';

class HomeModule extends Module {
  @override
  List<Bind> binds = List.from([
    Bind.lazySingleton<GetEventUseCase>(
      (i) => GetEventUseCase(
        homeService: i(),
      ),
    ),
    Bind.lazySingleton<HomeStore>(
      (i) => HomeStore(),
    ),
    Bind.lazySingleton<HomeController>(
      (i) => HomeController(
        homeStore: i(),
        getEventUseCase: i(),
      ),
    )
  ]);

  @override
  List<ModularRoute> get routes => List.from(
        [
          ChildRoute(
            Modular.initialRoute,
            child: (context, args) => HomePage(),
          )
        ],
      );
}
