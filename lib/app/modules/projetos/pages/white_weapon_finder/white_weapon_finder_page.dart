// ignore_for_file: library_private_types_in_public_api

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:image_picker/image_picker.dart';
import 'package:portfolio/app/modules/projetos/pages/white_weapon_finder/white_weapon_finder_store.dart';

class WhiteWeaponFinderPage extends StatefulWidget {
  const WhiteWeaponFinderPage({Key? key}) : super(key: key);

  @override
  _WhiteWeaponFinderPageState createState() => _WhiteWeaponFinderPageState();
}

class _WhiteWeaponFinderPageState extends State<WhiteWeaponFinderPage> {
  late WhiteWeaponFinderStore store;
  final ImagePicker picker = ImagePicker();

  //Widget _buildLoading() {
  //return const Center(child: CircularProgressIndicator());
  //}

  @override
  void initState() {
    super.initState();

    store = Modular.get<WhiteWeaponFinderStore>();
  }

  Future recordVideo() async {
    // Capture a video.
    final XFile? cameraVideo =
        await picker.pickVideo(source: ImageSource.camera);

    File video = File(cameraVideo!.path);
    await store.uploadVideo(video);
  }

  Future selectVideo() async {
    final XFile? galleryVideo =
        await picker.pickVideo(source: ImageSource.gallery);

    File video = File(galleryVideo!.path);
    await store.uploadVideo(video);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          color: Color.fromARGB(255, 33, 35, 39),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/knife.png',
                  width: 150,
                  height: 150,
                ),
                const SizedBox(
                  height: 50,
                ),
                const Text(
                  'Detector de armas brancas',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 27,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 50,
                ),
                RichText(
                  textAlign: TextAlign.center,
                  text: const TextSpan(
                    text: '',
                    children: [
                      TextSpan(
                          text: '1) ',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 20)),
                      TextSpan(
                          text: ' Grave ou selecione um vídeo no celular;',
                          style: TextStyle(color: Colors.white, fontSize: 20)),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                RichText(
                  textAlign: TextAlign.center,
                  text: const TextSpan(
                    text: '',
                    children: [
                      TextSpan(
                          text: '2) ',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 20)),
                      TextSpan(
                          text:
                              ' Aguarde enquanto geramos um vídeo detectando armas brancas;',
                          style: TextStyle(color: Colors.white, fontSize: 20)),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                RichText(
                  textAlign: TextAlign.center,
                  text: const TextSpan(
                    text: '',
                    children: [
                      TextSpan(
                        text: '3) ',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 20),
                      ),
                      TextSpan(
                        text: ' Baixe ou visualize o vídeo gerado.',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                SizedBox(
                  width: 170,
                  child: OutlinedButton(
                    style: const ButtonStyle(
                        backgroundColor:
                            MaterialStatePropertyAll(Colors.purple)),
                    onPressed: selectVideo,
                    child: const Row(
                      children: [
                        Icon(
                          Icons.video_collection,
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Selecionar vídeo',
                          style: TextStyle(color: Colors.white),
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  'OU',
                  style: TextStyle(color: Colors.white),
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: 150,
                  child: OutlinedButton(
                    style: const ButtonStyle(
                        backgroundColor:
                            MaterialStatePropertyAll(Colors.deepPurple)),
                    onPressed: recordVideo,
                    child: const Row(
                      children: [
                        Icon(
                          Icons.video_camera_back_rounded,
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Gravar vídeo',
                          style: TextStyle(color: Colors.white),
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                const Text(
                  'Saiba mais',
                  style: TextStyle(color: Colors.white),
                )
              ],
            ),
          ),
        ),
      ),
      backgroundColor: Colors.grey[200],
    );
  }
}
