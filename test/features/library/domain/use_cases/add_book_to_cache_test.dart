import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:my_ebooks_simple_reader/features/library/domain/entities/book.dart';
import 'package:my_ebooks_simple_reader/features/library/domain/repositories/book_repository.dart';
import 'package:my_ebooks_simple_reader/features/library/domain/use_cases/add_book_to_cache.dart';

class MockBookRepository extends Mock implements BookRepository {}

void main() {
  AddBookToCache addBook;
  MockBookRepository mockBookRepository;

  group('Add book to cache', () {
    setUp(() {
      mockBookRepository = MockBookRepository();
      addBook = AddBookToCache(mockBookRepository);
    });

    final filePath = 'some/path/to/a/file.epub';
    final tBook = Book(
        id: 1,
        author: 'J.K Rolling',
        title: 'Harry Potter et la chambre des Secrets',
        description: 'Un livre sur les sorciers',
        saga: 'Harry Potter',
        genres: ['Fantaisie'],
        language: 'Français',
        addDate: DateTime.now(),
        filePath: filePath,
        readState: ReadState.notRead,
        cover: null);

    test('should get books from the repository', () async {
      // arrange
      when(mockBookRepository.addBookFromFile(filePath))
          .thenAnswer((_) async => Right(tBook));

      // act
      final result = await addBook(filePath);

      // assert
      expect(result, Right(tBook));
    });
  });
}
