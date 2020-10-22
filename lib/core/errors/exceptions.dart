class CacheException implements Exception {
  final String message;

  CacheException({this.message = ''});
}

class FileException implements Exception {
  final String message;

  FileException({this.message = ''});
}