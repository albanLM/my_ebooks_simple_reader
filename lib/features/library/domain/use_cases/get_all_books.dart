import 'package:dartz/dartz.dart';
import 'package:my_ebooks_simple_reader/core/failures/failures.dart';
import 'package:my_ebooks_simple_reader/core/usecases/usecase.dart';
import 'package:my_ebooks_simple_reader/features/library/domain/entities/book.dart';
import 'package:my_ebooks_simple_reader/features/library/domain/repositories/book_repository.dart';

class GetAllBooks implements Usecase<List<Book>, NoParams> {
  final BookRepository bookRepository;

  GetAllBooks(this.bookRepository);

  @override
  Future<Either<Failure, List<Book>>> call(NoParams params){
    return bookRepository.getAllBooksFromCache();
  }
}