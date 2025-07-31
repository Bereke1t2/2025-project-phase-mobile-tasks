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
  const ServerFailure() : super('Server failure occurred');
}