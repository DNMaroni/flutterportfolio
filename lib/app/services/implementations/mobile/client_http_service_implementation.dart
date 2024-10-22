import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../constants.dart';
import '../../interfaces/client_http_service_interface.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class ClientHttpServiceImplementation implements IClientHttp {
  final Dio dio;

  ClientHttpServiceImplementation(this.dio);

  final baseUrl = Constants.baseUrl;

  @override
  Future get(String url, {String? conCodigo}) async {
    dio.options.headers['content-Type'] = 'application/json';

    try {
      var response = await dio.get(baseUrl + url);

      return response;
    } catch (e) {
      //post('apicentral/discord', {"mensagem": "ERRO: " + e.toString()});

      return ({
        "r": "no",
        "data": 'Não foi possível, tente novamente mais tarde.'
      });
    }
  }

  @override
  Future post(String endpoint, dynamic data, {int? conCodigo}) async {
    dio.options.headers['content-Type'] = 'application/json';

    try {
      if (data is FormData) {
        var response = await dio.post(baseUrl + endpoint, data: data);
        return response.data;
      }
      // ignore: unnecessary_type_check
      if (data is Object) {
        var response =
            await dio.post(baseUrl + endpoint, data: jsonEncode(data));
        return response.data;
      }
    } catch (e) {
      String mensagemErro =
          'Provavelmente você não está na Branch correta. Verifica lá..';

      //post('apicentral/discord', {"mensagem": "ERRO: " + e.toString()});
      return ({"r": "no", "data": mensagemErro});
    }
  }

  @override
  Future delete(String url, {int? conCodigo}) async {
    dio.options.headers['content-Type'] = 'application/json';

    try {
      var response = await dio.delete(baseUrl + url);

      return response;
    } catch (e) {
      String mensagemErro =
          'Provavelmente você não está na Branch correta. Verifica lá..';

      post('apicentral/discord', {"mensagem": 'ERRO: $e'});
      return ({"r": "no", "data": mensagemErro});
    }
  }

  @override
  Future uploadFiles(String endpoint, List<dynamic> files,
      {Map<String, dynamic>? data}) async {
    if (files.isNotEmpty) {
      try {
        List<MultipartFile> arrayfiles = [];

        for (dynamic f in files) {
          if (kIsWeb) {
            XFile newVideo = f;

            arrayfiles.add(MultipartFile.fromBytes(await newVideo.readAsBytes(),
                filename: newVideo.name));
          } else {
            arrayfiles.add(await MultipartFile.fromFile(f.path,
                filename: f.path.split('/').last));
          }
        }

        Map<String, dynamic> requestData = {"upload[]": arrayfiles};

        if (data != null) {
          requestData.addAll(data);
        }

        FormData formData = FormData.fromMap(requestData);

        dio.options.headers["Authorization"] = "Bearer 123";

        var response =
            await dio.post(Constants.baseUrl + endpoint, data: formData);

        return json.decode(response.data);
      } catch (e) {
        return ({'r': 'no', 'data': e.toString()});
      }
    }
  }
}
