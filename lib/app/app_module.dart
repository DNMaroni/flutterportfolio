import 'package:flutter_modular/flutter_modular.dart';

import 'modules/home/home_module.dart';
import 'modules/projetos/projetos_module.dart';

class AppModule extends Module {
  @override
  List<Module> get imports => [];
  @override
  List<Bind> get binds => [];

  @override
  List<ModularRoute> get routes => [
        ModuleRoute(
          '/',
          module: HomeModule(),
          transition: TransitionType.fadeIn,
          guards: [],
        ),
        ModuleRoute(
          '/projetos',
          module: ProjetosModule(),
          transition: TransitionType.fadeIn,
          guards: [],
        ),
      ];
}
