import 'dart:io';

import 'package:dartz/dartz.dart';

import '../../../services/interfaces/client_http_service_interface.dart';
import '../errors/failure.dart';

abstract class IWhitweaponFinderRepository {
  Future<Either<Failure, Map>> processVideo(File video);
}

class WhiteweaponFinderImplementation implements IWhitweaponFinderRepository {
  final IClientHttp clientHttp;

  WhiteweaponFinderImplementation(this.clientHttp);

  @override
  Future<Either<Failure, Map>> processVideo(File video) async {
    try {
      List<File> files = [];
      files.add(video);

      var rtn = await clientHttp.uploadFiles('/api', files);

      if (rtn['r'] == 'ok') {
        return const Right({'r': 'tudo certo'});
      } else {
        return const Left(ServerException('Erro ao processar o vídeo'));
      }
    } catch (erro) {
      return const Left(ServerException('Erro ao processar o vídeo'));
    }
  }
}
