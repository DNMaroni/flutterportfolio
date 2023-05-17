import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'app/app_module.dart';
import 'app/app_widget.dart';
import 'constants.dart';

int contadorNotifications = 0;

void main() async {
  runApp(Container(
    color: Colors.white,
    child: const Center(
      child: CircularProgressIndicator.adaptive(),
    ),
  ));

  const baseUrl = String.fromEnvironment('baseUrl', defaultValue: 'minhaapi');

  Constants.baseUrl = baseUrl;

  /* INICIO */
  /* ISSO É PARA EVITAR QUE O APLICATIVO MUTE A ORIENTAÇÃO, PORTRAIT OU LANDSCAPE */
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  /* FIM */
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      systemNavigationBarColor: Constants.dados['colors']['primary'],
      statusBarColor: Constants.dados['colors']['primary'],
      systemStatusBarContrastEnforced: false,
      statusBarBrightness: Brightness.light,
      statusBarIconBrightness: Brightness.light,
    ),
  );

  runApp(
    ModularApp(
      module: AppModule(),
      child: const AppWidget(),
    ),
  );
}
