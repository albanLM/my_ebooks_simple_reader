import 'package:dartz/dartz.dart';
import 'package:my_ebooks_simple_reader/core/errors/failures.dart';
import 'package:my_ebooks_simple_reader/features/library/domain/entities/synchronized_folder.dart';

abstract class SynchronizedFolderRepository {
  Future<Either<Failure, void>> addFolders(List<String> folderPaths);
  Future<Either<Failure, void>> removeFolders(List<int> ids);
  Future<Either<Failure, List<SynchronizedFolder>>> getFolders();
}