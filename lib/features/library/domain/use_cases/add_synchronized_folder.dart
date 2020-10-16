import 'package:dartz/dartz.dart';
import 'package:my_ebooks_simple_reader/core/errors/failures.dart';
import 'package:my_ebooks_simple_reader/core/usecases/usecase.dart';
import 'package:my_ebooks_simple_reader/features/library/domain/repositories/synchronized_folder_repository.dart';

class AddSynchronizedFolder implements Usecase<void, String> {
  final SynchronizedFolderRepository folderRepository;

  AddSynchronizedFolder(this.folderRepository);

  @override
  Future<Either<Failure, void>> call(String folderPath) {
    return folderRepository.addFolder(folderPath);
  }
}