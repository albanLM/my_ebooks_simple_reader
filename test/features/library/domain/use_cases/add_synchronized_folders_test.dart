import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:my_ebooks_simple_reader/core/errors/failures.dart';
import 'package:my_ebooks_simple_reader/features/library/domain/repositories/synchronized_folder_repository.dart';
import 'package:my_ebooks_simple_reader/features/library/domain/use_cases/add_synchronized_folders.dart';

class MockSynchronizedFolderRepository extends Mock
    implements SynchronizedFolderRepository {}

void main() {
  AddSynchronizedFolders addSynchronizedFolders;
  MockSynchronizedFolderRepository mockFolderRepository;

  group('Add synchronized folder', () {
    setUp(() {
      mockFolderRepository = MockSynchronizedFolderRepository();
      addSynchronizedFolders = AddSynchronizedFolders(mockFolderRepository);
    });

    final folderPath = 'some/path/to/a/folder/';

    test('should add folder to synchronized folder repository', () async {
      // arrange
      final folderList = [folderPath];

      // act
      await addSynchronizedFolders(folderList);

      // assert
      verify(mockFolderRepository.addFolders(folderList));
    });

    test('should return a failure when repository fails to add folder',
        () async {
      // arrange
      final folderList = [folderPath];
      when(mockFolderRepository.addFolders(folderList))
          .thenAnswer((_) async => Left(CacheFailure()));

      // act
      final result = await addSynchronizedFolders(folderList);

      // assert
      expect(result, Left(CacheFailure()));
    });
  });
}
