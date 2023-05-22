import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:portfolio/app/modules/home/repositories/home_repository.dart';

import 'pages/home_page.dart';
import 'pages/home_store.dart';
import '../../services/implementations/mobile/client_http_service_implementation.dart';

class HomeModule extends Module {
  @override
  final List<Bind> binds = [
    // DEPENDENCIAS
    Bind.singleton((i) => Dio()),
    Bind.singleton((i) => ClientHttpServiceImplementation(i())),
    Bind.singleton((i) => HomeRepositoryImplementation(i())),

    //STORES
    Bind.singleton((i) => HomeStore(i())),
  ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/', child: (context, args) => const HomePage()),
      ];
}
