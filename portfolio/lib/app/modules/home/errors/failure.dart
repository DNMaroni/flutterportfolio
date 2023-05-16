import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;

  const Failure(this.message);
}

class ServerFailure extends Failure {
  const ServerFailure(String message) : super(message);

  @override
  List<Object?> get props => [];
}

class ServerException extends Failure {
  const ServerException(String message) : super(message);

  @override
  List<Object?> get props => [];
}
