import 'package:demo_flutter_app/core/bloc/auth/bloc/auth_bloc.dart';
import 'package:demo_flutter_app/core/extensions/context_extensions.dart';
import 'package:demo_flutter_app/core/extensions/num_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../core/components/button/button.dart';
import '../core/components/text/custom_text.dart';
import '../core/components/textFormField/text_form_field.dart';
import '../core/constants/app/string_constants.dart';
import '../core/utils/validate_operations.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController passwordController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  bool? get validate => _formKey.currentState?.validate();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: context.dynamicWidth(0.05),
        ),
        child: Center(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const _LogoAndTitleWidget(),
                // _EmailFormField(emailController: emailController),
                _UserNameField(userNameController: userNameController),
                _PasswordFormField(passwordController: passwordController),
                _LoginButton(
                  onTap: () {
                    if (validate != null && validate == true) {
                      context.read<AuthBloc>().add(LoginRequested(
                            userNameController.text.trim(),
                            passwordController.text.trim(),
                          ));
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      )),
    );
  }
}

class _LogoAndTitleWidget extends StatelessWidget {
  const _LogoAndTitleWidget();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: context.dynamicHeight(0.06),
      ),
      child: Column(
        children: [
          Image.asset(
            'assets/images/demo.png',
            height: context.dynamicHeight(0.2),
          ),
          30.ph,
          CustomText(
            StringConstants.loginTitle,
            textStyle: context.textTheme.titleMedium,
          ),
        ],
      ),
    );
  }
}

class _UserNameField extends StatelessWidget {
  const _UserNameField({
    required this.userNameController,
  });

  final TextEditingController userNameController;

  @override
  Widget build(BuildContext context) {
    return TextFormFieldWidget(
      controller: userNameController,
      title: StringConstants.userNameTitle,
      hintText: StringConstants.userNameHint,
      keyboardType: TextInputType.text,
      onSaved: (value) {
        userNameController.text = value!;
      },
      validator: (value) => ValidateOperations.normalValidation(value),
    );
  }
}

class _PasswordFormField extends StatelessWidget {
  const _PasswordFormField({
    required this.passwordController,
  });

  final TextEditingController passwordController;

  @override
  Widget build(BuildContext context) {
    return TextFormFieldWidget(
      controller: passwordController,
      title: StringConstants.passwordTitle,
      hintText: StringConstants.passwordHint,
      isPassword: true,
      onSaved: (value) {
        passwordController.text = value!;
      },
      validator: (value) => ValidateOperations.normalValidation(value),
    );
  }
}

class _LoginButton extends StatelessWidget {
  const _LoginButton({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return CustomButton(
      buttonText: StringConstants.loginButtonText,
      onTap: onTap,
    );
  }
}
