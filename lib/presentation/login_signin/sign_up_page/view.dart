import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:reciprocal_task/constants/colors.dart';
import 'package:reciprocal_task/constants/textstyle_const.dart';
import 'package:reciprocal_task/domain/services/firebase_auth.dart';
import 'package:reciprocal_task/presentation/login_signin/login_page/view.dart';
import 'package:reciprocal_task/presentation/login_signin/widgets/button_widget.dart';
import 'package:reciprocal_task/presentation/login_signin/widgets/text_form.dart';

class SignUpPage extends StatelessWidget {
  SignUpPage({super.key});

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final userNameController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final kHeight = MediaQuery.of(context).size.height;
    final kWidth = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentScope = FocusScope.of(context);

        if (!currentScope.hasPrimaryFocus) {
          currentScope.unfocus();
        }
      },
      child: Scaffold(
        backgroundColor: Colors.lightBlue[50],
        body: SingleChildScrollView(
          child: SafeArea(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      SizedBox(
                        height: kHeight * 0.07,
                      ),
                      const Text("Create Account", style: loginTitle),
                      const Text("Let's create Account together",
                          style: kBlueThinText),
                      SizedBox(height: kHeight * 0.12),
                      Container(
                        decoration: BoxDecoration(
                          color: kWhite,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: TheTextFormField(
                          anController: userNameController,
                          returnText: "name required",
                          anLabelText: "Your Name",
                          isObscure: false,
                          anPrefixIcon: const Icon(Icons.abc_rounded),
                          keyInputType: TextInputType.text,
                        ),
                      ),
                      SizedBox(
                        height: kHeight * 0.03,
                      ),
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
                          anPrefixIcon: const Icon(Icons.mail_outline_rounded),
                          keyInputType: TextInputType.emailAddress,
                        ),
                      ),
                      SizedBox(
                        height: kHeight * 0.03,
                      ),
                      Column(
                        children: [
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
                              isObscure: false,
                              anPrefixIcon:
                                  const Icon(Icons.lock_outline_rounded),
                              keyInputType: TextInputType.text,
                            ),
                          ),
                          SizedBox(
                            height: kHeight * 0.03,
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
                              anLabelText: "confirm password",
                              isObscure: false,
                              anPrefixIcon:
                                  const Icon(Icons.lock_outline_rounded),
                              keyInputType: TextInputType.text,
                            ),
                          ),
                          SizedBox(
                            height: kHeight * 0.03,
                          ),
                          SizedBox(
                            width: kWidth * .85,
                            height: kHeight * 0.065,
                            child: AnElevatedButton(
                              anString: "Create",
                              forFormKey: formKey,
                              emailController: emailController,
                              passwordController: passwordController,
                              anOnPressed: () async {
                                if (formKey.currentState!.validate()) {
                                  await FirebaseAuthMethods(
                                          anFireAuth: FirebaseAuth.instance)
                                      .signUpWithEmail(
                                          anEmail: emailController.text,
                                          anPassword: passwordController.text,
                                          context: context);
                                }
                              },
                            ),
                          ),
                          SizedBox(
                            height: kHeight * 0.15
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text("Already have an account?"),
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                      builder: (context) => LoginPage(),
                                    ),
                                  );
                                },
                                child: const Text(
                                  "Login",
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
