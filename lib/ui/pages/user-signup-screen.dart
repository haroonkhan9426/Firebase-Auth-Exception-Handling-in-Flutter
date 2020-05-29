import 'package:base_flutter_project/enums/auth-result-status.dart';
import 'package:base_flutter_project/services/auth-exception-handler.dart';
import 'package:base_flutter_project/services/firebase-auth-helper.dart';
import 'package:base_flutter_project/ui/custom-widgets/custom-blue-rounded-button.dart';
import 'package:base_flutter_project/ui/custom-widgets/custom-rounded-textfield.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import '../../constants/text-styles.dart';

class UserSignUpScreen extends StatefulWidget {
  final bool needPop;

  UserSignUpScreen({this.needPop = false});

  @override
  _UserSignUpScreenState createState() => _UserSignUpScreenState();
}

class _UserSignUpScreenState extends State<UserSignUpScreen> {
  bool isInProgress = false;
  String email;
  String password;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ModalProgressHUD(
        inAsyncCall: isInProgress,
        child: Scaffold(
          body: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.only(left: 20, right: 20, top: 50),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
//        decoration: BoxDecoration(image: DecorationImage(image: )),
              color: Color(0xff00AFEF),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(bottom: 32),
                    child: Text(
                      'Sign Up',
                      style: WhiteHeadTS,
                    ),
                  ),
                  _signUpForm(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  _signUpForm() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 25, vertical: 30),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(5)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
//          CustomRoundedTextField(
//            hint: 'FirstName LastName',
//            label: 'User Name',
//            onChange: (val) {},
//          ),
          CustomRoundedTextField(
            hint: 'userName@email.com',
            label: 'Email',
            onChange: (val) {
              email = val;
            },
          ),
          CustomRoundedTextField(
            hint: '*********',
            label: 'Password',
            isPassword: true,
            onChange: (val) {
              password = val;
            },
          ),
//          CustomRoundedTextField(
//            hint: '*********',
//            label: 'Cofirm Password',
//            controller: passwordController,
//            isPassword: true,
//          ),
          SizedBox(height: 40),
          CustomBlueRoundedButton(
            child: Text(
              'SIGN UP',
              style: roundedBlueBtnTS,
            ),
            onPressed: _createAccount,
          )
        ],
      ),
    );
  }

  _createAccount() async {
    final status =
        await FirebaseAuthHelper().createAccount(email: email, pass: password);
    if (status == AuthResultStatus.successful) {
      // Navigate to success page
    } else {
      final errorMsg = AuthExceptionHandler.generateExceptionMessage(status);
      _showAlertDialog(errorMsg);
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
