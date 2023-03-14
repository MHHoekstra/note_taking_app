import 'package:injectable/injectable.dart';
import 'package:note_taking_app/domain/authentication/facades/auth_facade.dart';
import 'package:note_taking_app/domain/core/either.dart';

import '../../../domain/authentication/auth_failures.dart';

@lazySingleton
class SignInWithGoogleUseCase {
  final AuthFacade _authFacade;

  const SignInWithGoogleUseCase(this._authFacade);

  Future<Either<AuthenticationFailure, bool>> call() {
    return _authFacade.signInWithGoogle();
  }
}
