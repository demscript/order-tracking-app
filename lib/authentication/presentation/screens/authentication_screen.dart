import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:order_tracking/authentication/logic/authentication_states.dart';
import 'package:order_tracking/authentication/logic/signin_view_model.dart';
import 'package:order_tracking/authentication/presentation/utils/authentication_strings.dart';
import 'package:order_tracking/utils/app_extension.dart';
import 'package:order_tracking/utils/app_routes.dart';
import 'package:order_tracking/utils/error_snackbar.dart';
import 'package:order_tracking/utils/svg_render_widget.dart';
import '../../data/model/user_model.dart';
import '../../logic/profile_view_model.dart';

class AuthenticationScreen extends StatelessWidget {
  const AuthenticationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: context.deviceHeight() / 15),
              child: Text("WELCOME", style: context.textTheme.displayLarge),
            ),
            Center(
              child: Consumer(builder: (_, ref, child) {
                ref.listen(signInVM, (previous, next) {
                  if (next is GoogleAuthenticationSuccess) {
                    final user = UserModel(
                      userPhoto: next.user?.photoURL,
                      email: next.user?.email,
                      fullName: next.user?.displayName,
                    );
                    ref.read(profileVM).saveProfileInformation(user: user);
                    Navigator.pushReplacementNamed(
                        context, AppRoutes.navScreen);
                  }
                  if (next is AuthenticationError) {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(errorSnackBar(error: next.error));
                  }
                });
                return TextButton(
                  style: TextButton.styleFrom(
                    minimumSize: const Size(double.maxFinite * 0.25, 20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                      side: BorderSide(
                        color: context.themeData.shadowColor.withOpacity(0.3),
                      ),
                    ),
                  ),
                  onPressed: () {
                    ref.read(signInVM.notifier).googleSignIn();
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgRenderWidget(
                          svgPath: AuthenticationStrings.googleLogo, width: 30),
                      const SizedBox(width: 10),
                      Text(
                        "Sign in with Google",
                        style: context.textTheme.titleLarge?.copyWith(
                            fontSize: 15, color: context.primaryColor),
                      ),
                    ],
                  ),
                );
              }),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Text(
                "OR",
                style: context.textTheme.titleLarge?.copyWith(fontSize: 15),
              ),
            ),
            Center(
              child: Consumer(builder: (_, ref, child) {
                final vm = ref.watch(signInVM);
                ref.listen(signInVM, (previous, next) {
                  if (next is GithubAuthenticationSuccess) {
                    final user = UserModel(
                      userPhoto: next.user?.photoURL,
                      email: next.user?.email,
                      fullName: next.user?.displayName,
                    );
                    ref.read(profileVM).saveProfileInformation(user: user);
                    Navigator.pushReplacementNamed(
                        context, AppRoutes.navScreen);
                  }
                });

                return Column(
                  children: [
                    TextButton(
                      onPressed: () {
                        ref.read(signInVM.notifier).githubSignIn(context);
                      },
                      style: TextButton.styleFrom(
                          backgroundColor: context.primaryColor,
                          minimumSize: const Size(double.maxFinite * 0.25, 20),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          )),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgRenderWidget(
                              svgPath: AuthenticationStrings.githubLogo,
                              width: 30),
                          const SizedBox(width: 10),
                          Text(
                            "Sign in with Github",
                            style: context.textTheme.titleLarge?.copyWith(
                                fontSize: 15,
                                color: context.themeData.cardColor),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: context.deviceHeight() / 10),
                    if (vm is AuthenticationLoading)
                      const CircularProgressIndicator(),
                  ],
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
