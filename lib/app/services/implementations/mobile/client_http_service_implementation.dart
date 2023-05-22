import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import '../../../../constants.dart';
import '../../interfaces/client_http_service_interface.dart';

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
  Future uploadFiles(String endpoint, List<File> files) async {
    if (files.isNotEmpty) {
      try {
        List<MultipartFile> arrayfiles = [];

        for (File f in files) {
          arrayfiles.add(await MultipartFile.fromFile(f.path,
              filename: f.path.split('/').last));
        }

        FormData formData = FormData.fromMap({"upload[]": arrayfiles});

        dio.options.headers["contentType"] = 'multipart/form-data';
        dio.options.headers["Authorization"] = "Bearer 123";

        var response =
            await dio.post(Constants.baseUrl + endpoint, data: formData);

        return response.data['data'];
      } catch (e) {
        return ({'r': 'no', 'data': e.toString()});
      }
    }
  }
}
