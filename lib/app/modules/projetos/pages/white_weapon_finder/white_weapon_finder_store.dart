// ignore_for_file: unused_field, must_be_immutable

import '../../repositories/whiteweapon_finder_repository.dart';

class WhiteWeaponFinderStore {
  final IWhitweaponFinderRepository _repository;

  WhiteWeaponFinderStore(this._repository);

  Future<Map> uploadVideo(dynamic video, Map<String, dynamic> filters) async {
    final resultado = await _repository.processVideo(video, filters);

    return resultado.fold((failure) {
      return {'r': 'no', 'data': failure.message};
    }, (message) {
      return message;
    });
  }
}
