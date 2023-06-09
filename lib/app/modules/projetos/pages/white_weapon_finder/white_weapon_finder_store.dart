// ignore_for_file: unused_field, must_be_immutable

import 'dart:io';

import '../../repositories/whiteweapon_finder_repository.dart';

class WhiteWeaponFinderStore {
  final IWhitweaponFinderRepository _repository;

  WhiteWeaponFinderStore(this._repository);

  Future<dynamic> uploadVideo(File video) async {
    final resultado = await _repository.processVideo(video);
    resultado.fold((failure) {
      return failure.message;
    }, (message) {
      return message;
    });
  }
}
