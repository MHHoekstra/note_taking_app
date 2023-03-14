import 'package:note_taking_app/domain/authentication/value_objects/email_address.dart';
import 'package:note_taking_app/domain/authentication/value_objects/password.dart';
import 'package:note_taking_app/domain/core/either.dart';

import '../auth_failures.dart';

abstract
interface

class AuthFacade {
  Future<Either<AuthenticationFailure, bool>> registerWithEmailAndPassword({
    required EmailAddress emailAddress,
    required Password password,
  });

  Future<Either<AuthenticationFailure, bool>> signInWithEmailAndPassword({
    required EmailAddress emailAddress,
    required Password password,
  });

  Future<Either<AuthenticationFailure, bool>> signInWithGoogle();
}


