import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:my_ebooks_simple_reader/core/errors/failures.dart';
import 'package:my_ebooks_simple_reader/features/library/domain/entities/book.dart';
import 'package:my_ebooks_simple_reader/features/library/domain/entities/book_filter.dart';
import 'package:my_ebooks_simple_reader/features/library/domain/repositories/book_repository.dart';
import 'package:my_ebooks_simple_reader/features/library/domain/use_cases/get_books_with_filter.dart';

class MockBookRepository extends Mock implements BookRepository {}

void main() {
  MockBookRepository mockBookRepository;
  GetBooksWithFilter getBooksWithFilter;

  group('Get books correspind to a filter', () {
    setUp(() {
      mockBookRepository = MockBookRepository();
      getBooksWithFilter = GetBooksWithFilter(mockBookRepository);
    });

    final filter = BookFilter(title: 'Harry Potter');
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

    test(
        'should get all the books corresponding to the filter from the book repository',
        () async {
      // arrange
      final mockAnswer = Right<Failure, List<Book>>([tBook]);
      when(mockBookRepository.getFilteredBooksFromCache(filter))
          .thenAnswer((realInvocation) async => mockAnswer);

      // act
      final result = await getBooksWithFilter(filter);

      // assert
      expect(result, mockAnswer);
      verify(mockBookRepository.getFilteredBooksFromCache(any));
      verifyNoMoreInteractions(mockBookRepository);
    });
  });
}
