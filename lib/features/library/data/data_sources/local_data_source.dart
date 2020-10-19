import 'package:hive/hive.dart';
import 'package:my_ebooks_simple_reader/core/errors/exceptions.dart';
import 'package:my_ebooks_simple_reader/features/library/domain/entities/book.dart';
import 'package:my_ebooks_simple_reader/features/library/domain/entities/book_filter.dart';
import 'package:my_ebooks_simple_reader/features/library/domain/entities/synchronized_folder.dart';

abstract class LocalDataSource {
  // Book source
  Future<Book> addBookFromFile(String filePath);
  Future<List<Book>> addAllBooksFromDirectory(String directoryPath);
  Future<List<Book>> getBooks();
  Future<List<Book>> getFilteredBooks(BookFilter filter);
  Future<void> removeBook(int id);
  Future<void> removeAllBooks();

  // Synchronized folder source
  Future<void> addFolder(String path);
  Future<void> removeFolder(int id);
  Future<List<SynchronizedFolder>> getFolders();

}

class LocalDataSourceImpl implements LocalDataSource {
  final Box folderBox;
  final Box bookBox;

  LocalDataSourceImpl(this.folderBox, this.bookBox);

  @override
  Future<List<Book>> addAllBooksFromDirectory(String directoryPath) {
    // TODO: implement addAllBooksFromDirectory
    throw UnimplementedError();
  }

  @override
  Future<Book> addBookFromFile(String filePath) {
    // TODO: implement addBookFromFile
    throw UnimplementedError();
  }

  @override
  Future<void> addFolder(String path) {
    // TODO: implement addFolder
    throw UnimplementedError();
  }

  @override
  Future<List<Book>> getBooks() {
    throw CacheException();
  }

  @override
  Future<List<Book>> getFilteredBooks(BookFilter filter) {
    // TODO: implement getFilteredBooks
    throw UnimplementedError();
  }

  @override
  Future<List<SynchronizedFolder>> getFolders() {
    // TODO: implement getFolders
    throw UnimplementedError();
  }

  @override
  Future<void> removeAllBooks() {
    // TODO: implement removeAllBooks
    throw UnimplementedError();
  }

  @override
  Future<void> removeBook(int id) {
    // TODO: implement removeBook
    throw UnimplementedError();
  }

  @override
  Future<void> removeFolder(int id) {
    // TODO: implement removeFolder
    throw UnimplementedError();
  }
}