import 'package:community_blog/login/bloc/login_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:go_router/go_router.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state.status.isFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(
                content: Text('Authentication Failure'),
              ),
            );
        }
      },
      child: Align(
        alignment: const Alignment(0, -1),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                'assets/logo.png',
                height: 120,
              ),
              const SizedBox(
                height: 32,
              ),
              const _WelcomeText(),
              _EmailInput(),
              _PasswordInput(),
              const SizedBox(
                height: 30,
              ),
              _LoginButton(),
            ],
          ),
        ),
      ),
    );
  }
}

class _WelcomeText extends StatelessWidget {
  const _WelcomeText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Welcome back',
          style: TextStyle(
              fontStyle: FontStyle.normal,
              fontSize: 24,
              fontWeight: FontWeight.w800,
              color: Color(0xff0D253C)),
        ),
        Text(
          'Sign in with your account',
          style: TextStyle(
              fontStyle: FontStyle.normal,
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: Color(0xff2D4379)),
        )
      ],
    );
  }
}

class _EmailInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
        buildWhen: (previous, current) => previous.email != current.email,
        builder: (current, state) {
          return TextField(
            onChanged: (email) =>
                context.read<LoginBloc>().add(LoginEmailChanged(email)),
            keyboardType: TextInputType.emailAddress,
            cursorColor: const Color(0xff376AED),
            decoration: const InputDecoration(
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Color(0xff376AED)),
              ),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Color(0xffD9DFEB),
                ),
              ),
              labelText: 'Email',
              helperText: '',
              labelStyle: TextStyle(
                  color: Color(0xff2D4379),
                  fontSize: 14,
                  fontWeight: FontWeight.w400),
            ),
          );
        });
  }
}

class _PasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
        buildWhen: (previous, current) => previous.password != current.password,
        builder: (current, state) {
          return TextField(
            onChanged: (password) =>
                context.read<LoginBloc>().add(LoginPasswordChanged(password)),
            obscureText: true,
            cursorColor: const Color(0xff376AED),
            style: const TextStyle(color: Color(0xff2D4379)),
            decoration: const InputDecoration(
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Color(0xff376AED)),
              ),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Color(0xffD9DFEB),
                ),
              ),
              labelText: 'Password',
              helperText: '',
              labelStyle: TextStyle(
                  color: Color(0xff2D4379),
                  fontSize: 14,
                  fontWeight: FontWeight.w400),
            ),
          );
        });
  }
}

class _LoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
      return state.status.isInProgress
          ? const CircularProgressIndicator()
          : ElevatedButton(
              key: const Key('loginForm_continue_raisedButton'),
              onPressed: state.isValid
                  ? () {
                      context.read<LoginBloc>().add(const LoginSubmitted());
                    }
                  : null,
              child: const Text('LOGIN'),
            );
    });
  }
}
