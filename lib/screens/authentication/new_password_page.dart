import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:kungwi/common/dialog/messageDialog/message_dialog.dart';
import 'package:kungwi/common/spacer/custom_spacer.dart';
import 'package:kungwi/common/textfield/textfield_widget.dart';

import 'package:kungwi/providers/authentication/authentication_service.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NewPasswordPage extends ConsumerStatefulWidget {
  final String email;
  const NewPasswordPage({required this.email, super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _NewPasswordPageState();
}

class _NewPasswordPageState extends ConsumerState<NewPasswordPage> {
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController comfirmPasswordController =
      TextEditingController();
  bool obscureText = true;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading == true
          ? const Center(child: CircularProgressIndicator())
          : SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(top: 25, left: 15, right: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("New Password",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold)),
                      CustomSpacer(
                        height: 2.h,
                      ),
                      TextFieldWidget(
                        texttFieldController: passwordController,
                        hintText: "New Password",
                        obscureText: obscureText,
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              obscureText = !obscureText;
                            });
                          },
                          icon: Icon(obscureText == false
                              ? FontAwesomeIcons.eye
                              : FontAwesomeIcons.eyeSlash),
                        ),
                      ),
                      CustomSpacer(
                        height: 2.h,
                      ),
                      TextFieldWidget(
                        texttFieldController: comfirmPasswordController,
                        hintText: "Comfirm New Password",
                        obscureText: obscureText,
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              obscureText = !obscureText;
                            });
                          },
                          icon: Icon(obscureText == false
                              ? FontAwesomeIcons.eye
                              : FontAwesomeIcons.eyeSlash),
                        ),
                      ),
                      CustomSpacer(
                        height: 2.h,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          if (passwordController.text == '') {
                            messageDialog(context, 'Password Is Reqiured',
                                'Password Is Required');
                          } else if (comfirmPasswordController.text == '') {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                behavior: SnackBarBehavior.floating,
                                margin: EdgeInsets.only(
                                    right: 10, left: 10, bottom: 10),
                                content:
                                    Text('Cofirm new password is required'),
                              ),
                            );
                          } else if (comfirmPasswordController.text !=
                              passwordController.text) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                behavior: SnackBarBehavior.floating,
                                margin: EdgeInsets.only(
                                    right: 10, left: 10, bottom: 10),
                                content: Text('password don`t match'),
                              ),
                            );
                          } else {
                            setState(() {
                              isLoading = true;
                            });
                            ref
                                .read(authServiceProvider)
                                .changeForgetPassword(
                                    phoneNumber: widget.email,
                                    password: passwordController.text)
                                .then((value) {
                              if (value['status'] == 'success') {
                                saveUserDetails() async {
                                  SharedPreferences preferences =
                                      await SharedPreferences.getInstance();
                                  preferences.setBool("logged", true);
                                  preferences.setString(
                                      "user_id", value['user_id']);
                                  preferences.setString(
                                      "token", value['token']);
                                  preferences.setString(
                                      "user_name", value['username']);
                                }

                                saveUserDetails();

                                saveUserDetails();

                                context.goNamed('home');
                              } else {
                                setState(() {
                                  isLoading = false;
                                });
                                messageDialog(
                                    context, value['status'], value['message']);
                              }
                            });
                          }
                        },
                        child: const Center(
                          child: Text(
                            "Reset Password",
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
