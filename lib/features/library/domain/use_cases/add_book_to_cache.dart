import 'package:dartz/dartz.dart';
import 'package:my_ebooks_simple_reader/core/failures/failures.dart';
import 'package:my_ebooks_simple_reader/core/usecases/usecase.dart';
import 'package:my_ebooks_simple_reader/features/library/domain/entities/book.dart';
import 'package:my_ebooks_simple_reader/features/library/domain/repositories/book_repository.dart';

class AddBookToCache implements Usecase<Book, String> {
  final BookRepository bookRepository;

  AddBookToCache(this.bookRepository);

  Future<Either<Failure, Book>> call(String filePath) {
    return bookRepository.addBookFromFile(filePath);
  }
}
