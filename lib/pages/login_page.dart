import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:jwtlogresflutter/env/config.dart';
import 'package:jwtlogresflutter/models/login_request_model.dart';
import 'package:jwtlogresflutter/services/api_service.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import 'package:snippet_coder_utils/ProgressHUD.dart';
import 'package:snippet_coder_utils/hex_color.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isAPIcallProcess = false;
  bool hidePassword = true;
  GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();
  String? username;
  String? password;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: HexColor("#283B71"),
        body: ProgressHUD(
          child: Form(
            key: globalFormKey,
            child: _loginUI(context),
          ),
          inAsyncCall: isAPIcallProcess,
          opacity: 0.3,
          key: UniqueKey(),
        ),
      ),
    );
  }

  Widget _loginUI(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 4,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                colors: [
                  Colors.white,
                  Colors.white,
                ],
              ),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(100),
                bottomRight: Radius.circular(100),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Align(
                  alignment: Alignment.center,
                  child: Icon(
                    Icons.shopping_cart,
                    size: 100,
                  ),
                ),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 20, bottom: 30, top: 50),
            child: Text(
              "Giri??",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
                color: Colors.white,
              ),
            ),
          ),
          FormHelper.inputFieldWidget(
            context,
            const Icon(Icons.person),
            "username",
            "User Name",
            (val) {
              if (val.isEmpty) {
                return "Kullan??c?? ad?? bo?? olamaz!";
              }
              return null;
            },
            (val) {
              username = val;
            },
            borderFocusColor: Colors.white,
            prefixIconColor: Colors.white,
            borderColor: Colors.white,
            textColor: Colors.white,
            hintColor: Colors.white.withOpacity(0.7),
            borderRadius: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: FormHelper.inputFieldWidget(
              context,
              const Icon(Icons.password),
              "password",
              "Password",
              (val) {
                if (val.isEmpty) {
                  return "??ifre bo?? olamaz!";
                }
                return null;
              },
              (val) {
                password = val;
              },
              borderFocusColor: Colors.white,
              prefixIconColor: Colors.white,
              borderColor: Colors.white,
              textColor: Colors.white,
              hintColor: Colors.white.withOpacity(0.7),
              borderRadius: 10,
              obscureText: hidePassword,
              suffixIcon: IconButton(
                onPressed: () {
                  setState(() {
                    hidePassword = !hidePassword;
                  });
                },
                color: Colors.white.withOpacity(0.7),
                icon: Icon(
                  hidePassword ? Icons.visibility_off : Icons.visibility,
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.only(right: 25, top: 10),
              child: RichText(
                text: TextSpan(
                  style: const TextStyle(color: Colors.grey, fontSize: 14.0),
                  children: <TextSpan>[
                    TextSpan(
                      text: "??ifreni mi unuttun?",
                      style: const TextStyle(
                        color: Colors.white,
                        decoration: TextDecoration.underline,
                      ),
                      recognizer: TapGestureRecognizer()..onTap = () {},
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Center(
            child: FormHelper.submitButton(
              "Giri??",
              () {
                if (validateAndSave()) {
                  setState(() {
                    isAPIcallProcess = true;
                  });

                  LoginRequestModel model = LoginRequestModel(username: username, password: password);
                  APIService.login(model).then((value) {
                    setState(() {
                      isAPIcallProcess = false;
                    });

                    if (value) {
                      Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
                    } else {
                      FormHelper.showSimpleAlertDialog(context, EnvConfig.appName, 'Usta bilgilerin hatal??!', 'Yeniden Dene', () {
                        Navigator.pop(context);
                      });
                    }
                  });
                }
              },
              btnColor: HexColor("#283B71"),
              borderColor: Colors.white,
              txtColor: Colors.white,
              borderRadius: 10,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          const Center(
            child: Text(
              "OR",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.only(right: 25, top: 10),
              child: RichText(
                text: TextSpan(
                  style: const TextStyle(color: Colors.grey, fontSize: 14.0),
                  children: <TextSpan>[
                    const TextSpan(text: "Hesab??n yok mu? "),
                    TextSpan(
                      text: "Kay??t ol?",
                      style: const TextStyle(
                        color: Colors.white,
                        decoration: TextDecoration.underline,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.pushNamed(context, "/register");
                        },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  bool validateAndSave() {
    final form = globalFormKey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    } else {
      return false;
    }
  }
}
