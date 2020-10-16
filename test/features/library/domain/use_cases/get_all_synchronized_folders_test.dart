import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:my_ebooks_simple_reader/core/usecases/usecase.dart';
import 'package:my_ebooks_simple_reader/features/library/domain/repositories/synchronized_folder_repository.dart';
import 'package:my_ebooks_simple_reader/features/library/domain/entities/synchronized_folder.dart';
import 'package:my_ebooks_simple_reader/features/library/domain/use_cases/get_all_synchronized_folders.dart';

class MockSynchronizedFolderRepository extends Mock
    implements SynchronizedFolderRepository {}

void main() {
  GetAllSynchronizedFolders getAllSynchronizedFolders;
  MockSynchronizedFolderRepository mockFolderRepository;

  group('Get all synchronized folders', () {
    setUp(() {
      mockFolderRepository = MockSynchronizedFolderRepository();
      getAllSynchronizedFolders =
          GetAllSynchronizedFolders(mockFolderRepository);
    });

    final mockAnswer = [
      SynchronizedFolder(id: 0, path: '/some/path'),
      SynchronizedFolder(id: 1, path: '/some/other/path')
    ];

    test('should get all synchronized folders from the folder repository',
        () async {
      // arrange
      when(mockFolderRepository.getFolders())
          .thenAnswer((realInvocation) async => Right(mockAnswer));

      // act
      final result = await getAllSynchronizedFolders(NoParams());

      // assert
      expect(result, Right(mockAnswer));
      verify(mockFolderRepository.getFolders());
      verifyNoMoreInteractions(mockFolderRepository);
    });
  });
}
