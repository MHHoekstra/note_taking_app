import 'package:note_taking_app/domain/core/either.dart';
import 'package:note_taking_app/domain/core/failures.dart';
import 'package:note_taking_app/domain/core/value_object.dart';

class Password extends ValueObject<String> {
  const Password._(super.value);

  factory Password(String input) {
    return Password._(validatePassword(input));
  }
}

Either<ValueFailure<String>, String> validatePassword(String input) {
  if (input.length > 8) {
    return Right(input);
  } else {
    return Left(ShortPasswordFailure(failedValue: input));
  }
}
