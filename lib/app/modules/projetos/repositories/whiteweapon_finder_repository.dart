import 'package:dartz/dartz.dart';

import '../../../services/interfaces/client_http_service_interface.dart';
import '../errors/failure.dart';

abstract class IWhitweaponFinderRepository {
  Future<Either<Failure, Map>> processVideo(
      dynamic video, Map<String, dynamic> filters);
}

class WhiteweaponFinderImplementation implements IWhitweaponFinderRepository {
  final IClientHttp clientHttp;

  WhiteweaponFinderImplementation(this.clientHttp);

  @override
  Future<Either<Failure, Map>> processVideo(
      dynamic video, Map<String, dynamic> filters) async {
    try {
      List<dynamic> files = [];
      files.add(video);

      var rtn = await clientHttp.uploadFiles('/api', files, data: filters);

      if (rtn['r'] == 'ok') {
        return Right(rtn);
      } else {
        return const Left(ServerException('Erro ao processar o vídeo'));
      }
    } catch (erro) {
      return const Left(ServerException('Erro ao processar o vídeo'));
    }
  }
}
