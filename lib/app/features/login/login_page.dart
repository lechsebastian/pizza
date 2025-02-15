import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pizza/app/cubit/root_cubit.dart';

class LoginPage extends StatefulWidget {
  LoginPage({
    super.key,
  });

  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var errorMessage = '';
  var isCreatingAccount = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(isCreatingAccount ? 'Rejestracja' : 'Logowanie'),
              const SizedBox(height: 20),
              TextField(
                decoration: const InputDecoration(
                  hintText: 'E-mail',
                ),
                controller: widget.emailController,
              ),
              TextField(
                controller: widget.passwordController,
                decoration: const InputDecoration(
                  hintText: 'Hasło',
                ),
                obscureText: true,
              ),
              const SizedBox(height: 20),
              Text(errorMessage),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  if (isCreatingAccount) {
                    try {
                      context.read<RootCubit>().registraion(
                          email: widget.emailController.text,
                          password: widget.passwordController.text);
                    } catch (error) {
                      setState(() {
                        errorMessage = error.toString();
                      });
                    }
                  } else {
                    try {
                      context.read<RootCubit>().signIn(
                          email: widget.emailController.text,
                          password: widget.passwordController.text);
                    } catch (error) {
                      setState(() {
                        errorMessage = error.toString();
                      });
                    }
                  }
                },
                child: Text(isCreatingAccount ? 'Zarejestruj' : 'Zaloguj'),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(isCreatingAccount
                      ? 'Masz już konto? '
                      : 'Nie masz konta? '),
                  InkWell(
                    onTap: () {
                      setState(() {
                        isCreatingAccount = !isCreatingAccount;
                      });
                    },
                    child: Text(
                      isCreatingAccount ? 'Zaloguj się' : 'Zarejestruj się',
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
