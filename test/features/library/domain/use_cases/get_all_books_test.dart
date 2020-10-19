import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:my_ebooks_simple_reader/core/enums.dart';
import 'package:my_ebooks_simple_reader/core/errors/failures.dart';
import 'package:my_ebooks_simple_reader/core/usecases/usecase.dart';
import 'package:my_ebooks_simple_reader/features/library/domain/entities/book.dart';
import 'package:my_ebooks_simple_reader/features/library/domain/repositories/book_repository.dart';
import 'package:my_ebooks_simple_reader/features/library/domain/use_cases/get_all_books.dart';

class MockBookRepository extends Mock implements BookRepository {}

void main() {
  GetAllBooks getAllBooks;
  MockBookRepository mockBookRepository;

  group('Get all books from the cache', () {
    setUp(() {
      mockBookRepository = MockBookRepository();
      getAllBooks = GetAllBooks(mockBookRepository);
    });

    final tBook = Book(
        id: 1,
        author: 'J.K Rolling',
        title: 'Harry Potter et la chambre des Secrets',
        description: 'Un livre sur les sorciers',
        saga: 'Harry Potter',
        genres: ['Fantaisie'],
        language: 'Français',
        addDate: DateTime.now(),
        filePath: '/some/file/path',
        readState: ReadState.notRead,
        cover: null);

    test('should get all books from the book repository', () async {
      // arrange
      final bookResult = Right<Failure, List<Book>>([tBook]);
      when(mockBookRepository.getAllBooksFromCache())
          .thenAnswer((_) async => bookResult);

      // act
      final result = await getAllBooks(NoParams());

      // assert
      expect(result, bookResult);
      verify(mockBookRepository.getAllBooksFromCache());
      verifyNoMoreInteractions(mockBookRepository);
    });
  });
}
