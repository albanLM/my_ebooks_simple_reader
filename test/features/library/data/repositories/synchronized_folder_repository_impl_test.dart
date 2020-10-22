import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:my_ebooks_simple_reader/core/errors/exceptions.dart';
import 'package:my_ebooks_simple_reader/core/errors/failures.dart';
import 'package:my_ebooks_simple_reader/features/library/data/data_sources/local_data_source.dart';
import 'package:my_ebooks_simple_reader/features/library/data/repositories/synchronized_folder_repository_impl.dart';
import 'package:my_ebooks_simple_reader/features/library/domain/entities/synchronized_folder.dart';

class MockLocalDataSource extends Mock implements LocalDataSource {}

void main() {
  MockLocalDataSource mockLocalDataSource;
  SynchronizedFolderRepositoryImpl synchronizedFolderRepositoryImpl;

  group('Implementation of SynchronizedFolderRepository', () {
    setUp(() {
      mockLocalDataSource = MockLocalDataSource();
      synchronizedFolderRepositoryImpl = SynchronizedFolderRepositoryImpl(mockLocalDataSource);
    });

    final folder = SynchronizedFolder(id: 0, path: '/some/path/to/folder');

    test('should get synchronized folders from local data source', () async {
      // arrange
      final mockAnswer = [folder];
      when(mockLocalDataSource.getFolders()).thenAnswer((_) async => mockAnswer);

      // act
      final result = await synchronizedFolderRepositoryImpl.getFolders();

      // assert
      expect(result, Right(mockAnswer));
    });

    test('should return a failure when getting folders from data source fails', () async {
      // arrange
      when(mockLocalDataSource.getFolders()).thenThrow(CacheException());

      // act
      final result = await synchronizedFolderRepositoryImpl.getFolders();

      // assert
      expect(result, Left(CacheFailure()));
    });

    test('should add a synchronized folder to local data source', () async {
      // act
      final folderPaths = [folder.path];
      await synchronizedFolderRepositoryImpl.addFolders(folderPaths);

      // assert
      verify(mockLocalDataSource.addFolders(folderPaths));
      verifyNoMoreInteractions(mockLocalDataSource);
    });

    test('should return a failure when adding a folder to data source fails', () async {
      // arrange
      final folderPaths = [folder.path];
      when(mockLocalDataSource.addFolders(folderPaths)).thenThrow(CacheException());

      // act
      final result = await synchronizedFolderRepositoryImpl.addFolders(folderPaths);

      // assert
      expect(result, Left(CacheFailure()));
    });

    test('should remove a synchronized folder from local data source', () async {
      // act
      final folderIds = [folder.id];
      await synchronizedFolderRepositoryImpl.removeFolders(folderIds);

      // assert
      verify(mockLocalDataSource.removeFolders(folderIds));
      verifyNoMoreInteractions(mockLocalDataSource);
    });

    test('should return a failure when removing a folder from data source fails', () async {
      // arrange
      final folderIds = [folder.id];
      when(mockLocalDataSource.removeFolders(folderIds)).thenThrow(CacheException());

      // act
      final result = await synchronizedFolderRepositoryImpl.removeFolders(folderIds);

      // assert
      expect(result, Left(CacheFailure()));
    });
  });
}