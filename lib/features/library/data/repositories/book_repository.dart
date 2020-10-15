import 'package:dartz/dartz.dart';
import 'package:my_ebooks_simple_reader/core/failures/failures.dart';
import 'package:my_ebooks_simple_reader/features/library/domain/entities/book.dart';
import 'package:my_ebooks_simple_reader/features/library/domain/entities/book_filter.dart';
import 'package:my_ebooks_simple_reader/features/library/domain/repositories/book_repository.dart';

class BookRepositoryImpl implements BookRepository {
  @override
  Future<Either<Failure, List<Book>>> addAllBooksFromDirectory(String directoryPath) {
    // TODO: implement addAllBooksFromDirectory
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, Book>> addBookFromFile(String filePath) {
    // TODO: implement addBookFromFile
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<Book>>> getAllBooksFromCache() {
    // TODO: implement getAllBooksFromCache
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<Book>>> getFilteredBooksFromCache(BookFilter filter) {
    // TODO: implement getFilteredBooksFromCache
    throw UnimplementedError();
  }

  @override
  Future<Failure> removeAllBooksFromCache() {
    // TODO: implement removeAllBooksFromCache
    throw UnimplementedError();
  }

  @override
  Future<Failure> removeBookFromCache(int bookID) {
    // TODO: implement removeBookFromCache
    throw UnimplementedError();
  }
}