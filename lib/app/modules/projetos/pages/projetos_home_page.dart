// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class ProjetosHomePage extends StatefulWidget {
  const ProjetosHomePage({Key? key}) : super(key: key);

  @override
  _ProjetosHomePageState createState() => _ProjetosHomePageState();
}

class _ProjetosHomePageState extends State<ProjetosHomePage> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      child: ListView(children: [
        Card(
          child: Padding(
            padding: const EdgeInsets.only(top: 10, bottom: 10),
            child: ListTile(
              onTap: () {
                Modular.to.pushNamed("/projetos/wpfinder");
              },
              leading: Image.asset(
                'assets/images/knife.png',
                width: 35,
                height: 35,
              ),
              title: const Text(
                'Detector de armas brancas',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: const Text(
                  'Utiliza-se técnicas de processamento de imagens em python para descobrir armas brancas em um vídeo.'),
              trailing: const Icon(Icons.arrow_forward_ios_rounded,
                  weight: 30, size: 15),
              titleAlignment: ListTileTitleAlignment.center,
            ),
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        Card(
          child: Padding(
            padding: const EdgeInsets.only(top: 10, bottom: 10),
            child: ListTile(
              onTap: () {
                Modular.to.pushNamed("/projetos/itfinder");
              },
              leading: Image.asset(
                'assets/images/house_finder.png',
                width: 50,
                height: 50,
              ),
              title: const Text(
                'Detector de tipo de imóvel',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: const Text(
                  'Utilizando uma rede neural previamente treinada, tenta-se detectar o tipo de um imóvel (apartamento, casa, etc...) à partir de uma imagem.'),
              trailing: const Icon(
                Icons.arrow_forward_ios_rounded,
                weight: 30,
                size: 15,
              ),
              titleAlignment: ListTileTitleAlignment.center,
            ),
          ),
        ),
      ]),
    );
  }
}
