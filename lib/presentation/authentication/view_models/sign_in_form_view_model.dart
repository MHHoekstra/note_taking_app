import 'package:flutter/foundation.dart';
import 'package:note_taking_app/domain/authentication/value_objects/email_address.dart';
import 'package:note_taking_app/domain/authentication/value_objects/password.dart';
import 'package:note_taking_app/domain/core/either.dart';

import '../../../domain/authentication/auth_failures.dart';

@immutable
class SignInFormViewModel {
  final EmailAddress emailAddress;
  final Password password;
  final bool showErrorMessages;
  final bool isSubmitting;
  final Either<AuthenticationFailure, bool>? authFailureOrSuccess;

  const SignInFormViewModel({
    required this.emailAddress,
    required this.password,
    required this.showErrorMessages,
    required this.isSubmitting,
    this.authFailureOrSuccess,
  });

  factory SignInFormViewModel.initial() {
    return SignInFormViewModel(
      emailAddress: EmailAddress(""),
      password: Password(""),
      showErrorMessages: false,
      isSubmitting: false,
    );
  }

  SignInFormViewModel copyWith({
    EmailAddress? emailAddress,
    Password? password,
    bool? showErrorMessages,
    bool? isSubmitting,
    Either<AuthenticationFailure, bool>? authFailureOrSuccess,
  }) {
    return SignInFormViewModel(
      emailAddress: emailAddress ?? this.emailAddress,
      password: password ?? this.password,
      showErrorMessages: showErrorMessages ?? this.showErrorMessages,
      isSubmitting: isSubmitting ?? this.isSubmitting,
    );
  }
}
