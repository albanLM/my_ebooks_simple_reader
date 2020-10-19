import 'package:my_ebooks_simple_reader/core/enums.dart';

import 'book.dart';

class BookFilter {
  final String author;
  final String title;
  final String saga;
  final List<String> genres;
  final List<String> language;
  final List<ReadState> readState;

  BookFilter({this.author, this.title, this.saga, this.genres, this.language, this.readState});
}