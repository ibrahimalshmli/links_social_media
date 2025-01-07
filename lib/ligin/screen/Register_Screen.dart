import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:links_social_media/ligin/network/collaction.dart';
import 'package:links_social_media/ligin/widget/button_register.dart';
import 'package:links_social_media/ligin/widget/button_widget.dart';
import 'package:links_social_media/ligin/widget/textfiled_widget.dart';
import 'package:links_social_media/model/mymodel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordConfirmationController =
      TextEditingController();

  late SharedPreferences pref;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    initializeSharedPreferences();
  }

  Future<void> initializeSharedPreferences() async {
    pref = await SharedPreferences.getInstance();
  }

  void registerUser() {
    final User user = User(
      name: nameController.text,
      email: emailController.text,
      id: 0,
    );
    String jsonString = jsonEncode(user);
    pref.setString("userData", jsonString);
    pref.setBool("islogin", true);
  }

  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    passwordConfirmationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Register')),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // App Image
                  Image.asset("assets/images/undraw_login_re_4vu2 1 (1).png"),
                  const SizedBox(height: 20),

                  // Name Field
                  const Text(
                    "Name",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 5),
                  customTextField(
                    nameController,
                    "Username",
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter your Username";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 15),

                  // Email Field
                  const Text(
                    "Email",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 5),
                  customTextField(
                    emailController,
                    "Example@gmail.com",
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter your Email";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 15),

                  // Password Field
                  const Text(
                    "Password",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 5),
                  customPasswordTextField(
                    passwordController,
                    "Password",
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter your Password";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 15),

                  // Password Confirmation Field
                  const Text(
                    "Password Confirmation",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 5),
                  customPasswordTextField(
                    passwordConfirmationController,
                    "Confirm Password",
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please confirm your Password";
                      }
                      if (value != passwordController.text) {
                        return "Passwords do not match";
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 25),

                  // Register Button
                  ButtonWidget(
                    text: "REGISTER",
                    onPressed: () async {
                      registerUser();
                      if (!_formKey.currentState!.validate()) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'Please fill in all fields correctly.',
                            ),
                          ),
                        );
                      } else {
                        Colaction colaction = Colaction();
                        await colaction.Register(
                          context: context,
                          name: nameController.text,
                          email: emailController.text,
                          password: passwordController.text,
                          password_confirmation:
                              passwordConfirmationController.text,
                        );
                      }
                    },
                    color: const Color(0xffFFD465),
                    Color: const Color(0xff784E00),
                  ),
                  const SizedBox(height: 25),

                  // OR Text
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 150),
                    child: Text(
                      "OR",
                      style: TextStyle(fontSize: 20, color: Color(0xffCECECE)),
                    ),
                  ),
                  const SizedBox(height: 25),

                  // Google Sign-In Button
                  ButtonRegister(
                    texts: "SIGN IN WITH GOOGLE",
                    onPresseds: () {},
                    colors: Colors.white,
                    Colors: const Color(0xffA90606),
                    Colores: const Color(0xffA90606),
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
