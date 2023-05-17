// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '../../../../constants.dart';
import 'home_store.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late HomeStore store;

  Widget _buildLoading() {
    return const Center(child: CircularProgressIndicator());
  }

  @override
  void initState() {
    super.initState();

    store = Modular.get<HomeStore>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Constants.dados['colors']['primary'],
        iconTheme: const IconThemeData(
          color: Colors.white, //change your color here
        ),
        title: const Text(
          "Teste página",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: const Column(
        children: [],
      ),
      backgroundColor: Colors.grey[200],
    );
  }
}
