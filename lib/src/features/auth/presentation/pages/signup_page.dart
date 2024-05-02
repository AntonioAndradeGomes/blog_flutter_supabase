import 'package:blog_app/src/core/theme/app_pallete.dart';
import 'package:blog_app/src/core/utils/show_snackbar.dart';
import 'package:blog_app/src/core/widgets/loader.dart';
import 'package:blog_app/src/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:blog_app/src/features/auth/presentation/widgets/auth_form_field.dart';
import 'package:blog_app/src/features/auth/presentation/widgets/auth_gradient_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppPallete.transparentColor,
        ),
        body: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(15),
            child: BlocConsumer<AuthBloc, AuthState>(
              listener: (_, state) {
                if (state is AuthFailure) {
                  showSnackBar(
                    context: context,
                    content: state.message,
                    backgroundColor: Colors.red,
                  );
                }
              },
              builder: (_, state) {
                return Form(
                  canPop: state is! AuthLoading,
                  key: _formKey,
                  child: state is AuthLoading
                      ? const Loader()
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Cadastrar',
                              style: TextStyle(
                                fontSize: 50,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            AuthFormField(
                              hintText: 'Nome',
                              controller: _nameController,
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            AuthFormField(
                              hintText: 'Email',
                              controller: _emailController,
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            AuthFormField(
                              hintText: 'Senha',
                              controller: _passwordController,
                              isObscureText: true,
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            AuthGradientButton(
                              buttonText: 'Cadastrar',
                              onTap: () {
                                if (_formKey.currentState!.validate()) {
                                  FocusScope.of(context).unfocus();
                                  context.read<AuthBloc>().add(
                                        AuthSignUp(
                                          email: _emailController.text.trim(),
                                          password: _passwordController.text,
                                          name: _nameController.text.trim(),
                                        ),
                                      );
                                }
                              },
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: RichText(
                                text: TextSpan(
                                  text: 'Já tem uma conta? ',
                                  style:
                                      Theme.of(context).textTheme.titleMedium,
                                  children: [
                                    TextSpan(
                                      text: 'Entre',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium
                                          ?.copyWith(
                                            color: AppPallete.gradient2,
                                            fontWeight: FontWeight.bold,
                                          ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
