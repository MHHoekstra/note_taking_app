import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_taking_app/injection.dart';
import 'package:note_taking_app/presentation/authentication/blocs/sign_in_form_bloc.dart';
import 'package:note_taking_app/presentation/authentication/widgets/sign_in_form_body.dart';

class SignInFormScreen extends StatelessWidget {
  const SignInFormScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sign In"),
      ),
      body: BlocProvider(
        create: (BuildContext context) => getIt<SignInFormBloc>(),
        child: const SignInFormBody(),
      ),
    );
  }
}
