import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:my_ebooks_simple_reader/features/library/domain/repositories/synchronized_folder_repository.dart';
import 'package:my_ebooks_simple_reader/features/library/domain/entities/synchronized_folder.dart';
import 'package:my_ebooks_simple_reader/features/library/domain/use_cases/remove_synchronized_folders_from_cache.dart';

class MockSynchronizedFolderRepository extends Mock
    implements SynchronizedFolderRepository {}

void main() {
  RemoveSynchronizedFoldersFromCache removeSynchronizedFoldersFromCache;
  MockSynchronizedFolderRepository mockFolderRepository;

  group('Remove a synchronized folder from the cache', () {
    setUp(() {
      mockFolderRepository = MockSynchronizedFolderRepository();
      removeSynchronizedFoldersFromCache =
          RemoveSynchronizedFoldersFromCache(mockFolderRepository);
    });

    final synchronizedFolder = SynchronizedFolder(id: 0, path: '/some/path');

    test('should get all synchronized folders from the folder repository',
        () async {
      // act
      final folderIdList = [synchronizedFolder.id];
      await removeSynchronizedFoldersFromCache(folderIdList);

      // assert
      verify(mockFolderRepository.removeFolders(folderIdList));
      verifyNoMoreInteractions(mockFolderRepository);
    });
  });
}
