import 'package:dartz/dartz.dart';
import 'package:my_ebooks_simple_reader/core/errors/failures.dart';
import 'package:my_ebooks_simple_reader/features/library/domain/entities/synchronized_folder.dart';

abstract class SynchronizedFolderRepository {
  Future<Either<Failure, void>> addFolder(String path);
  Future<Either<Failure, void>> removeFolder(int id);
  Future<Either<Failure, List<SynchronizedFolder>>> getFolders();
}