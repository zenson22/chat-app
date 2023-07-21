import 'package:chatchat/helper/helper_function.dart';
import 'package:chatchat/pages/homepage.dart';
import 'package:chatchat/pages/loginpage.dart';
import 'package:chatchat/services/auth_services.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../apis/http.dart';
import '../widgets/widgets.dart';

class Registerpage extends StatefulWidget {
  const Registerpage({super.key});

  @override
  State<Registerpage> createState() => _RegisterpageState();
}

class _RegisterpageState extends State<Registerpage> {
  bool _isLoding = false;
  final formKey = GlobalKey<FormState>();
  String email = "";
  String password = "";
  String fullName = "";
  AuthServices authServices = AuthServices();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //appBar: AppBar(),
        body: _isLoding
            ? Center(
                widthFactor: Checkbox.width,
                child: CircularProgressIndicator(
                    color: Theme.of(context).primaryColor,
		),
              )
            : SingleChildScrollView(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 80),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            SizedBox(
                              height: 400,
                              child: Image.asset(
                                "assets/chatlogin.jpg",
                                fit: BoxFit.fitWidth,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Flexible(
                        child: Form(
                          key: formKey,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              const Text(
                                "ChatChat",
                                style: TextStyle(
                                    fontSize: 40, fontWeight: FontWeight.bold),
                              ),
                              const Text(
                                "Create your account now to chat and explore",
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.w400),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              FractionallySizedBox(
                                widthFactor: 0.6,
                                child: TextFormField(
                                  decoration: textInputDecoration.copyWith(
                                      hintText: "Full Name",
                                      prefixIcon: Icon(
                                        Icons.person,
                                        color: Theme.of(context).primaryColor,
                                      )),
                                  onChanged: (val) {
                                    setState(() {
                                      fullName = val;
                                    });
                                  },
                                  validator: (val) {
                                    if (val!.isNotEmpty) {
                                      return null;
                                    } else {
                                      return "Name cannot be empty";
                                    }
                                  },
                                ),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              FractionallySizedBox(
                                widthFactor: 0.6,
                                child: TextFormField(
                                  decoration: textInputDecoration.copyWith(
                                      hintText: "Email",
                                      prefixIcon: Icon(
                                        Icons.email,
                                        color: Theme.of(context).primaryColor,
                                      )),
                                  onChanged: (val) {
                                    setState(() {
                                      email = val;
                                    });
                                  },
                                  validator: (val) {
                                    return RegExp(
                                                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                            .hasMatch(val!)
                                        ? null
                                        : "Please enter a valid email";
                                  },
                                ),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              FractionallySizedBox(
                                widthFactor: 0.6,
                                child: TextFormField(
                                  obscureText: true,
                                  decoration: textInputDecoration.copyWith(
                                      hintText: "Password",
                                      prefixIcon: Icon(
                                        Icons.lock,
                                        color: Theme.of(context).primaryColor,
                                      )),
                                  validator: (val) {
                                    if (val!.length < 6) {
                                      return "Password must be at least 6 characters";
                                    } else {
                                      return null;
                                    }
                                  },
                                  onChanged: (val) {
                                    setState(() {
                                      password = val;
                                    });
                                  },
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              SizedBox(
                                //width: double.infinity,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                          Theme.of(context).primaryColor,
                                      elevation: 0,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(30))),
                                  child: const Text(
                                    "Create account",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 16),
                                  ),
                                  onPressed: () {
                                    registered();
                                  },
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text.rich(TextSpan(
                                  text: "Already have an account?",
                                  style: const TextStyle(
                                      color: Colors.black, fontSize: 14),
                                  children: <TextSpan>[
                                    TextSpan(
                                        text: " Login now",
                                        style: const TextStyle(
                                            color: Colors.blueAccent,
                                            decoration:
                                                TextDecoration.underline),
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = () {
                                            nextScreen(
                                                context, const LoginScreen());
                                          })
                                  ]))
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ));
  }

  registered() async {
    if (formKey.currentState!.validate()) {
      setState(() {
        _isLoding = true;
      });
      await authServices
          .registerUserWithEmailandPassword(fullName, email, password)
          .then((value) async {
        if (value == true) {
          await HelperFunction.saveUserLoggedInStatus(true);
          await HelperFunction.saveUserEmailSF(email);
          await HelperFunction.saveUserNameSF(fullName);
          nextScreenReplace(context, const HomeScreen());
        } else {
          showSnaksbar(context, Colors.red, value);
          setState(() {
            _isLoding = false;
          });
        }
      });
    }
  }
}
