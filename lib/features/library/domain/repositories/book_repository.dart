import 'package:dartz/dartz.dart';
import 'package:my_ebooks_simple_reader/core/errors/failures.dart';
import 'package:my_ebooks_simple_reader/features/library/domain/entities/book.dart';
import 'package:my_ebooks_simple_reader/features/library/domain/entities/book_filter.dart';

abstract class BookRepository {
  // Book files stored by the user on the device
  Future<Either<Failure, void>> addBooksFromFiles(List<String> filePaths);
  Future<Either<Failure, void>> addAllBooksFromDirectory(String directoryPath);

  // Book entities stored in the cache when books are first added
  // Future<Either<Failure, Book>> getBookFromCache(String filePath);
  Future<Either<Failure, List<Book>>> getAllBooksFromCache();
  Future<Either<Failure, List<Book>>> getFilteredBooksFromCache(BookFilter filter);
  Future<Either<Failure, void>> removeBooksFromCache(List<String> bookIDs);
  Future<Either<Failure, void>> removeAllBooksFromCache();
}