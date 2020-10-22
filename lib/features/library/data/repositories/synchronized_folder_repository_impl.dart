import 'package:dartz/dartz.dart';
import 'package:my_ebooks_simple_reader/core/errors/exceptions.dart';
import 'package:my_ebooks_simple_reader/core/errors/failures.dart';
import 'package:my_ebooks_simple_reader/features/library/data/data_sources/local_data_source.dart';
import 'package:my_ebooks_simple_reader/features/library/domain/entities/synchronized_folder.dart';
import 'package:my_ebooks_simple_reader/features/library/domain/repositories/synchronized_folder_repository.dart';

class SynchronizedFolderRepositoryImpl implements SynchronizedFolderRepository {
  final LocalDataSource localDataSource;

  SynchronizedFolderRepositoryImpl(this.localDataSource);

  @override
  Future<Either<Failure, void>> addFolders(List<String> folderPaths) async {
    try {
      return Right(await localDataSource.addFolders(folderPaths));
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, List<SynchronizedFolder>>> getFolders() async {
    try {
      return Right(await localDataSource.getFolders());
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, void>> removeFolders(List<int> ids) async {
    try {
      return Right(await localDataSource.removeFolders(ids));
    } on CacheException {
      return Left(CacheFailure());
    }
  }
}