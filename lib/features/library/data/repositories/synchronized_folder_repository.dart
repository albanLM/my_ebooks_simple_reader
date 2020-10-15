import 'package:dartz/dartz.dart';
import 'package:my_ebooks_simple_reader/core/failures/failures.dart';
import 'package:my_ebooks_simple_reader/features/library/domain/entities/synchronized_folder.dart';

abstract class SynchronizedFolderRepository {
  Future<Failure> addFolders(List<String> directoryPaths);
  Future<Failure> removeFolders(List<int> ids);
  Future<Either<Failure, List<SynchronizedFolder>>> getFolders();
}