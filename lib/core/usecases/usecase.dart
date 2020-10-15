import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:my_ebooks_simple_reader/core/failures/failures.dart';

abstract class Usecase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

class NoParams extends Equatable {
  @override
  List<Object> get props => [];
}