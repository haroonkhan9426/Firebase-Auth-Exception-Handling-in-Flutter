import 'package:base_flutter_project/enums/auth-result-status.dart';
import 'package:base_flutter_project/services/auth-exception-handler.dart';
import 'package:base_flutter_project/services/firebase-auth-helper.dart';
import 'package:base_flutter_project/ui/custom-widgets/custom-blue-outlined-button.dart';
import 'package:base_flutter_project/ui/custom-widgets/custom-blue-rounded-button.dart';
import 'package:base_flutter_project/ui/custom-widgets/custom-rounded-textfield.dart';
import 'package:base_flutter_project/ui/pages/user-signup-screen.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import '../../constants/colors.dart';
import '../../constants/text-styles.dart';

class UserLoginScreen extends StatefulWidget {
  final bool needPop;

  UserLoginScreen({this.needPop});

  @override
  _UserLoginScreenState createState() => _UserLoginScreenState();
}

class _UserLoginScreenState extends State<UserLoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool isInProgress = false;

  String email;
  String password;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: ModalProgressHUD(
          inAsyncCall: isInProgress,
          child: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.only(left: 20, right: 20, top: 50),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              color: Color(0xff00AFEF),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(bottom: 32),
                    child: Text(
                      'Login',
                      style: WhiteHeadTS,
                    ),
                  ),
                  _loginForm(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  _loginForm() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 25, vertical: 30),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(5)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          CustomRoundedTextField(
            hint: 'user-name@email.com',
            label: 'Email',
            controller: emailController,
            iconData: Icons.email,
            onChange: (val) {
              email = val;
            },
          ),
          CustomRoundedTextField(
            hint: '*********',
            label: 'Password',
            isPassword: true,
            controller: passwordController,
            iconData: Icons.lock,
            onChange: (val) {
              password = val;
            },
          ),
          SizedBox(height: 40),
          CustomBlueRoundedButton(
            child: Text(
              'LOG IN',
              style: roundedBlueBtnTS,
            ),
            onPressed: _login,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 14, bottom: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Not yet Registered?",
//                      '${authProvider.loginInProgress}',
                  style: greyTS,
                ),
              ],
            ),
          ),
          CustomBlueOutlinedButton(
            child: Text(
              'SIGN UP',
              style: TextStyle(color: mainThemeColor),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => UserSignUpScreen(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  _login() async {
    {
      setState(() {
        isInProgress = true;
      });
      final status =
          await FirebaseAuthHelper().login(email: email, pass: password);
      setState(() {
        isInProgress = false;
      });
      if (status == AuthResultStatus.successful) {
        // Navigate to success screen

//        Navigator.pushAndRemoveUntil(
//            context,
//            MaterialPageRoute(builder: (context) => SuccessScreen()),
//            (r) => false);
      } else {
        final errorMsg = AuthExceptionHandler.generateExceptionMessage(status);
        _showAlertDialog(errorMsg);
      }
    }
  }

  _showAlertDialog(errorMsg) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(
              'Login Failed',
              style: TextStyle(color: Colors.black),
            ),
            content: Text(errorMsg),
          );
        });
  }
}
