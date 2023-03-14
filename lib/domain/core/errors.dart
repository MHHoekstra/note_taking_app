import 'package:note_taking_app/domain/core/failures.dart';

class UnexpectedValueError extends Error {
  final ValueFailure valueFailure;

  UnexpectedValueError(this.valueFailure);

  @override
  String toString() {
    return 'UnexpectedValueError{valueFailure: $valueFailure}';
  }
}
