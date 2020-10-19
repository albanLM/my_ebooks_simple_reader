import 'package:epub/epub.dart';
import 'package:hive/hive.dart';
import 'package:my_ebooks_simple_reader/core/enums.dart';
import 'package:my_ebooks_simple_reader/features/library/domain/entities/book.dart';
import 'package:meta/meta.dart';

@HiveType(typeId: 1)
class BookModel extends Book with HiveObject {
  @override
  @HiveField(0)
  final int id;
  @override
  @HiveField(1)
  final String author;
  @override
  @HiveField(2)
  final String title;
  @override
  @HiveField(3)
  final String description;
  @override
  @HiveField(4)
  final String saga;
  @override
  @HiveField(5)
  final List<String> genres;
  @override
  @HiveField(6)
  final String language;
  @override
  @HiveField(7)
  final DateTime addDate;
  @override
  @HiveField(8)
  final String filePath;
  @override
  @HiveField(9)
  final ReadState readState;
  @override
  @HiveField(10)
  final Image cover;

  BookModel(
      {@required this.id,
      @required this.author,
      @required this.title,
      @required this.description,
      @required this.saga,
      @required this.genres,
      @required this.language,
      @required this.addDate,
      @required this.filePath,
      @required this.readState,
      @required this.cover});
}
