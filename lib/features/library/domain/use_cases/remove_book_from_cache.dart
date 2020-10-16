import 'package:dartz/dartz.dart';
import 'package:my_ebooks_simple_reader/core/errors/failures.dart';
import 'package:my_ebooks_simple_reader/core/usecases/usecase.dart';
import 'package:my_ebooks_simple_reader/features/library/domain/repositories/book_repository.dart';

class RemoveBookFromCache implements Usecase<void, int> {
  final BookRepository bookRepository;

  RemoveBookFromCache(this.bookRepository);

  @override
  Future<Either<Failure, void>> call(int id) {
    return bookRepository.removeBookFromCache(id);
  }
}