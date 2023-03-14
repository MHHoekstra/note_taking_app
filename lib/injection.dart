import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:note_taking_app/application/authentication/usecases/register_with_email_and_password_usecase.dart';
import 'package:note_taking_app/application/authentication/usecases/sign_in_with_email_and_password_usecase.dart';
import 'package:note_taking_app/application/authentication/usecases/sign_in_with_google_usecase.dart';
import 'package:note_taking_app/domain/authentication/facades/auth_facade.dart';
import 'package:note_taking_app/infrastructure/authentication/facades/firebase_auth_facade.dart';
import 'package:note_taking_app/presentation/authentication/blocs/sign_in_form_bloc.dart';

final getIt = GetIt.instance;

void configureInjection() {
  ///Services
  getIt.registerLazySingleton(() => GoogleSignIn());
  getIt.registerLazySingleton(() => FirebaseAuth.instance);

  ///Facades
  getIt.registerLazySingleton<AuthFacade>(
      () => FirebaseAuthFacade(getIt(), getIt()));

  ///UseCases
  getIt.registerLazySingleton(() => SignInWithEmailAndPasswordUseCase(getIt()));
  getIt.registerLazySingleton(
      () => RegisterWithEmailAndPasswordUseCase(getIt()));
  getIt.registerLazySingleton(() => SignInWithGoogleUseCase(getIt()));

  ///ViewModels
  getIt.registerFactory(
    () => SignInFormBloc(
      getIt(),
      getIt(),
      getIt(),
    ),
  );
}
