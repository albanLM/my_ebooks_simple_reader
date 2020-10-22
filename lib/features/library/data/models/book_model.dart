import 'package:hive/hive.dart';
import 'package:meta/meta.dart';
import 'package:my_ebooks_simple_reader/features/library/domain/entities/book.dart';

class BookModel extends Book with HiveObject {
  BookModel(
      {@required id,
      @required author,
      @required title,
      @required description,
      @required saga,
      @required genres,
      @required language,
      @required addDate,
      @required filePath,
      @required readState,
      @required cover})
      : super(
            id: id,
            author: author,
            title: title,
            description: description,
            saga: saga,
            genres: genres,
            language: language,
            addDate: addDate,
            filePath: filePath,
            readState: readState,
            cover: cover);
}
