import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:my_ebooks_simple_reader/core/failures/failures.dart';
import 'package:my_ebooks_simple_reader/features/library/data/repositories/synchronized_folder_repository.dart';
import 'package:my_ebooks_simple_reader/features/library/domain/use_cases/add_synchronized_folder.dart';

class MockSynchronizedFolderRepository extends Mock
    implements SynchronizedFolderRepository {}

void main() {
  AddSynchronizedFolder addSynchronizedFolder;
  MockSynchronizedFolderRepository mockFolderRepository;

  group('Add synchronized folder', () {
    setUp(() {
      mockFolderRepository = MockSynchronizedFolderRepository();
      addSynchronizedFolder = AddSynchronizedFolder(mockFolderRepository);
    });

    final folderPath = 'some/path/to/a/folder/';

    test('should add folder to synchronized folder repository', () async {
      // act
      await addSynchronizedFolder(folderPath);

      // assert
      verify(mockFolderRepository.addFolder(folderPath));
    });

    test('should return a failure when repository fails to add folder',
        () async {
      // arrange
      when(mockFolderRepository.addFolder(folderPath))
          .thenAnswer((_) async => Left(CacheFailure()));

      // act
      final result = await addSynchronizedFolder(folderPath);

      // assert
      expect(result, Left(CacheFailure()));
    });
  });
}
