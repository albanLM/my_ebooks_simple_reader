import 'package:dartz/dartz.dart';
import 'package:my_ebooks_simple_reader/core/errors/exceptions.dart';
import 'package:my_ebooks_simple_reader/core/errors/failures.dart';
import 'package:my_ebooks_simple_reader/features/library/data/data_sources/local_data_source.dart';
import 'package:my_ebooks_simple_reader/features/library/domain/entities/book.dart';
import 'package:my_ebooks_simple_reader/features/library/domain/entities/book_filter.dart';
import 'package:my_ebooks_simple_reader/features/library/domain/repositories/book_repository.dart';

class BookRepositoryImpl implements BookRepository {
  final LocalDataSource localDataSource;

  BookRepositoryImpl(this.localDataSource);

  @override
  Future<Either<Failure, void>> addAllBooksFromDirectory(
      String directoryPath) async {
    try {
      return Right(
          await localDataSource.addAllBooksFromDirectory(directoryPath));
    } on CacheException {
      return Left(CacheFailure());
    } on FileException {
      return Left(FileFailure());
    }
  }

  @override
  Future<Either<Failure, void>> addBooksFromFiles(List<String> filePaths) async {
    try {
      return Right(await localDataSource.addBooks(filePaths));
    } on CacheException {
      return Left(CacheFailure());
    } on FileException {
      return Left(FileFailure());
    }
  }

  @override
  Future<Either<Failure, List<Book>>> getAllBooksFromCache() async {
    try {
      return Right(await localDataSource.getBooks());
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, List<Book>>> getFilteredBooksFromCache(
      BookFilter filter) async {
    try {
      return Right(await localDataSource.getFilteredBooks(filter));
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, void>> removeAllBooksFromCache() async {
    try {
      return Right(await localDataSource.removeAllBooks());
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, void>> removeBooksFromCache(List<String> bookIDs) async {
    try {
      return Right(await localDataSource.removeBooks(bookIDs));
    } on CacheException {
      return Left(CacheFailure());
    }
  }
}
