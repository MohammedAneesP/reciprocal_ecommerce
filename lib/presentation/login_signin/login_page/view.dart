import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:reciprocal_task/constants/colors.dart';
import 'package:reciprocal_task/constants/textstyle_const.dart';
import 'package:reciprocal_task/domain/services/firebase_auth.dart';
import 'package:reciprocal_task/presentation/login_signin/forgot_password/view.dart';
import 'package:reciprocal_task/presentation/login_signin/sign_up_page/view.dart';
import 'package:reciprocal_task/presentation/login_signin/widgets/button_widget.dart';
import 'package:reciprocal_task/presentation/login_signin/widgets/text_form.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final forFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final kHeight = MediaQuery.sizeOf(context);
    final kWidth = MediaQuery.sizeOf(context);

    return GestureDetector(
      onTap: () {
        FocusScopeNode currentScope = FocusScope.of(context);

        if (!currentScope.hasPrimaryFocus) {
          currentScope.unfocus();
        }
      },
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: forFormKey,
              child: Column(
                children: [
                  SizedBox(height: kHeight.height * 0.08),
                  const Text("Hello Again!", style: loginTitle),
                  const Text("Welcome back you've been missed!",
                      style: kBlueThinText),
                  SizedBox(height: kHeight.height * 0.12),
                  Container(
                    decoration: BoxDecoration(
                      color: kWhite,
                      borderRadius: BorderRadius.circular(
                        30,
                      ),
                    ),
                    child: TheTextFormField(
                      anController: emailController,
                      returnText: "Email required",
                      anLabelText: "Email address",
                      isObscure: false,
                      keyInputType: TextInputType.emailAddress,
                      anPrefixIcon: const Icon(
                        Icons.mail_outline_rounded,
                      ),
                      anSuffixIcon: const Icon(Icons.abc),
                    ),
                  ),
                  SizedBox(
                    height: kHeight.height * 0.03,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: kWhite,
                      borderRadius: BorderRadius.circular(
                        30,
                      ),
                    ),
                    child: TheTextFormField(
                      anController: passwordController,
                      returnText: "Password required",
                      anLabelText: "Password",
                      isObscure: true,
                      anPrefixIcon: const Icon(Icons.lock),
                      anSuffixIcon: const Icon(
                        CupertinoIcons.eye_slash_fill,
                      ),
                      keyInputType: TextInputType.text,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(220, 10, 0, 0),
                    child: TextButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => ForgotPassword(),
                        ));
                      },
                      child: const Text(
                        "Forgot Password ?",
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: kHeight.height * 0.03,
                  ),
                  SizedBox(
                    width: kWidth.width * 0.8,
                    height: kHeight.height * 0.065,
                    child: AnElevatedButton(
                      anString: "Login",
                      forFormKey: forFormKey,
                      emailController: emailController,
                      passwordController: passwordController,
                      anOnPressed: () async {
                        if (forFormKey.currentState!.validate()) {
                          await FirebaseAuthMethods(anFireAuth: FirebaseAuth.instance)
                              .loginWithEmailPassword(
                            anEmail: emailController.text,
                            anPassword: passwordController.text,
                            context: context,
                          );
                          emailController.clear();
                          passwordController.clear();
                        }
                      },
                    ),
                  ),
                  SizedBox(height: kHeight.height * 0.03),
                  SizedBox(height: kHeight.height * 0.15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Don't have an Account?"),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => SignUpPage(),
                            ),
                          );
                        },
                        child: const Text("Sign up"),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
