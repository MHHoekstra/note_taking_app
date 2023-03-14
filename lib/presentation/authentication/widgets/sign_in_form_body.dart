import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_taking_app/presentation/authentication/blocs/sign_in_form_bloc.dart';

class SignInFormBody extends StatelessWidget {
  const SignInFormBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignInFormBloc, SignInFormState>(
      builder: (context, state) {
        return Form(
          autovalidateMode: state.showErrorMessages
              ? AutovalidateMode.onUserInteraction
              : AutovalidateMode.disabled,
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              const Text(
                '📝',
                style: TextStyle(fontSize: 80),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 24,
              ),
              TextFormField(
                validator: (_) => state.emailAddress.value.fold(
                  (l) => "Invalid e-mail",
                  (r) => null,
                ),
                onChanged: (email) {
                  BlocProvider.of<SignInFormBloc>(context).add(
                    SignInFormEmailChanged(email),
                  );
                },
                textCapitalization: TextCapitalization.none,
                autocorrect: false,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.email),
                  label: Text("E-mail"),
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              TextFormField(
                validator: (_) => state.password.value.fold(
                  (l) => "Short password",
                  (r) => null,
                ),
                onChanged: (password) {
                  BlocProvider.of<SignInFormBloc>(context).add(
                    SignInFormPasswordChanged(password),
                  );
                },
                obscureText: true,
                autocorrect: false,
                keyboardType: TextInputType.visiblePassword,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.password),
                  label: Text("Password"),
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              Row(
                children: [
                  Expanded(
                    child: TextButton(
                      onPressed: () {
                        BlocProvider.of<SignInFormBloc>(context).add(
                          SignInFormSignInWithEmailAndPasswordPressed(),
                        );
                      },
                      child: const Text("SIGN IN"),
                    ),
                  ),
                  Expanded(
                    child: TextButton(
                      onPressed: () {
                        BlocProvider.of<SignInFormBloc>(context).add(
                          SignInFormRegisterWithEmailAndPasswordPressed(),
                        );
                      },
                      child: const Text("REGISTER"),
                    ),
                  ),
                ],
              ),
              ElevatedButton(
                onPressed: () {
                  BlocProvider.of<SignInFormBloc>(context).add(
                    SignInFormSignInWithGooglePressed(),
                  );
                },
                child: const Text("SIGN IN WITH GOOGLE"),
              ),
            ],
          ),
        );
      },
      listener: (context, state) {},
    );
  }
}
