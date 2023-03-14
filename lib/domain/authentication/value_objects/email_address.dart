import 'package:note_taking_app/domain/core/either.dart';
import 'package:note_taking_app/domain/core/failures.dart';
import 'package:note_taking_app/domain/core/value_object.dart';

class EmailAddress extends ValueObject<String> {
  const EmailAddress._(super.value);

  factory EmailAddress(String input) {
    return EmailAddress._(
      validateEmailAddress(
        input,
      ),
    );
  }
}

Either<ValueFailure<String>, String> validateEmailAddress(String input) {
  final emailRegex = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
  if (emailRegex.hasMatch(input)) {
    return Right(input);
  } else {
    return Left(InvalidEmailFailure(failedValue: input));
  }
}
