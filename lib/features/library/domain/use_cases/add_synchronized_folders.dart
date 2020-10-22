import 'package:dartz/dartz.dart';
import 'package:my_ebooks_simple_reader/core/errors/failures.dart';
import 'package:my_ebooks_simple_reader/core/usecases/usecase.dart';
import 'package:my_ebooks_simple_reader/features/library/domain/repositories/synchronized_folder_repository.dart';

class AddSynchronizedFolders implements Usecase<void, List<String>> {
  final SynchronizedFolderRepository folderRepository;

  AddSynchronizedFolders(this.folderRepository);

  @override
  Future<Either<Failure, void>> call(List<String> folderPaths) {
    return folderRepository.addFolders(folderPaths);
  }
}