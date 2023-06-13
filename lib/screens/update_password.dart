
import 'package:flutter/material.dart';
import 'package:kegeberew_delivery/util/toast.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:provider/provider.dart';

import '../controller/auth.dart';
import '../controller/profile.dart';
import '../util/app_bar.dart';
import '../util/custom_exception.dart';

class UpdatePassword extends StatefulWidget {
  const UpdatePassword({super.key});

  @override
  State<UpdatePassword> createState() => _UpdatePasswordState();
}

class _UpdatePasswordState extends State<UpdatePassword> {
  final _oldController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmController = TextEditingController();
  bool obscureText = true;

  void showPassword() {
    setState(() {
      obscureText = !obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: const PreferredSize(
          preferredSize: Size.fromHeight(56.0),
          child: CustomAppBarPop(title: "Update Password")),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: screenSize.height * 0.05),
            Padding(
              padding: EdgeInsets.only(left: screenSize.width * 0.08),
              child: const Text("Old Password",
                  style: TextStyle(fontSize: 16, color: Colors.red)),
            ),
            Center(
              child: SizedBox(
                height: 44,
                width: screenSize.width * 0.84,
                child: TextField(
                  controller: _oldController,
                  cursorWidth: 1.5,
                  obscureText: obscureText,
                  textAlignVertical: TextAlignVertical.bottom,
                  decoration: const InputDecoration(
                      counterStyle: TextStyle(fontSize: 0.0), hintText: ""),
                ),
              ),
            ),
            const SizedBox(height: 15),
            Padding(
              padding: EdgeInsets.only(left: screenSize.width * 0.08),
              child: const Text("New Password",
                  style: TextStyle(fontSize: 16, color: Colors.red)),
            ),
            Center(
              child: SizedBox(
                height: 44,
                width: screenSize.width * 0.84,
                child: TextField(
                  controller: _passwordController,
                  cursorWidth: 1.5,
                  obscureText: obscureText,
                  textAlignVertical: TextAlignVertical.bottom,
                  decoration: const InputDecoration(
                      counterStyle: TextStyle(fontSize: 0.0), hintText: ""),
                ),
              ),
            ),
            const SizedBox(height: 15),
            //
            //Confirm Password
            //
            Padding(
              padding: EdgeInsets.only(left: screenSize.width * 0.08),
              child: const Text("Confirm password",
                  style: TextStyle(fontSize: 16, color: Colors.red)),
            ),
            Center(
              child: SizedBox(
                height: 44,
                width: screenSize.width * 0.84,
                child: TextField(
                  controller: _confirmController,
                  cursorWidth: 1.5,
                  obscureText: obscureText,
                  textAlignVertical: TextAlignVertical.bottom,
                  decoration: InputDecoration(
                      counterStyle: const TextStyle(fontSize: 0.0),
                      hintText: "",
                      suffixIcon: obscureText
                          ? IconButton(
                              onPressed: () => showPassword(),
                              icon: const Icon(Icons.visibility_outlined,
                                  size: 21))
                          : IconButton(
                              onPressed: () => showPassword(),
                              icon: const Icon(Icons.visibility_off_outlined,
                                  size: 21))),
                ),
              ),
            ),
            const SizedBox(height: 32),
            Center(
              child: GestureDetector(
                onTap: () => validateUpdate(),
                child: Container(
                  alignment: Alignment.center,
                  height: 44,
                  width: screenSize.width * 0.84,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: const Text(
                    "Update Password",
                    style: TextStyle(fontSize: 17, color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  validateUpdate() async {
    if (_oldController.text.trim().isEmpty) {
      showErrorMessage(
          width: 250,
          context: context,
          errorMessage: "Old password is required");
    } else if (_oldController.text.trim().length <= 5) {
      showErrorMessage(
          width: 250,
          context: context,
          errorMessage: "Old Password must be at least 6 digit");
    } else if (_passwordController.text.trim().length <= 5) {
      showErrorMessage(
          width: 250,
          context: context,
          errorMessage: "New Password must be at least 6 digit");
    } else if (_passwordController.text.trim() !=
        _confirmController.text.trim()) {
      showErrorMessage(
          width: 250,
          context: context,
          errorMessage: "New Password do not match");
    } else {
      try {
        FocusScope.of(context).unfocus();
        context.loaderOverlay.show();

        await Provider.of<ProfileProvider>(context, listen: false)
            .updatePassword(
                oldPassword: _oldController.text.trim(),
                newPassword: _confirmController.text.trim(),
                userID:
                    Provider.of<AuthProvider>(context, listen: false).userID!)
            .then((_) {
          context.loaderOverlay.hide();
          showSuccessMessage(
              width: 250,
              context: context,
              successMessage: "Password Updated Successfully");

          Future.delayed(const Duration(seconds: 2), () {
            Navigator.of(context).pop();
          });
        });
      } on CustomException catch (e) {
        showErrorMessage(
            width: 250, context: context, errorMessage: e.toString());
        context.loaderOverlay.hide();
      } catch (_) {
        showErrorMessage(
            width: 250,
            context: context,
            errorMessage: "Please Try Again Later");
        context.loaderOverlay.hide();
      }
    }
  }
}
