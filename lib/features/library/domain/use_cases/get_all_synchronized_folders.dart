import 'package:dartz/dartz.dart';
import 'package:my_ebooks_simple_reader/core/errors/failures.dart';
import 'package:my_ebooks_simple_reader/core/usecases/usecase.dart';
import 'package:my_ebooks_simple_reader/features/library/domain/entities/synchronized_folder.dart';
import 'package:my_ebooks_simple_reader/features/library/domain/repositories/synchronized_folder_repository.dart';

class GetAllSynchronizedFolders implements Usecase<List<SynchronizedFolder>, NoParams> {
  final SynchronizedFolderRepository synchronizedFolderRepository;

  GetAllSynchronizedFolders(this.synchronizedFolderRepository);

  @override
  Future<Either<Failure, List<SynchronizedFolder>>> call(NoParams params) {
    return synchronizedFolderRepository.getFolders();
  }

}