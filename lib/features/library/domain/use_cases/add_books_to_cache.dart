import 'package:dartz/dartz.dart';
import 'package:my_ebooks_simple_reader/core/errors/failures.dart';
import 'package:my_ebooks_simple_reader/core/usecases/usecase.dart';
import 'package:my_ebooks_simple_reader/features/library/domain/repositories/book_repository.dart';

class AddBooksToCache implements Usecase<void, List<String>> {
  final BookRepository bookRepository;

  AddBooksToCache(this.bookRepository);

  Future<Either<Failure, void>> call(List<String> filePaths) {
    return bookRepository.addBooksFromFiles(filePaths);
  }
}
