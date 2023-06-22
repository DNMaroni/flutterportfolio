abstract class IClientHttp {
  Future get(String url, {String conCodigo});
  Future post(String url, Object jsonEncode, {int conCodigo});
  Future delete(String url, {int conCodigo});
  Future uploadFiles(String endpoint, List<dynamic> files,
      {Map<String, dynamic>? data});
}
