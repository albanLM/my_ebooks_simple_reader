import 'package:dartz/dartz.dart';
import 'package:my_ebooks_simple_reader/core/errors/failures.dart';
import 'package:my_ebooks_simple_reader/core/usecases/usecase.dart';
import 'package:my_ebooks_simple_reader/features/library/domain/repositories/book_repository.dart';

class RemoveBooksFromCache implements Usecase<void, List<String>> {
  final BookRepository bookRepository;

  RemoveBooksFromCache(this.bookRepository);

  @override
  Future<Either<Failure, void>> call(List<String> ids) {
    return bookRepository.removeBooksFromCache(ids);
  }
}