import 'either.dart';
import 'errors.dart';
import 'failures.dart';

abstract class ValueObject<T> {
  const ValueObject(this.value);

  final Either<ValueFailure<T>, T> value;

  T getOrCrash() {
    return value.fold((l) => throw UnexpectedValueError(l), (r) => r);
  }

  bool get isValid {
    return value.isRight();
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ValueObject &&
          runtimeType == other.runtimeType &&
          this.value == other.value;

  @override
  int get hashCode => value.hashCode;

  @override
  String toString() {
    return 'Value{$value}';
  }
}
