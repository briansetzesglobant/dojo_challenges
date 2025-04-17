abstract class DataState<T> {
  const DataState({this.data, this.error, required this.type});

  final T? data;
  final String? error;
  final DataStateType type;
}

class DataSuccess<T> extends DataState<T> {
  const DataSuccess(T data) : super(data: data, type: DataStateType.success);
}

class DataFailed<T> extends DataState<T> {
  const DataFailed(String error)
    : super(error: error, type: DataStateType.error);
}

class DataEmpty<T> extends DataState<T> {
  const DataEmpty() : super(type: DataStateType.empty);
}

enum DataStateType { success, empty, error }
