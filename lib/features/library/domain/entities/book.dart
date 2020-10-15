import 'package:epub/epub.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

enum ReadState { notRead, inProgress, read }

class Book extends Equatable {
  final int id;
  final String author;
  final String title;
  final String description;
  final String saga;
  final List<String> genres;
  final String language;
  final DateTime addDate;
  final String filePath;
  final ReadState readState;
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

  @override
  List<Object> get props => [id, filePath];
}
