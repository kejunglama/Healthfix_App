import 'package:healthfix/screens/home/home_screen.dart';
import 'package:healthfix/screens/sign_in/sign_in_screen.dart';
import 'package:healthfix/services/authentification/authentification_service.dart';
import 'package:flutter/material.dart';
import 'package:new_version/new_version.dart';

class AuthenticationWrapper extends StatefulWidget {
  static const String routeName = "/authentication_wrapper";

  @override
  State<AuthenticationWrapper> createState() => _AuthenticationWrapperState();
}

class _AuthenticationWrapperState extends State<AuthenticationWrapper> {
  @override
  void initState() {
    super.initState();

    _checkVersion();
  }

  void _checkVersion() async {
    final newVersion = NewVersion(
      androidId: "com.siteux.healthfix",
    );
    final status = await newVersion.getVersionStatus();
    newVersion.showUpdateDialog(
      context: context,
      versionStatus: status,
      dialogTitle: "New Update Available!",
      dismissButtonText: "LATER",
      dialogText: "A New Version of Helathfix App is Available on Play/App Store. \n"
          "\nAvailable Version: ${status.storeVersion}"
          "\nVersion Installed: ${status.localVersion} ",
      updateButtonText: "UPDATE NOW",
    );

    print("DEVICE : " + status.localVersion);
    print("STORE : " + status.storeVersion);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: AuthentificationService().authStateChanges,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return HomeScreen();
        } else {
          return SignInScreen();
        }
      },
    );
  }
}
