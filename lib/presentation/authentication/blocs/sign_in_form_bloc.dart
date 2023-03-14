import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:note_taking_app/domain/authentication/auth_failures.dart';
import 'package:note_taking_app/domain/authentication/value_objects/email_address.dart';
import 'package:note_taking_app/domain/core/either.dart';

import '../../../application/authentication/usecases/register_with_email_and_password_usecase.dart';
import '../../../application/authentication/usecases/sign_in_with_email_and_password_usecase.dart';
import '../../../application/authentication/usecases/sign_in_with_google_usecase.dart';
import '../../../domain/authentication/value_objects/password.dart';

@Injectable(as: SignInFormBloc)
class SignInFormBloc extends Bloc<SignInFormEvent, SignInFormState> {
  final RegisterWithEmailAndPasswordUseCase _registerWithEmailAndPasswordUseCase;
  final SignInWithEmailAndPasswordUseCase _signInWithEmailAndPasswordUseCase;
  final SignInWithGoogleUseCase _signInWithGoogleUseCase;

  SignInFormBloc(this._registerWithEmailAndPasswordUseCase, this._signInWithEmailAndPasswordUseCase, this._signInWithGoogleUseCase,) : super(SignInFormState.initial()) {
    on((SignInFormEvent event, emit) async {
      switch(event) {
        case SignInFormPasswordChanged(:var password):
          emit(state.copyWith(password: Password(password), authFailureOrSuccess: null,),);
        case SignInFormEmailChanged(:var email):
          emit(state.copyWith(emailAddress: EmailAddress(email), authFailureOrSuccess: null,),);
        case SignInFormRegisterWithEmailAndPasswordPressed():
          emit(state.copyWith(isSubmitting: true, authFailureOrSuccess: null));
          final failureOrSuccess = await _registerWithEmailAndPasswordUseCase(password: state.password, emailAddress: state.emailAddress,);
          emit(state.copyWith(isSubmitting: false, authFailureOrSuccess: failureOrSuccess, showErrorMessages: true,));
        case SignInFormSignInWithEmailAndPasswordPressed():
          emit(state.copyWith(isSubmitting: true, authFailureOrSuccess: null));
          final failureOrSuccess = await _signInWithEmailAndPasswordUseCase(emailAddress: state.emailAddress, password: state.password);
          emit(state.copyWith(isSubmitting: false, authFailureOrSuccess: failureOrSuccess, showErrorMessages: true,));
        case SignInFormSignInWithGooglePressed():
          emit(state.copyWith(isSubmitting: true, authFailureOrSuccess: null,));
          final failureOrSuccess = await _signInWithGoogleUseCase();
          emit(state.copyWith(isSubmitting: false, authFailureOrSuccess: failureOrSuccess,));
        case _:
          break;
      }
    });
  }
}

sealed class SignInFormEvent {
  const SignInFormEvent();
}

class SignInFormPasswordChanged extends SignInFormEvent {
  final String password;

  const SignInFormPasswordChanged(this.password);
}

class SignInFormEmailChanged extends SignInFormEvent {
  final String email;

  const SignInFormEmailChanged(this.email);
}

class SignInFormRegisterWithEmailAndPasswordPressed extends SignInFormEvent {}

class SignInFormSignInWithEmailAndPasswordPressed extends SignInFormEvent {}

class SignInFormSignInWithGooglePressed extends SignInFormEvent {}

class SignInFormState {
  final EmailAddress emailAddress;
  final Password password;
  final bool isSubmitting;
  final Either<AuthenticationFailure, bool>? authFailureOrSuccess;
  final bool showErrorMessages;

  const SignInFormState({
    required this.emailAddress,
    required this.password,
    required this.isSubmitting,
    required this.showErrorMessages,
    this.authFailureOrSuccess,
  });

  factory SignInFormState.initial() {
    return SignInFormState(
      password: Password(""),
      emailAddress: EmailAddress(""),
      isSubmitting: false,
      showErrorMessages: false,
      authFailureOrSuccess: null,
    );
  }

  SignInFormState copyWith({EmailAddress? emailAddress,
    Password? password,
    bool? isSubmitting,
    bool? showErrorMessages,
    Either<
        AuthenticationFailure,
        bool>? authFailureOrSuccess,
  }) {
    return SignInFormState(
      emailAddress: emailAddress ?? this.emailAddress,
      password: password ?? this.password,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      authFailureOrSuccess: authFailureOrSuccess ?? this.authFailureOrSuccess,
      showErrorMessages: showErrorMessages ?? this.showErrorMessages
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is SignInFormState && runtimeType == other.runtimeType &&
              emailAddress == other.emailAddress &&
              password == other.password &&
              isSubmitting == other.isSubmitting &&
              authFailureOrSuccess == other.authFailureOrSuccess;

  @override
  int get hashCode =>
      emailAddress.hashCode ^ password.hashCode ^ isSubmitting
          .hashCode ^ authFailureOrSuccess.hashCode;

}
