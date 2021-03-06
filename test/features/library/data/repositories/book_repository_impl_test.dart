import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:my_ebooks_simple_reader/core/enums.dart';
import 'package:my_ebooks_simple_reader/core/errors/exceptions.dart';
import 'package:my_ebooks_simple_reader/core/errors/failures.dart';
import 'package:my_ebooks_simple_reader/features/library/data/data_sources/local_data_source.dart';
import 'package:my_ebooks_simple_reader/features/library/data/models/book_model.dart';
import 'package:my_ebooks_simple_reader/features/library/data/repositories/book_repository_impl.dart';
import 'package:my_ebooks_simple_reader/features/library/domain/entities/book.dart';
import 'package:my_ebooks_simple_reader/features/library/domain/entities/book_filter.dart';

class MockLocalDataSource extends Mock implements LocalDataSource {}

void main() {
  MockLocalDataSource mockLocalDataSource;
  BookRepositoryImpl bookRepositoryImpl;

  group('Implementation of BookRepository', () {
    setUp(() {
      mockLocalDataSource = MockLocalDataSource();
      bookRepositoryImpl = BookRepositoryImpl(mockLocalDataSource);
    });

    final tBook = BookModel(
        id: '123',
        author: 'J.K Rolling',
        title: 'Harry Potter et la chambre des Secrets',
        description: 'Un livre sur les sorciers',
        saga: 'Harry Potter',
        genres: ['Fantaisie'],
        language: 'Français',
        addDate: DateTime.now(),
        filePath: 'some/file/path',
        readState: ReadState.notRead,
        cover: null);
    final filter = BookFilter(title: 'Harry Potter');
    final path = '/some/path/HarryPotter.epub';

    group('repository methods', () {
      test('should get book from local data source', () async {
        // arrange
        final mockAnswer = [tBook];
        when(mockLocalDataSource.getBooks()).thenAnswer((_) async => mockAnswer);

        // act
        final result = await bookRepositoryImpl.getAllBooksFromCache();

        // assert
        expect(result, Right<Failure, List<Book>>(mockAnswer));
        verify(mockLocalDataSource.getBooks());
        verifyNoMoreInteractions(mockLocalDataSource);
      });

      test('should get filtered book from local data source', () async {
        // arrange
        final mockAnswer = [tBook];
        when(mockLocalDataSource.getFilteredBooks(filter))
            .thenAnswer((_) async => mockAnswer);

        // act
        final result = await bookRepositoryImpl.getFilteredBooksFromCache(filter);

        // assert
        expect(result, Right<Failure, List<Book>>(mockAnswer));
        verify(mockLocalDataSource.getFilteredBooks(filter));
        verifyNoMoreInteractions(mockLocalDataSource);
      });

      test('should add book to the local data source', () async {
        // act
        final bookPaths = [path];
        await bookRepositoryImpl.addBooksFromFiles(bookPaths);

        // assert
        verify(mockLocalDataSource.addBooks(bookPaths));
        verifyNoMoreInteractions(mockLocalDataSource);
      });

      test('should add books from directory to the local data source', () async {
        // act
        await bookRepositoryImpl.addAllBooksFromDirectory(path);

        // assert
        verify(mockLocalDataSource.addAllBooksFromDirectory(path));
        verifyNoMoreInteractions(mockLocalDataSource);
      });

      test('should remove a book from local data source', () async {
        // act
        final bookIds = [tBook.id];
        await bookRepositoryImpl.removeBooksFromCache(bookIds);

        // assert
        verify(mockLocalDataSource.removeBooks(bookIds));
        verifyNoMoreInteractions(mockLocalDataSource);
      });

      test('should remove all books from local data source', () async {
        // act
        await bookRepositoryImpl.removeAllBooksFromCache();

        // assert
        verify(mockLocalDataSource.removeAllBooks());
        verifyNoMoreInteractions(mockLocalDataSource);
      });
    });

    group('error handling', () {
      test('should return a failure when getting books throws an exception',
          () async {
        // arrange
        when(mockLocalDataSource.getBooks()).thenThrow(CacheException());

        // act
        final result = await bookRepositoryImpl.getAllBooksFromCache();

        // assert
        expect(result, Left(CacheFailure()));
      });
      test(
          'should return a failure when getting filtered books throws an exception',
          () async {
        // arrange
        when(mockLocalDataSource.getFilteredBooks(any))
            .thenThrow(CacheException());

        // act
        final result =
            await bookRepositoryImpl.getFilteredBooksFromCache(filter);

        // assert
        expect(result, Left(CacheFailure()));
      });
      test('should return a failure when adding a book throws an exception',
          () async {
        // arrange
        when(mockLocalDataSource.addBooks(any)).thenThrow(CacheException());

        // act
        final result = await bookRepositoryImpl.addBooksFromFiles([path]);

        // assert
        expect(result, Left(CacheFailure()));
      });
      test(
          'should return a failure when adding books from directory throws an exception',
          () async {
        // arrange
        when(mockLocalDataSource.addAllBooksFromDirectory(any))
            .thenThrow(CacheException());

        // act
        final result = await bookRepositoryImpl.addAllBooksFromDirectory(path);

        // assert
        expect(result, Left(CacheFailure()));
      });
      test('should return a failure when removing a book throws an exception',
          () async {
        // arrange
        when(mockLocalDataSource.removeBooks(any))
            .thenThrow(CacheException());

        // act
        final result = await bookRepositoryImpl.removeBooksFromCache([tBook.id]);

        // assert
        expect(result, Left(CacheFailure()));
      });
      test(
          'should return a failure when removing all books throws an exception',
          () async {
        // arrange
        when(mockLocalDataSource.removeAllBooks()).thenThrow(CacheException());

        // act
        final result = await bookRepositoryImpl.removeAllBooksFromCache();

        // assert
        expect(result, Left(CacheFailure()));
      });
    });
  });
}
