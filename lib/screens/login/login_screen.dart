import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:protegelapp/screens/forget_password/forget_password_mail.dart';
import 'package:protegelapp/screens/forget_password/forget_password_phone.dart';
import 'package:protegelapp/screens/login/login_controller.dart';
import 'package:protegelapp/screens/signup/signup_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  bool passToggle = true;
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());

    return Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Form(
              key: _formKey,
              child: Column(children: [
                SizedBox(height: 10),
                Padding(
                  padding: EdgeInsets.all(20),
                  child: SizedBox(
                    width: 150,
                    height: 150,
                    child: Image(image: AssetImage('images/Logo.png')),
                  ),
                ),
                Text(
                  "Log In",
                  style: TextStyle(
                    color: Color(0xff5C4DB1),
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: EdgeInsets.all(12),
                  child: TextFormField(
                    controller: controller.email,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      prefixIcon: Icon(Icons.email),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(12),
                  child: TextFormField(
                    controller: controller.password,
                    obscureText: passToggle ? true : false,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      prefixIcon: Icon(Icons.lock),
                      suffixIcon: InkWell(
                        onTap: () {
                          if (passToggle == true) {
                            passToggle = false;
                          } else {
                            passToggle = true;
                          }
                          setState(() {});
                        },
                        child: passToggle
                            ? Icon(CupertinoIcons.eye_slash_fill)
                            : Icon(CupertinoIcons.eye_fill),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0)),
                        builder: (context) => Container(
                          padding: const EdgeInsets.all(30.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Make Selection!',
                                  style:
                                      Theme.of(context).textTheme.titleLarge),
                              SizedBox(height: 10),
                              Text(
                                  'Select one of the options given below to reset your password',
                                  style:
                                      Theme.of(context).textTheme.bodyMedium),
                              const SizedBox(
                                height: 30.0,
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            ForgetPasswordMailScreen(),
                                      ));
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(20.0),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.0),
                                    color: Colors.grey.shade200,
                                  ),
                                  child: Row(
                                    children: [
                                      const Icon(
                                        Icons.mail_outline_rounded,
                                        size: 60.0,
                                        color: Color(0xFF7165D6),
                                      ),
                                      const SizedBox(
                                        height: 30.0,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text('E-Mail',
                                              style: TextStyle(
                                                fontSize: 20.0,
                                                fontWeight: FontWeight.w600,
                                              )),
                                          Text('Reset via E-Mail Verificaton',
                                              style: TextStyle(
                                                fontSize: 16.0,
                                                fontWeight: FontWeight.normal,
                                              )),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 20.0,
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            ForgetPasswordPhoneScreen(),
                                      ));
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(20.0),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.0),
                                    color: Colors.grey.shade200,
                                  ),
                                  child: Row(
                                    children: [
                                      const Icon(
                                        Icons.mobile_friendly_rounded,
                                        size: 60.0,
                                        color: Color(0xFF7165D6),
                                      ),
                                      const SizedBox(
                                        height: 30.0,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text('Phone No',
                                              style: TextStyle(
                                                fontSize: 20.0,
                                                fontWeight: FontWeight.w600,
                                              )),
                                          Text('Reset via Phone Verificaton',
                                              style: TextStyle(
                                                fontSize: 16.0,
                                                fontWeight: FontWeight.normal,
                                              )),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                    child: const Text('Forget Password?'),
                  ),
                ),
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: SizedBox(
                    width: double.infinity,
                    child: Material(
                      color: Color(0xFF7165D6),
                      borderRadius: BorderRadius.circular(10),
                      child: TextButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            LoginController.instance.loginUser(
                                controller.email.text.trim(),
                                controller.password.text.trim());
                          }
                        },
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 15, horizontal: 40),
                          child: Center(
                            child: Text(
                              'Log In',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                // Column(
                //   crossAxisAlignment: CrossAxisAlignment.center,
                //   children: [
                //     const Text('OR'),
                //     const SizedBox(
                //       height: 10,
                //     ),
                //     SizedBox(
                //         width: double.infinity,
                //         child: OutlinedButton.icon(
                //             onPressed: () {
                //               LoginController.instance.signInWithGoogle();
                //             },
                //             icon: Image(
                //               image: AssetImage('images/google.png'),
                //               width: 20.0,
                //             ),
                //             label: Text('Sign In with Google'))),
                //     SizedBox(
                //         width: double.infinity,
                //         child: OutlinedButton.icon(
                //             onPressed: () {},
                //             icon: Image(
                //               image: AssetImage('images/facebook.png'),
                //               width: 20.0,
                //             ),
                //             label: Text('Sign In with Facebook')))
                //   ],
                // ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account?",
                      style: TextStyle(
                        color: Colors.black54,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SignupScreen(),
                            ));
                      },
                      child: Text(
                        'Sign Up',
                        style: TextStyle(
                          color: Color(0xFF7165D6),
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 100),
              ])),
        ));
  }
}
