import 'package:dartz/dartz.dart';
import 'package:my_ebooks_simple_reader/core/errors/failures.dart';
import 'package:my_ebooks_simple_reader/core/usecases/usecase.dart';
import 'package:my_ebooks_simple_reader/features/library/domain/repositories/synchronized_folder_repository.dart';

class RemoveSynchronizedFoldersFromCache implements Usecase<void, List<int>> {
  final SynchronizedFolderRepository synchronizedFolderRepository;

  RemoveSynchronizedFoldersFromCache(this.synchronizedFolderRepository);

  @override
  Future<Either<Failure, void>> call(List<int> ids) {
    return synchronizedFolderRepository.removeFolders(ids);
  }
}