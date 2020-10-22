import 'package:epub/epub.dart';
import 'package:hive/hive.dart';
import 'package:meta/meta.dart';
import 'package:my_ebooks_simple_reader/core/enums.dart';

@HiveType(typeId: 1)
class Book {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String author;
  @HiveField(2)
  final String title;
  @HiveField(3)
  final String description;
  @HiveField(4)
  final String saga;
  @HiveField(5)
  final List<String> genres;
  @HiveField(6)
  final String language;
  @HiveField(7)
  final DateTime addDate;
  @HiveField(8)
  final String filePath;
  @HiveField(9)
  final ReadState readState;
  @HiveField(10)
  final Image cover;

  Book(
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
