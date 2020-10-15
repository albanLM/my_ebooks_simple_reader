import 'package:dartz/dartz.dart';
import 'package:my_ebooks_simple_reader/core/failures/failures.dart';
import 'package:my_ebooks_simple_reader/core/usecases/usecase.dart';
import 'package:my_ebooks_simple_reader/features/library/data/repositories/synchronized_folder_repository.dart';
import 'package:my_ebooks_simple_reader/features/library/domain/entities/synchronized_folder.dart';

class GetAllSynchronizedFolders implements Usecase<List<SynchronizedFolder>, NoParams> {
  final SynchronizedFolderRepository synchronizedFolderRepository;

  GetAllSynchronizedFolders(this.synchronizedFolderRepository);

  @override
  Future<Either<Failure, List<SynchronizedFolder>>> call(NoParams params) {
    return synchronizedFolderRepository.getFolders();
  }

}