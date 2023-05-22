// ignore_for_file: unused_field, must_be_immutable

import 'dart:io';

import '../repositories/home_repository.dart';

class HomeStore {
  final IHomeRepository _repository;

  HomeStore(this._repository);

  Future<dynamic> uploadVideo(File video) async {
    final resultado = await _repository.processVideo(video);
    resultado.fold((failure) {
      return failure.message;
    }, (message) {
      return message;
    });
  }
}
