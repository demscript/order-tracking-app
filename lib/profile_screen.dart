import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:order_tracking/authentication/data/repository/authentication_service.dart';
import 'package:order_tracking/utils/app_extension.dart';
import 'package:order_tracking/utils/app_routes.dart';

import 'authentication/logic/profile_view_model.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        alignment: Alignment.center,
        child: Consumer(builder: (_, ref, child) {
          final profileData = ref.watch(profileVM).storeProfileVMModel;
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (profileData.userPhoto != null)
                CircleAvatar(
                  radius: context.deviceWidth() / 8,
                  backgroundColor: Colors.transparent,
                  backgroundImage: NetworkImage(profileData.userPhoto!),
                ),
              SizedBox(height: context.deviceHeight() / 15),
              Text(
                profileData.fullName ?? "---",
                style: context.textTheme.headlineLarge,
              ),
              const SizedBox(height: 5),
              Text(
                profileData.email ?? "---",
                style: context.textTheme.bodyLarge,
              ),
              SizedBox(height: context.deviceHeight() / 20),
              TextButton(
                style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    minimumSize: const Size(double.maxFinite * 0.25, 20),
                    backgroundColor: context.primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    )),
                onPressed: () {
                  ref.read(authenticationServiceProvider).signOutGoogle();
                  Navigator.pushReplacementNamed(context, AppRoutes.authScreen);
                },
                child: Text(
                  "Log Out",
                  style: context.textTheme.titleLarge?.copyWith(
                      fontSize: 15, color: context.themeData.cardColor),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
