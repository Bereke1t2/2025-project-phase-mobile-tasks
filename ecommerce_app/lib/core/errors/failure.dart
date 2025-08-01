import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;

  const Failure(this.message);

  @override
  List<Object?> get props => [message];

  @override
  String toString() => 'Failure(message: $message)';
}

class ServerFailure extends Failure {
  const ServerFailure({required String message}) : super(message);
}

class CacheFailure extends Failure {
  const CacheFailure({required String message}) : super(message);
}

class RemoteFailure extends Failure {
  const RemoteFailure({required String message}) : super(message);
}


class NetworkFailure extends Failure {
  const NetworkFailure({required String message}) : super(message);
}