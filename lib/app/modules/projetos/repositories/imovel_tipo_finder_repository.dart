import 'dart:io';

import 'package:dartz/dartz.dart';

import '../../../services/interfaces/client_http_service_interface.dart';
import '../errors/failure.dart';

abstract class IImovelTipoFinderRepository {
  Future<Either<Failure, Map>> processImage(File image);
}

class ImovelTipoFinderImplementation implements IImovelTipoFinderRepository {
  final IClientHttp clientHttp;

  ImovelTipoFinderImplementation(this.clientHttp);

  @override
  Future<Either<Failure, Map>> processImage(File imagem) async {
    try {
      List<File> files = [];
      files.add(imagem);

      var rtn = await clientHttp.uploadFiles('/api/imoveltipo', files);

      if (rtn['r'] == 'ok') {
        return Right(rtn);
      } else {
        return Left(
            ServerException(rtn['data'] ?? 'Erro ao processar a imagem'));
      }
    } catch (erro) {
      return const Left(ServerException('Erro ao processar a imagem'));
    }
  }
}
