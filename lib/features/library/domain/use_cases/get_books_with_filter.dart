import 'package:dartz/dartz.dart';
import 'package:my_ebooks_simple_reader/core/errors/failures.dart';
import 'package:my_ebooks_simple_reader/core/usecases/usecase.dart';
import 'package:my_ebooks_simple_reader/features/library/domain/entities/book.dart';
import 'package:my_ebooks_simple_reader/features/library/domain/entities/book_filter.dart';
import 'package:my_ebooks_simple_reader/features/library/domain/repositories/book_repository.dart';

class GetBooksWithFilter implements Usecase<List<Book>, BookFilter> {
  final BookRepository bookRepository;

  GetBooksWithFilter(this.bookRepository);

  @override
  Future<Either<Failure, List<Book>>> call(BookFilter filter) {
    return bookRepository.getFilteredBooksFromCache(filter);
  }
}