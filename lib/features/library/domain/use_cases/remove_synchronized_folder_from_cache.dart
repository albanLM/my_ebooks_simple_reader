import 'package:dartz/dartz.dart';
import 'package:my_ebooks_simple_reader/core/failures/failures.dart';
import 'package:my_ebooks_simple_reader/core/usecases/usecase.dart';
import 'package:my_ebooks_simple_reader/features/library/data/repositories/synchronized_folder_repository.dart';

class RemoveSynchronizedFolderFromCache implements Usecase<void, int> {
  final SynchronizedFolderRepository synchronizedFolderRepository;

  RemoveSynchronizedFolderFromCache(this.synchronizedFolderRepository);

  @override
  Future<Either<Failure, void>> call(int id) {
    return synchronizedFolderRepository.removeFolder(id);
  }
}