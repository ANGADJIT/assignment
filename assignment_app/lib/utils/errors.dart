class Failure implements Exception {
  final String errorMessage;

  Failure(this.errorMessage);
  @override
  String toString() {
    return errorMessage;
  }
}
