import 'package:flutter/material.dart';
import 'package:links_social_media/ligin/network/Request/login.dart';
import 'package:links_social_media/ligin/screen/Register_Screen.dart';
import 'package:links_social_media/ligin/widget/button_widget.dart';
import 'package:links_social_media/widgets/Condition_check.dart';

import '../widget/button_register.dart';
import '../widget/textfiled_widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final AuthService _authService = AuthService();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 50),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image(
                    image: AssetImage(
                      "assets/images/undraw_login_re_4vu2 1 (1).png",
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    "Email",
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 3),

                  // customTextField
                  customTextField(
                    validator: (value) {
                      if ((value?.isEmpty) ?? true) {
                        return value;
                      }
                      return " Enter your email ";
                    },
                    emailController,
                    "Exapel@gmail.com",
                  ),
                  SizedBox(height: 25),
                  Text(
                    "Password",
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 3),

                  customPasswordTextField(
                    passwordController,
                    "password",
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return value;
                      }
                      return "Enter your password";
                    },
                  ),
                  SizedBox(height: 25),
                  ButtonWidget(
                    text: "LOGIN",
                    onPressed: () async {
                      await _authService.login();
                      if (_formKey.currentState!.validate() ?? false) {
                        login(
                          context: context,
                          email: emailController.text,
                          password: passwordController.text,
                        );
                      }
                    },
                    color: Color(0xffFFD465),
                    Color: Color(0xff784E00),
                  ),
                  SizedBox(height: 25),

                  ButtonRegister(
                    texts: "REGISTER",
                    onPresseds: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RegisterScreen(),
                        ),
                      );
                    },
                    colors: Colors.white,
                    Colors: Color(0xff2D2B4E),
                    Colores: Color(0xff2D2B4E),
                  ),
                  SizedBox(height: 25),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 150),
                    child: Text(
                      "OR",
                      style: TextStyle(fontSize: 25, color: Color(0xffCECECE)),
                    ),
                  ),
                  SizedBox(height: 25),

                  ButtonRegister(
                    texts: "SIGN IN WITH GOOGLE",
                    onPresseds: () {},
                    colors: Colors.white,
                    Colors: Color(0xffA90606),
                    Colores: Color(0xffA90606),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
