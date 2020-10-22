import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:my_ebooks_simple_reader/core/enums.dart';
import 'package:my_ebooks_simple_reader/features/library/domain/entities/book.dart';
import 'package:my_ebooks_simple_reader/features/library/domain/repositories/book_repository.dart';
import 'package:my_ebooks_simple_reader/features/library/domain/use_cases/remove_books_from_cache.dart';

class MockBookRepository extends Mock implements BookRepository {}

void main() {
  MockBookRepository mockBookRepository;
  RemoveBooksFromCache removeBooksFromCache;

  group('Remove a book from the cache', () {
    setUp(() {
      mockBookRepository = MockBookRepository();
      removeBooksFromCache = RemoveBooksFromCache(mockBookRepository);
    });

    final tBook = Book(
        id: '123',
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

    test('should remove the book from the book repository', () async {
      // act
      final bookIdList = [tBook.id];
      await removeBooksFromCache(bookIdList);

      // assert
      verify(mockBookRepository.removeBooksFromCache(bookIdList));
      verifyNoMoreInteractions(mockBookRepository);
    });
  });
}
