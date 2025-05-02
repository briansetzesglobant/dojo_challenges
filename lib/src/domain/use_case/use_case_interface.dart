abstract interface class UseCaseInterface<T> {
  Future<T> call();
}
