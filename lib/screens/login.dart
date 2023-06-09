import 'package:flutter/material.dart';
import 'package:kegeberew_delivery/util/custom_exception.dart';
import 'package:provider/provider.dart';

import '../constant/const.dart';
import '../controller/auth.dart';
import '../util/bottom_bar.dart';
import '../util/toast.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;
  bool _isLoading = false;

  void showPassword() {
    setState(() {
      _obscurePassword = !_obscurePassword;
    });
  }

  @override
  void dispose() {
    _phoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
        body: SafeArea(
            child: Stack(children: [
      SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //
                //Sign in
                //

                SizedBox(height: screenSize.height * 0.1),
                const Text("Login to your account",
                    style: TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.bold,
                    )),
                const SizedBox(height: 10),
                //
                //welcome text
                //
                const Text("Hy there! Nice to see you again",
                    style: TextStyle(
                      fontSize: 17,
                    )),

                const SizedBox(height: 30),
                //
                //Phone
                //
                Container(
                  height: 50,
                  width: screenSize.width,
                  decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(8)),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(left: 15.0, right: 15),
                          child: Text("+251", style: TextStyle(fontSize: 17)),
                        ),
                        Expanded(
                          child: TextField(
                            controller: _phoneController,
                            maxLength: 9,
                            cursorWidth: 1.5,
                            onChanged: (val) {
                              if (!val.startsWith("9")) {
                                _phoneController.clear();
                              }
                            },
                            keyboardType: TextInputType.phone,
                            decoration: const InputDecoration(
                                contentPadding: EdgeInsets.only(top: 3.5),
                                border: InputBorder.none,
                                counterStyle: TextStyle(fontSize: 0),
                                hintStyle: TextStyle(fontSize: 17),
                                hintText: "000 000 000"),
                          ),
                        ),
                      ]),
                ),
                const SizedBox(height: 20),
                //
                //Password
                //
                SignInTextFieldWidget(
                  hintText: "Password",
                  textInputType: TextInputType.visiblePassword,
                  controller: _passwordController,
                  obscureText: _obscurePassword,
                  suffixIcon: IconButton(
                    onPressed: () => showPassword(),
                    icon: _obscurePassword
                        ? const Icon(Icons.visibility_off, size: 18)
                        : const Icon(Icons.visibility, size: 18),
                  ),
                ),

                // const SizedBox(height: 15),
                //
                //Forget Password
                //
                // const Text("Forget Password?",
                //     style: TextStyle(color: Colors.green)),
                const SizedBox(height: 30),
                //
                //Login Button
                //

                GestureDetector(
                  onTap: () => validateThenLogin(),
                  child: Center(
                    child: Container(
                      height: 50,
                      width: screenSize.width,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50.0),
                          gradient: LinearGradient(
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                              colors: [
                                Colors.red,
                                Colors.red.withOpacity(0.9)
                              ])),
                      child: const Text(
                        "Login",
                        style: TextStyle(
                            fontSize: 19,
                            color: Colors.white,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ),
                //
                //
                //
                SizedBox(height: screenSize.height * 0.1),
                // Center(
                //     child: RichText(
                //         text: const TextSpan(
                //             text: "Don't Have An Account?",
                //             style: TextStyle(color: Colors.white),
                //             children: [
                //       TextSpan(
                //         text: " Sign Up",
                //         style: TextStyle(color: Colors.green),
                //       )
                //     ]))),
                // SizedBox(height: 20)
              ]),
        ),
      ),
      Positioned(
          child: _isLoading
              ? Container(
                  height: screenSize.height,
                  width: screenSize.width,
                  color: Colors.black.withOpacity(0.3),
                  child: Center(child: AppConst().customLoadingIndicator()),
                )
              : Container())
    ])));
  }

  void validateThenLogin() async {
    // Size screenSize =MediaQuery.of(context).size;
    if (_phoneController.text.length < 9 || _phoneController.text.length > 9) {
      showErrorMessage(
          context: context, width: 220, errorMessage: "Invalid Phone number");
    } else if (_passwordController.text.length < 6) {
      showErrorMessage(
          context: context, width: 220, errorMessage: "Incorrect Password ");
    } else {
      try {
        FocusScope.of(context).unfocus();
        setState(() {
          _isLoading = true;
        });
        await Provider.of<AuthProvider>(context, listen: false)
            .signIn(
                phone: int.parse("251${_phoneController.text}"),
                password: _passwordController.text)
            .then((_) {
          setState(() {
            _isLoading = false;
          });
          Provider.of<BottomBarProvider>(context, listen: false).resetIndex();
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => const CustomBottomBar()));
        });
      } on CustomException catch (e) {
        showErrorMessage(
            width: 250, context: context, errorMessage: e.toString());
        setState(() {
          _isLoading = false;
        });
      } catch (_) {
        showErrorMessage(
            width: 250, context: context, errorMessage: "Unknown Error");
        setState(() {
          _isLoading = false;
        });
      }
    }
  }
}

// ignore: must_be_immutable
class SignInTextFieldWidget extends StatelessWidget {
  String hintText;
  // IconData prefixIcon;
  IconButton? suffixIcon;
  num screenNum;
  VoidCallback? showPassword;
  bool obscureText;
  TextInputType textInputType;
  TextEditingController controller;

  SignInTextFieldWidget(
      {super.key,
      required this.hintText,
      // required this.prefixIcon,
      required this.controller,
      required this.textInputType,
      this.showPassword,
      this.suffixIcon,
      this.obscureText = false,
      this.screenNum = 1});

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Container(
      height: 50,
      width: screenSize.width * screenNum,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.15),
          borderRadius: BorderRadius.circular(8)),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        keyboardType: textInputType,
        textAlignVertical: TextAlignVertical.center,
        decoration: InputDecoration(
          border: InputBorder.none,
          contentPadding: const EdgeInsets.only(left: 15),
          suffixIcon: suffixIcon,
          hintText: hintText,
        ),
      ),
    );
  }
}
