import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:portfolio/app/modules/home/errors/failure.dart';

import '../../../services/interfaces/client_http_service_interface.dart';

abstract class IHomeRepository {
  Future<Either<Failure, Map>> processVideo(File video);
}

class HomeRepositoryImplementation implements IHomeRepository {
  final IClientHttp clientHttp;

  HomeRepositoryImplementation(this.clientHttp);

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
