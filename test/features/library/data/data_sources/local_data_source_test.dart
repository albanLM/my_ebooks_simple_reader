import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:mockito/mockito.dart';
import 'package:my_ebooks_simple_reader/core/enums.dart';
import 'package:my_ebooks_simple_reader/core/errors/exceptions.dart';
import 'package:my_ebooks_simple_reader/features/library/data/data_sources/local_data_source.dart';
import 'package:my_ebooks_simple_reader/features/library/data/models/book_model.dart';
import 'package:my_ebooks_simple_reader/features/library/domain/entities/book_filter.dart';
import 'package:my_ebooks_simple_reader/features/library/domain/entities/synchronized_folder.dart';

class MockHiveBox extends Mock implements Box {}

class MockHiveLazyBox extends Mock implements LazyBox {}

void main() {
  MockHiveBox mockFolderBox;
  MockHiveBox mockBookBox;
  LocalDataSourceImpl localDataSourceImpl;

  group('Implementation of LocalDataSource', () {
    setUp(() {
      mockFolderBox = MockHiveBox();
      mockBookBox = MockHiveBox();
      localDataSourceImpl = LocalDataSourceImpl(mockFolderBox, mockBookBox);
    });

    group('caches contain books and folders', () {
      setUp(() {
        when(mockFolderBox.isEmpty).thenReturn(false);
        when(mockFolderBox.isNotEmpty).thenReturn(true);
        when(mockBookBox.isEmpty).thenReturn(false);
        when(mockBookBox.isNotEmpty).thenReturn(true);
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
          filePath: '/some/path/to/file.epub',
          readState: ReadState.notRead,
          cover: null);
      final tBook2 = BookModel(
          id: '124',
          author: 'J.K Rolling',
          title: 'Harry Potter et le prisonnier d\'azkaban',
          description: 'Un autre livre sur les sorciers',
          saga: 'Harry Potter',
          genres: ['Fantaisie'],
          language: 'Français',
          addDate: DateTime.now(),
          filePath: '/some/path/to/file2.epub',
          readState: ReadState.notRead,
          cover: null);

      final tFolder = SynchronizedFolder(id: 0, path: '/some/path/to/folder');

      test('should get all books', () async {
        // arrange
        final mockAnswer = [tBook];
        when(mockBookBox.values).thenReturn(mockAnswer);

        // act
        final result = await localDataSourceImpl.getBooks();

        // assert
        expect(result, mockAnswer);
        verifyNoMoreInteractions(mockFolderBox);
      });

      test('should get all folders', () async {
        // arrange
        final mockAnswer = [tFolder];
        when(mockFolderBox.values).thenReturn(mockAnswer);

        // act
        final result = await localDataSourceImpl.getFolders();

        // assert
        expect(result, mockAnswer);
        verifyNoMoreInteractions(mockBookBox);
      });

      test('should add books', () async {
        // arrange
        final path =
            '/home/alban/AndroidStudioProjects/my_ebooks_simple_reader/test/fixtures/GeographyofBliss_oneChapter.epub';

        // act
        await localDataSourceImpl.addBooks([path]);

        // assert
        verify(mockBookBox.put(any, any)).called(1);
        verifyNoMoreInteractions(mockFolderBox);
      });

      test('should add folders', () async {
        // arrange
        final path =
            '/home/alban/AndroidStudioProjects/my_ebooks_simple_reader/test/fixtures';

        // act
        await localDataSourceImpl.addFolders([path]);

        // assert
        verify(mockFolderBox.put(any, any)).called(1);
        verifyNoMoreInteractions(mockBookBox);
      });

      test('should remove books', () async {
        // arrange
        final bookIds = ['123', '456'];

        // act
        await localDataSourceImpl.removeBooks(bookIds);

        // assert
        verify(mockBookBox.deleteAll(any));
        verifyNoMoreInteractions(mockBookBox);
        verifyNoMoreInteractions(mockFolderBox);
      });

      test('should remove folders', () async {
        // act
        final folderIds = [1, 2, 3];
        await localDataSourceImpl.removeFolders(folderIds);

        // assert
        verify(mockFolderBox.deleteAll(any));
        verifyNoMoreInteractions(mockFolderBox);
        verifyNoMoreInteractions(mockBookBox);
      });

      test('should remove all books', () async {
        // act
        await localDataSourceImpl.removeAllBooks();

        // assert
        verify(mockBookBox.deleteAll(any));
        verifyNoMoreInteractions(mockFolderBox);
      });

      test('should add all the books of a given directory', () async {
        // arrange
        final path =
            '/home/alban/AndroidStudioProjects/my_ebooks_simple_reader/test/fixtures/epubs/Beautiful Bastard';

        // act
        await localDataSourceImpl.addAllBooksFromDirectory(path);

        // assert
        verify(mockBookBox.put(any, any)).called(10);
        verifyNoMoreInteractions(mockBookBox);
        verifyNoMoreInteractions(mockFolderBox);
      });

      test('should get filtered books', () async {
        // arrange
        final filter = BookFilter(
            author: tBook.author,
            title: tBook.title,
            saga: tBook.saga,
            genres: tBook.genres,
            language: [tBook.language],
            readState: [tBook.readState]);
        final mockAnswer = [tBook, tBook2];
        when(mockBookBox.values).thenReturn(mockAnswer);

        // act
        final result = await localDataSourceImpl.getFilteredBooks(filter);

        // assert
        expect(result.length, 1);
        expect(result.first, tBook);
        verifyNoMoreInteractions(mockFolderBox);
      });

      test('should return an empty list if no book fits with the filter',
          () async {
        // arrange
        final filter = BookFilter(author: 'George Lucas');
        final mockAnswer = [tBook];
        when(mockBookBox.values).thenReturn(mockAnswer);

        // act
        final result = await localDataSourceImpl.getFilteredBooks(filter);

        // assert
        expect(result, isEmpty);
        verifyNoMoreInteractions(mockFolderBox);
      });
    });

    group('caches are empty', () {
      setUp(() {
        when(mockFolderBox.isEmpty).thenReturn(true);
        when(mockBookBox.isEmpty).thenReturn(true);
        when(mockFolderBox.isNotEmpty).thenReturn(false);
        when(mockBookBox.isNotEmpty).thenReturn(false);
      });

      test('should return an empty list when getting books', () async {
        // act
        final result = await localDataSourceImpl.getBooks();

        // assert
        expect(result, isEmpty);
        verifyNever(mockBookBox.values);
      });

      test('should return an empty list when getting filtered books', () async {
        // act
        final filter = BookFilter(title: 'Harry Potter');
        final result = await localDataSourceImpl.getFilteredBooks(filter);

        // assert
        expect(result, isEmpty);
        verifyNever(mockBookBox.values);
      });

      test('should return an empty list when getting folders', () async {
        // act
        final result = await localDataSourceImpl.getFolders();

        // assert
        expect(result, isEmpty);
        verifyNever(mockFolderBox.values);
      });
    });

    group('files and folders do not exist', () {
      setUp(() {
        mockFolderBox = MockHiveBox();
        mockBookBox = MockHiveBox();
        localDataSourceImpl = LocalDataSourceImpl(mockFolderBox, mockBookBox);
      });

      /*test('should throw exception when adding a file that doesn\'t exist',
          () async {
        // assert
        expect(() => localDataSourceImpl.addBooks(['/inexistant/file/path']), throwsA(isA<FileException>()));
      });

      test('should throw exception when adding a folder that doesn\'t exist',
          () async {
            // assert
            expect(() => localDataSourceImpl.addFolders(['/inexistant/file/path']), throwsA(isA<FileException>()));
      });*/

      /*test(
          'should throw exception when adding files from a folder that doesn\'t exist',
          () async {
            // assert
            expect(() => localDataSourceImpl.addAllBooksFromDirectory('/inexistant/file/path'), throwsA(isA<FileException>()));
      });*/
    });
  });
}
