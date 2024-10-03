import 'package:flutter/material.dart';
import 'package:reciprocal_task/constants/colors.dart';
import 'package:reciprocal_task/constants/textstyle_const.dart';
import 'package:reciprocal_task/presentation/login_signin/login_page/view.dart';
import 'package:reciprocal_task/presentation/login_signin/widgets/text_form.dart';
import 'package:reciprocal_task/widgets/utils.dart';

class ForgotPassword extends StatelessWidget {
  ForgotPassword({super.key});
  final TextEditingController forgotController = TextEditingController();
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
        // backgroundColor: Colors.lightBlue[50],
        body: SingleChildScrollView(
          child: SafeArea(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    SizedBox(
                      height: kHeight * 0.08,
                    ),
                    const Text(
                      "Recover Password",
                      style: loginTitle,
                    ),
                    const Text("Please Enter your Email address to",
                        style: kBlueThinText),
                    const Text(
                      "Recieve a verification Code",
                      style: kBlueThinText,
                    ),
                    SizedBox(
                      height: kHeight * 0.12,
                    ),
                    Form(
                      key: formKey,
                      child: Container(
                        decoration: BoxDecoration(
                          color: kWhite,
                          borderRadius: BorderRadius.circular(
                            30,
                          ),
                        ),
                        child: TheTextFormField(
                          anController: forgotController,
                          returnText: "email address required",
                          anLabelText: "Email Address",
                          isObscure: false,
                          anPrefixIcon: const Icon(Icons.mail_outline_rounded),
                          keyInputType: TextInputType.emailAddress,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: kHeight * 0.03,
                    ),
                    SizedBox(
                      width: kWidth * 1,
                      height: kHeight * 0.065,
                      child: ElevatedButton(
                        onPressed: () async {
                          if (formKey.currentState!.validate()) {
                            // await FireBaseAuthMethods(FirebaseAuth.instance)
                            //     .forgotPassword(
                            //   anEmail: forgotController.text,
                            //   context: context,
                            // );
                            if (context.mounted) {
                              anSnackBarFunc(
                                  context: context,
                                  aText: "reset email sent",
                                  anColor: kGrey);
                              Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                  builder: (context) => LoginPage(),
                                ),
                              );
                            }
                          }
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blueAccent),
                        child: const Text(
                          "Continue",
                          style: buttontextWhite,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
