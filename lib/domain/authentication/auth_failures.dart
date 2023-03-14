sealed

class AuthenticationFailure {
  const AuthenticationFailure();
}

class CancelledByUser extends AuthenticationFailure {}

class ServerFailure extends AuthenticationFailure {}

class UnknownFailure extends AuthenticationFailure {}

class EmailAlreadyInUse extends AuthenticationFailure {}

class InvalidEmail extends AuthenticationFailure {}

class InvalidPassword extends AuthenticationFailure {}

class InvalidEmailAndPasswordCombination extends AuthenticationFailure {}
