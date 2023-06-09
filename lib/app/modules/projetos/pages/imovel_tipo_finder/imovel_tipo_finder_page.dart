// ignore_for_file: library_private_types_in_public_api

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:image_picker/image_picker.dart';
import 'package:portfolio/app/modules/projetos/pages/imovel_tipo_finder/imovel_tipo_finder_store.dart';

import '../../../../components/snackbar_manager.dart';

class ImovelTipoFinderPage extends StatefulWidget {
  const ImovelTipoFinderPage({Key? key}) : super(key: key);

  @override
  _ImovelTipoFinderPageState createState() => _ImovelTipoFinderPageState();
}

class _ImovelTipoFinderPageState extends State<ImovelTipoFinderPage> {
  late ImovelTipoFinderStore store;
  final ImagePicker picker = ImagePicker();

  //Widget _buildLoading() {
  //return const Center(child: CircularProgressIndicator());
  //}

  bool loading = false;

  @override
  void initState() {
    super.initState();

    store = Modular.get<ImovelTipoFinderStore>();
  }

  Future takePicture() async {
    // Capture a video.
    final XFile? image = await picker.pickImage(source: ImageSource.camera);

    File video = File(image!.path);

    setState(() {
      loading = true;
    });
    var rtn = await store.uploadImage(video);

    if (rtn['r'] == 'ok') {
      SnackBarManager().showSuccess(context, rtn['data']);
    } else {
      SnackBarManager().showError(context, rtn['data']);
    }

    setState(() {
      loading = false;
    });
  }

  Future selectPicture() async {
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    File video = File(image!.path);

    setState(() {
      loading = true;
    });

    var rtn = await store.uploadImage(video);

    if (rtn['r'] == 'ok') {
      SnackBarManager().showSuccess(context, rtn['data']);
    } else {
      SnackBarManager().showError(context, rtn['data']);
    }

    setState(() {
      loading = false;
    });
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
                  'assets/images/house_finder.png',
                  width: 150,
                  height: 150,
                ),
                const SizedBox(
                  height: 50,
                ),
                const Text(
                  'Detector de tipo de imóvel',
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
                          text: ' Tire uma nova foto ou selecione do celular;',
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
                              ' Aguarde enquanto detectamos o tipo do imóvel;',
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
                        text:
                            ' Visualize o tipo do imóvel (trata-se de um palpite, que não é 100% acertivo).',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                Visibility(
                    visible: loading,
                    child: const CircularProgressIndicator.adaptive()),
                Visibility(
                  visible: !loading,
                  child: Column(children: [
                    SizedBox(
                      width: 190,
                      child: OutlinedButton(
                        style: const ButtonStyle(
                            backgroundColor:
                                MaterialStatePropertyAll(Colors.purple)),
                        onPressed: selectPicture,
                        child: const Row(
                          children: [
                            Icon(
                              Icons.image,
                              color: Colors.white,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              'Selecionar imagem',
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
                      width: 160,
                      child: OutlinedButton(
                        style: const ButtonStyle(
                            backgroundColor:
                                MaterialStatePropertyAll(Colors.deepPurple)),
                        onPressed: takePicture,
                        child: const Row(
                          children: [
                            Icon(
                              Icons.camera_enhance_rounded,
                              color: Colors.white,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              'Tirar uma foto',
                              style: TextStyle(color: Colors.white),
                            )
                          ],
                        ),
                      ),
                    ),
                  ]),
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
