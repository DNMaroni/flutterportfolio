// ignore_for_file: library_private_types_in_public_api

import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:image_picker/image_picker.dart';
import 'package:portfolio/app/modules/projetos/pages/white_weapon_finder/white_weapon_finder_store.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter/foundation.dart' show Uint8List, kIsWeb;
import '../../../../services/window_service.dart'
    if (dart.library.html) "dart:html" as WEB;

import '../../../../components/snackbar_manager.dart';
import '../../../../components/video_component.dart';

class WhiteWeaponFinderPage extends StatefulWidget {
  const WhiteWeaponFinderPage({Key? key}) : super(key: key);

  @override
  _WhiteWeaponFinderPageState createState() => _WhiteWeaponFinderPageState();
}

class _WhiteWeaponFinderPageState extends State<WhiteWeaponFinderPage> {
  late WhiteWeaponFinderStore store;
  final ImagePicker picker = ImagePicker();
  late VideoPlayerController _controller;

  //Widget _buildLoading() {
  //return const Center(child: CircularProgressIndicator());
  //}

  bool loading = false;
  bool videoready = false;
  Widget videoWidget = Container();
  int fpsin = 5;
  int fpsout = 20;
  int scale = 1;
  int confidence = 50;

  @override
  void initState() {
    super.initState();

    store = Modular.get<WhiteWeaponFinderStore>();
  }

  Future getVideo(int tipo, context) async {
    // Capture a video.
    final XFile? cameraVideo = await picker.pickVideo(
        source: tipo == 1 ? ImageSource.gallery : ImageSource.camera);

    if (cameraVideo != null) {
      dynamic video;

      if (kIsWeb) {
        video = cameraVideo;
      } else {
        video = File(cameraVideo.path);
      }

      setState(() {
        loading = true;
      });

      Map<String, dynamic> configs = {
        'fpsin': fpsin,
        'fpsout': fpsout,
        'scale': scale,
        'confidence': confidence
      };

      var rtn = await store.uploadVideo(video, configs);

      if (rtn['r'] == 'ok') {
        SnackBarManager().showSuccess(context, 'Vídeo gerado com sucesso.');

        setState(() {
          if (!kIsWeb) {
            videoready = true;
            videoWidget = VideoComponent(rtn['data']);
          } else {
            Uint8List bytes = base64.decode(rtn['data']);

            var blob = WEB.Blob([bytes], 'video/mp4', 'native');

            var anchorElement = WEB.AnchorElement(
              href: WEB.Url.createObjectUrlFromBlob(blob).toString(),
            )
              ..setAttribute("download", "output.mp4")
              ..click();
          }
        });
      } else {
        SnackBarManager().showError(context, rtn['data']);
      }

      setState(() {
        loading = false;
      });
    }
  }

  List<DropdownMenuItem<int>> selectItems(int qtd) {
    List<DropdownMenuItem<int>> items = [];

    for (var i = 1; i <= qtd; i++) {
      items.add(DropdownMenuItem<int>(
        value: i,
        child: Text(i.toString()),
      ));
    }

    return items;
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
                const SizedBox(
                  height: 30,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: IconButton(
                      onPressed: () => Modular.to.pop(),
                      icon: const Icon(
                        Icons.arrow_back_ios_rounded,
                        color: Colors.white,
                        size: 30,
                      )),
                ),
                const SizedBox(
                  height: 5,
                ),
                Visibility(
                  visible: !videoready,
                  child: Column(
                    children: [
                      Image.asset(
                        'assets/images/knife.png',
                        width: 120,
                        height: 120,
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      const Text(
                        'Detector de armas brancas',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 30,
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
                                    fontSize: 16)),
                            TextSpan(
                                text:
                                    ' Grave ou selecione um vídeo no celular/computador;',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20)),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 15,
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
                                    fontSize: 16)),
                            TextSpan(
                                text:
                                    ' Aguarde enquanto geramos um vídeo detectando armas brancas;',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20)),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 15,
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
                                  fontSize: 16),
                            ),
                            TextSpan(
                              text: ' Visualize o vídeo gerado.',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                videoWidget,
                Visibility(
                  visible: !loading && !videoready,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              const Text(
                                'FPS de entrada:  ',
                                style: TextStyle(color: Colors.white),
                              ),
                              SizedBox(
                                height: 40,
                                child: DropdownButton<int>(
                                  value: fpsin,
                                  icon: null,
                                  elevation: 16,
                                  style: const TextStyle(color: Colors.purple),
                                  underline: Container(
                                    height: 2,
                                    color: Colors.purple,
                                  ),
                                  onChanged: (int? value) {
                                    // This is called when the user selects an item.
                                    setState(() {
                                      fpsin = value!;
                                    });
                                  },
                                  items: selectItems(60),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            width: 25,
                          ),
                          Row(
                            children: [
                              const Text(
                                'FPS de saída:  ',
                                style: TextStyle(color: Colors.white),
                              ),
                              SizedBox(
                                height: 40,
                                child: DropdownButton<int>(
                                  value: fpsout,
                                  icon: null,
                                  elevation: 16,
                                  style: const TextStyle(color: Colors.purple),
                                  underline: Container(
                                    height: 2,
                                    color: Colors.purple,
                                  ),
                                  onChanged: (int? value) {
                                    // This is called when the user selects an item.
                                    setState(() {
                                      fpsout = value!;
                                    });
                                  },
                                  items: selectItems(60),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              const Text(
                                'Escala de saída:  ',
                                style: TextStyle(color: Colors.white),
                              ),
                              SizedBox(
                                height: 40,
                                child: DropdownButton<int>(
                                  value: scale,
                                  icon: null,
                                  elevation: 16,
                                  style: const TextStyle(color: Colors.purple),
                                  underline: Container(
                                    height: 2,
                                    color: Colors.purple,
                                  ),
                                  onChanged: (int? value) {
                                    // This is called when the user selects an item.
                                    setState(() {
                                      scale = value!;
                                    });
                                  },
                                  items: selectItems(5),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(width: 20),
                          Row(
                            children: [
                              const Text(
                                'Confiança min.:  ',
                                style: TextStyle(color: Colors.white),
                              ),
                              SizedBox(
                                height: 40,
                                child: DropdownButton<int>(
                                  value: confidence,
                                  icon: null,
                                  elevation: 16,
                                  style: const TextStyle(color: Colors.purple),
                                  underline: Container(
                                    height: 2,
                                    color: Colors.purple,
                                  ),
                                  onChanged: (int? value) {
                                    // This is called when the user selects an item.
                                    setState(() {
                                      confidence = value!;
                                    });
                                  },
                                  items: selectItems(100),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Visibility(
                    visible: loading,
                    child: const CircularProgressIndicator.adaptive()),
                Visibility(
                  visible: !loading && !videoready,
                  child: Column(
                    children: [
                      SizedBox(
                        width: 170,
                        child: OutlinedButton(
                          style: const ButtonStyle(
                              backgroundColor:
                                  MaterialStatePropertyAll(Colors.purple)),
                          onPressed: () => getVideo(1, context),
                          child: const Row(
                            children: [
                              Icon(
                                Icons.video_collection,
                                color: Colors.white,
                                size: 17,
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
                          onPressed: () => getVideo(2, context),
                          child: const Row(
                            children: [
                              Icon(
                                Icons.video_camera_back_rounded,
                                color: Colors.white,
                                size: 17,
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
                    ],
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
              ],
            ),
          ),
        ),
      ),
      backgroundColor: Colors.grey[200],
    );
  }
}
