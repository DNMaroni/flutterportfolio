// ignore_for_file: unused_field, must_be_immutable

import 'dart:io';
import '../../repositories/imovel_tipo_finder_repository.dart';

class ImovelTipoFinderStore {
  final IImovelTipoFinderRepository _repository;

  ImovelTipoFinderStore(this._repository);

  Future<Map> uploadImage(File image) async {
    final resultado = await _repository.processImage(image);

    return resultado.fold((failure) {
      return {'r': 'no', 'data': failure.message.toString()};
    }, (message) {
      return message;
    });
  }
}
