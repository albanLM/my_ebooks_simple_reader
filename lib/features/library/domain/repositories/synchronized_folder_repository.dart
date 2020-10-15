import 'package:dartz/dartz.dart';
import 'package:my_ebooks_simple_reader/core/failures/failures.dart';
import 'package:my_ebooks_simple_reader/features/library/data/repositories/synchronized_folder_repository.dart';
import 'package:my_ebooks_simple_reader/features/library/domain/entities/synchronized_folder.dart';

class SynchronizedFolderRepositoryImpl implements SynchronizedFolderRepository {
  @override
  Future<Either<Failure, void>> addFolder(String path) {
    // TODO: implement addFolder
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<SynchronizedFolder>>> getFolders() {
    // TODO: implement getFolders
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, void>> removeFolder(int id) {
    // TODO: implement removeFolder
    throw UnimplementedError();
  }
}