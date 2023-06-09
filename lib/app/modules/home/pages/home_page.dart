// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '../../../../constants.dart';
import '../../projetos/pages/projetos_home_page.dart';
import 'home_store.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late HomeStore store;

  @override
  void initState() {
    super.initState();

    store = Modular.get<HomeStore>();
  }

  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'Daniel Maroni - Portfólio',
          style: TextStyle(color: Colors.black),
        ),
      ),
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        selectedIndex: currentPageIndex,
        destinations: const <Widget>[
          NavigationDestination(
            icon: Icon(Icons.person),
            label: 'Quem sou eu',
          ),
          NavigationDestination(
            icon: Icon(Icons.folder),
            label: 'Projetos',
          ),
        ],
      ),
      body: <Widget>[
        Container(
          color: Constants.dados['colors']['backgroundGrey'],
          alignment: Alignment.center,
          child: const Text('Página em construção'),
        ),
        Container(
          color: Constants.dados['colors']['backgroundGrey'],
          alignment: Alignment.center,
          child: const ProjetosHomePage(),
        ),
      ][currentPageIndex],
    );
  }
}
