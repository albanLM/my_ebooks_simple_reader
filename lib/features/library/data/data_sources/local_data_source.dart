import 'package:my_ebooks_simple_reader/features/library/domain/entities/book.dart';
import 'package:my_ebooks_simple_reader/features/library/domain/entities/book_filter.dart';
import 'package:my_ebooks_simple_reader/features/library/domain/entities/synchronized_folder.dart';

abstract class LocalDataSource {
  // Book source
  Future<Book> addBookFromFile(String filePath);
  Future<List<Book>> addAllBooksFromDirectory(String directoryPath);
  Future<List<Book>> getAllBooks();
  Future<List<Book>> getFilteredBooks(BookFilter filter);
  Future<void> removeBook(int id);
  Future<void> removeAllBooks();

  // Synchronized folder source
  Future<void> addFolder(String path);
  Future<void> removeFolder(int id);
  Future<List<SynchronizedFolder>> getFolders();

}