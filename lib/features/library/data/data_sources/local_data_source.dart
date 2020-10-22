import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:epub/epub.dart';
import 'package:hive/hive.dart';
import 'package:my_ebooks_simple_reader/core/enums.dart';
import 'package:my_ebooks_simple_reader/core/errors/exceptions.dart';
import 'package:my_ebooks_simple_reader/features/library/data/models/book_model.dart';
import 'package:my_ebooks_simple_reader/features/library/domain/entities/book.dart';
import 'package:my_ebooks_simple_reader/features/library/domain/entities/book_filter.dart';
import 'package:my_ebooks_simple_reader/features/library/domain/entities/synchronized_folder.dart';
import 'package:path/path.dart';

abstract class LocalDataSource {
  // Book source
  Future<void> addBooks(List<String> filePaths);
  Future<void> addAllBooksFromDirectory(String directoryPath);
  Future<List<Book>> getBooks();
  Future<List<Book>> getFilteredBooks(BookFilter filter);
  Future<void> removeBooks(List<String> bookIds);
  Future<void> removeAllBooks();

  // Synchronized folder source
  Future<void> addFolders(List<String> folderPaths);
  Future<void> removeFolders(List<int> folderIds);
  Future<List<SynchronizedFolder>> getFolders();
}

class LocalDataSourceImpl implements LocalDataSource {
  final Box folderBox;
  final Box bookBox;

  LocalDataSourceImpl(this.folderBox, this.bookBox);

  @override
  Future<void> addAllBooksFromDirectory(String directoryPath) async {
    final dir = Directory(directoryPath);
    if (!dir.existsSync()) {
      throw FileException(message: 'the directory does not exist');
    }

    // Get the list of files contained in the directory
    // Only keep the files with the pub extension
    final files = dir
        .listSync(recursive: true)
        .where((file) => extension(file.path) == '.epub');
    final paths = files.map((file) => file.absolute.path).toList();
    await addBooks(paths);
  }

  @override
  Future<void> addBooks(List<String> filePaths) async {
    // Load the book
    final bookModels = await loadBooksFromFiles(filePaths);
    // Add the book to cache
    for (BookModel book in bookModels) {
      await bookBox.put(book.id, book);
    }
  }

  Future<List<BookModel>> loadBooksFromFiles(List<String> filePaths) async {
    var bookList = List<BookModel>();

    for (String path in filePaths) {
      //Get the epub into memory somehow
      var targetFile = new File(path);
      List<int> bytes = await targetFile.readAsBytes();

      // Opens a book and reads all of its content into memory
      EpubBook epubBook;
      try {
        epubBook = await EpubReader.readBook(bytes);
      } catch (_) {
        // If read fails, just skip the book
        continue;
      }

      // Verify that the book has ISBN, skip book otherwise
      if (epubBook.Schema.Package.Metadata.Identifiers
          .where((id) => id.Scheme == 'ISBN')
          .isEmpty) {
        continue;
      }

      // TODO : Complete the types to load
      final bookModel = new BookModel(
          id: epubBook.Schema.Package.Metadata.Identifiers.first.Identifier,
          author: epubBook.Author,
          title: epubBook.Title,
          description: epubBook.Schema.Package.Metadata.Description,
          saga: null,
          genres: null,
          language: epubBook.Schema.Package.Metadata.Languages.first,
          addDate: DateTime.now(),
          filePath: path,
          readState: ReadState.notRead,
          cover: epubBook.CoverImage);

      bookList.add(bookModel);
    }

    return bookList;
  }

  @override
  Future<void> addFolders(List<String> folderPaths) async {
    bool exist = true;
    for (String path in folderPaths) {
      final myDir = new Directory(path);
      exist &= myDir.existsSync();
    }

    if (!exist) {
      throw FileException(message: 'the directory does not exist');
    }

    folderBox.put(
        folderPaths.hashCode,
        new SynchronizedFolder(
            id: folderPaths.hashCode, path: folderPaths.first));
  }

  @override
  Future<List<BookModel>> getBooks() async {
    if (bookBox.isEmpty) {
      return List();
    }
    return bookBox.values.toList().cast<BookModel>();
  }

  @override
  Future<List<BookModel>> getFilteredBooks(BookFilter filter) async {
    if (bookBox.isEmpty) {
      return List();
    }
    var books = bookBox.values;
    if (filter.author != null) {
      books =
          books.where((book) => cast<BookModel>(book).author == filter.author);
    }
    if (filter.title != null) {
      books =
          books.where((book) => cast<BookModel>(book).title == filter.title);
    }
    if (filter.saga != null) {
      books = books.where((book) => cast<BookModel>(book).saga == filter.saga);
    }
    if (filter.genres != null) {
      books = books.where((book) => filter.genres.every((filterGenre) =>
          cast<BookModel>(book)
              .genres
              .any((bookGenre) => bookGenre == filterGenre)));
    }
    if (filter.language != null) {
      books = books.where((book) => filter.genres.every((filterLanguage) =>
          cast<BookModel>(book)
              .genres
              .any((bookLanguage) => bookLanguage == filterLanguage)));
    }
    if (filter.readState != null) {
      books = books.where((book) => filter.genres.every((filterReadState) =>
          cast<BookModel>(book)
              .genres
              .any((bookReadState) => bookReadState == filterReadState)));
    }
    return books.toList().cast<BookModel>();
  }

  @override
  Future<List<SynchronizedFolder>> getFolders() async {
    if (folderBox.isEmpty) {
      return List();
    }
    return folderBox.values.toList().cast<SynchronizedFolder>();
  }

  @override
  Future<void> removeAllBooks() async {
    bookBox.deleteAll(bookBox.keys);
  }

  @override
  Future<void> removeBooks(List<String> bookIds) async {
    bookBox.deleteAll(bookIds);
  }

  @override
  Future<void> removeFolders(List<int> folderIds) async {
    folderBox.deleteAll(folderIds);
  }
}
