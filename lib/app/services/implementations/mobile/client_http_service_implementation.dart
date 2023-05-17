import 'dart:convert';
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
}
