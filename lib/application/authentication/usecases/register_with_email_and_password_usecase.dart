import 'package:injectable/injectable.dart';

import '../../../domain/authentication/auth_failures.dart';
import '../../../domain/authentication/facades/auth_facade.dart';
import '../../../domain/authentication/value_objects/email_address.dart';
import '../../../domain/authentication/value_objects/password.dart';
import '../../../domain/core/either.dart';

@lazySingleton
class RegisterWithEmailAndPasswordUseCase {
  final AuthFacade _authFacade;

  const RegisterWithEmailAndPasswordUseCase(this._authFacade);

  Future<Either<AuthenticationFailure, bool>> call({
    required EmailAddress emailAddress,
    required Password password,
  }) {
    if (emailAddress.isValid && password.isValid) {
      return _authFacade.registerWithEmailAndPassword(
        emailAddress: emailAddress,
        password: password,
      );
    } else {
      final Either<AuthenticationFailure, bool> failure = !emailAddress.isValid
          ? Left(InvalidEmail())
          : Left(InvalidPassword());
      return Future.value(failure);
    }
  }
}
