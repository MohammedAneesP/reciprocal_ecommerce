
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:reciprocal_task/constants/textstyle_const.dart';
import 'package:reciprocal_task/presentation/login_signin/login_page/view.dart';

class NotLoggedInButton extends StatelessWidget {
  const NotLoggedInButton({
    super.key,
    required this.kheight,
  });

  final Size kheight;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        showModalBottomSheet(
          context: context,
          builder: (BuildContext context) {
            return Container(
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(15))),
              height: kheight.height * 0.25,
              width: kheight.width,
              child: Column(
                children: [
                  SizedBox(height: kheight.height * 0.05),
                  const Text('Seems like you are not logged in',
                      style: kHeadingText),
                  SizedBox(height: kheight.height * 0.02),
                  OutlinedButton(
                    style: ButtonStyle(
                      backgroundColor:
                          WidgetStatePropertyAll(Colors.lightBlue[100]),
                      minimumSize: WidgetStatePropertyAll(
                        Size(
                          kheight.width * 0.5,
                          kheight.height * 0.075,
                        ),
                      ),
                    ),
                    child: const Text('Go to Sign in'),
                    onPressed: () {
                      Navigator.push(
                        context,
                        CupertinoPageRoute(
                          builder: (context) => LoginPage(),
                        ),
                      );
                    },
                  ),
                  const Spacer()
                ],
              ),
            );
          },
        );
      },
      style: ButtonStyle(
        backgroundColor: const WidgetStatePropertyAll(Colors.amberAccent),
        minimumSize: WidgetStatePropertyAll(
          Size(
            kheight.width * 0.5,
            kheight.height * 0.075,
          ),
        ),
      ),
      child: const Text("Add to cart"),
    );
  }
}
