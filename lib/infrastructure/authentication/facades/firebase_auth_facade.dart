import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:injectable/injectable.dart';
import 'package:note_taking_app/domain/authentication/auth_failures.dart';
import 'package:note_taking_app/domain/authentication/facades/auth_facade.dart';
import 'package:note_taking_app/domain/authentication/value_objects/email_address.dart';
import 'package:note_taking_app/domain/authentication/value_objects/password.dart';
import 'package:note_taking_app/domain/core/either.dart';

@LazySingleton(as: AuthFacade)
class FirebaseAuthFacade implements AuthFacade {
  final FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;

  FirebaseAuthFacade(
    this._firebaseAuth,
    this._googleSignIn,
  );

  @override
  Future<Either<AuthenticationFailure, bool>> registerWithEmailAndPassword({
    required EmailAddress emailAddress,
    required Password password,
  }) async {
    final emailStr = emailAddress.getOrCrash();
    final passwordStr = password.getOrCrash();
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
        email: emailStr,
        password: passwordStr,
      );
      return Right(true);
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'email-already-in-use':
          return Left(EmailAlreadyInUse());
        case 'invalid-email':
          return Left(InvalidEmail());
        case 'operation-not-allowed':
          return Left(ServerFailure());
        case 'weak-password':
          return Left(InvalidPassword());
        default:
          return Left(UnknownFailure());
      }
    } on Exception catch (_) {
      return Left(UnknownFailure());
    }
  }

  @override
  Future<Either<AuthenticationFailure, bool>> signInWithEmailAndPassword({
    required EmailAddress emailAddress,
    required Password password,
  }) async {
    final emailStr = emailAddress.getOrCrash();
    final passwordStr = password.getOrCrash();
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: emailStr,
        password: passwordStr,
      );
      return Right(true);
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'invalid-email':
        case 'user-disabled':
        case 'user-not-found':
        case 'wrong-password':
          return Left(InvalidEmailAndPasswordCombination());
        default:
          return Left(UnknownFailure());
      }
    } on Exception catch (_) {
      return Left(UnknownFailure());
    }
  }

  @override
  Future<Either<AuthenticationFailure, bool>> signInWithGoogle() async {
    final googleUser = await _googleSignIn.signIn();
    if (googleUser == null) {
      return Left(CancelledByUser());
    }
    final googleAuthentication = await googleUser.authentication;

    final credential = GoogleAuthProvider.credential(
      idToken: googleAuthentication.idToken,
      accessToken: googleAuthentication.accessToken,
    );
    try {
      await _firebaseAuth.signInWithCredential(credential);
      return Right(true);
    } on FirebaseAuthException catch (_) {
      return Left(ServerFailure());
    }
  }
}
