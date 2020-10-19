import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:mockito/mockito.dart';
import 'package:my_ebooks_simple_reader/core/enums.dart';
import 'package:my_ebooks_simple_reader/core/errors/exceptions.dart';
import 'package:my_ebooks_simple_reader/features/library/data/data_sources/local_data_source.dart';
import 'package:my_ebooks_simple_reader/features/library/data/models/book_model.dart';

class MockHiveBox extends Mock implements Box {}
class MockHiveLazyBox extends Mock implements LazyBox {}

void main() {
  MockHiveBox mockFolderBox;
  MockHiveBox mockBookBox;
  LocalDataSourceImpl localDataSourceImpl;

  group('Implementation of LocalDataSource', () {
    group('caches contain books and folders', () {
      setUp(() {
        mockFolderBox = MockHiveBox();
        mockBookBox = MockHiveBox();
        localDataSourceImpl = LocalDataSourceImpl(mockFolderBox, mockBookBox);
        when(mockFolderBox.isEmpty).thenReturn(false);
        when(mockFolderBox.isNotEmpty).thenReturn(true);
        when(mockBookBox.isEmpty).thenReturn(false);
        when(mockBookBox.isNotEmpty).thenReturn(true);
      });

      final tBook = BookModel(
          id: 1,
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

      test('should get all books from hive cache', () async {
        // arrange
        final mockAnswer = [tBook];
        when(mockBookBox.values).thenReturn(mockAnswer);

        // act
        final result = await localDataSourceImpl.getBooks();

        // assert
        expect(result, mockAnswer);
      });
    });

    group('caches are empty', () {
      setUp(() {
        mockFolderBox = MockHiveBox();
        mockBookBox = MockHiveBox();
        localDataSourceImpl = LocalDataSourceImpl(mockFolderBox, mockBookBox);
        when(mockFolderBox.isEmpty).thenReturn(true);
        when(mockFolderBox.isNotEmpty).thenReturn(false);
        when(mockBookBox.isEmpty).thenReturn(true);
        when(mockBookBox.isNotEmpty).thenReturn(false);
      });

      test('should throw an exception when getting books', () async {
        // assert
        expect(await localDataSourceImpl.getBooks(), throwsA(isA<CacheException>()));
      });
    });
  });
}
