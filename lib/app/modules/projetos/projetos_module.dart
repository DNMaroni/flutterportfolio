import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:portfolio/app/modules/projetos/pages/imovel_tipo_finder/imovel_tipo_finder_page.dart';
import 'package:portfolio/app/modules/projetos/pages/imovel_tipo_finder/imovel_tipo_finder_store.dart';
import 'package:portfolio/app/modules/projetos/pages/projetos_home_page.dart';
import 'package:portfolio/app/modules/projetos/pages/white_weapon_finder/white_weapon_finder_page.dart';
import 'package:portfolio/app/modules/projetos/pages/white_weapon_finder/white_weapon_finder_store.dart';
import 'package:portfolio/app/modules/projetos/repositories/imovel_tipo_finder_repository.dart';
import 'package:portfolio/app/modules/projetos/repositories/whiteweapon_finder_repository.dart';

import '../../services/implementations/mobile/client_http_service_implementation.dart';

class ProjetosModule extends Module {
  @override
  final List<Bind> binds = [
    // DEPENDENCIAS
    Bind.singleton((i) => Dio()),
    Bind.singleton((i) => ClientHttpServiceImplementation(i())),
    Bind.singleton((i) => WhiteweaponFinderImplementation(i())),
    Bind.singleton((i) => ImovelTipoFinderImplementation(i())),

    //STORES
    Bind.singleton((i) => WhiteWeaponFinderStore(i())),
    Bind.singleton((i) => ImovelTipoFinderStore(i())),
  ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/', child: (context, args) => const ProjetosHomePage()),
        ChildRoute('/wpfinder',
            child: (context, args) => const WhiteWeaponFinderPage()),
        ChildRoute('/itfinder',
            child: (context, args) => const ImovelTipoFinderPage()),
      ];
}
