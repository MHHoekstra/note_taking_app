import 'package:injectable/injectable.dart';
import 'package:note_taking_app/domain/authentication/facades/auth_facade.dart';
import 'package:note_taking_app/domain/authentication/value_objects/email_address.dart';
import 'package:note_taking_app/domain/authentication/value_objects/password.dart';
import 'package:note_taking_app/domain/core/either.dart';

import '../../../domain/authentication/auth_failures.dart';

@lazySingleton
class SignInWithEmailAndPasswordUseCase {
  final AuthFacade _authFacade;

  const SignInWithEmailAndPasswordUseCase(this._authFacade);

  Future<Either<AuthenticationFailure, bool>> call({
    required EmailAddress emailAddress,
    required Password password,
  }) {
    if (emailAddress.isValid && password.isValid) {
      return _authFacade.signInWithEmailAndPassword(
        emailAddress: emailAddress,
        password: password,
      );
    } else {
      final Left<AuthenticationFailure, bool> failure = !emailAddress.isValid
          ? Left(InvalidEmail())
          : Left(InvalidPassword());
      return Future.value(failure);
    }
  }
}
