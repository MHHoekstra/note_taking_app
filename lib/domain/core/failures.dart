sealed

class ValueFailure<T> {
  final T failedValue;

  const ValueFailure({required this.failedValue});
}

class InvalidEmailFailure extends ValueFailure<String> {
  const InvalidEmailFailure({required super.failedValue});
}

class ShortPasswordFailure extends ValueFailure<String> {
  const ShortPasswordFailure({required super.failedValue});
}