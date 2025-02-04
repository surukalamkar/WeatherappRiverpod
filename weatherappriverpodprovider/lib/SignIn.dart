import 'package:flutter/material.dart';
import 'package:weatherappriverpodprovider/HomeScreen.dart';
import 'package:weatherappriverpodprovider/SingUpScreen.dart';
import 'package:weatherappriverpodprovider/firebase_db.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});
  @override
  State createState() => _SignInState();
}

TextEditingController emailController = TextEditingController();
TextEditingController passwordController = TextEditingController();

class _SignInState extends State {
  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.1,
            ),
            Image.asset(
              "assets/app_logo.png",
              height: screenHeight * 0.2,
              width: screenWidth * 1,
            ),
            const Text(
              "Sign in",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(
              height: screenHeight * 0.05,
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: MediaQuery.sizeOf(context).width * 0.035,
                  right: MediaQuery.sizeOf(context).width * 0.035),
              child: Column(
                children: [
                  TextFormField(
                    controller: emailController,
                    decoration: const InputDecoration(
                      label: Text("Email"),
                    ),
                    cursorColor: Colors.white,
                    style: const TextStyle(color: Colors.white),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 23,
                  ),
                  TextFormField(
                    controller: passwordController,
                    decoration: const InputDecoration(
                      label: Text("Password"),
                      suffix: Text(
                        "Forgot?",
                        style: TextStyle(
                          color: Color.fromRGBO(255, 255, 255, 1.0),
                        ),
                      ),
                    ),
                    style: const TextStyle(color: Colors.white),
                    cursorColor: Colors.white,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 18,
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      if (emailController.text.isNotEmpty &&
                          passwordController.text.isNotEmpty) {
                        bool isValid = await FirebaseDB.signIn(
                          email: emailController.text.trim(),
                          password: passwordController.text.trim(),
                        );
                        if (isValid) {
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (context) => HomeScreen()));
                          emailController.clear();
                          passwordController.clear();
                        } else {
                          // Scaffold.snackbar(
                          //   "Login Failed",
                          //   "Invalid email or password",
                          //   colorText: Colors.white,
                          //   backgroundColor: Colors.black,
                          //   snackPosition: SnackPosition.BOTTOM,
                          // );
                        }
                      } else {
                        // Get.snackbar(
                        //   "Error",
                        //   "Email and Password fields cannot be empty",
                        //   colorText: Colors.white,
                        //   backgroundColor: Colors.black,
                        //   snackPosition: SnackPosition.BOTTOM,
                        // );
                      }
                    },
                    style: ButtonStyle(
                      backgroundColor: const WidgetStatePropertyAll(
                          Color.fromRGBO(9, 9, 22, 1)),
                      minimumSize: WidgetStatePropertyAll(
                          Size(screenWidth * 0.95, screenHeight * 0.06)),
                      shape: const WidgetStatePropertyAll(
                          RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5)))),
                      side: const WidgetStatePropertyAll(
                          BorderSide(color: Colors.white)),
                    ),
                    child: const Text(
                      "Sign in",
                      style: TextStyle(
                          fontSize: 18,
                          color: Color.fromRGBO(255, 255, 255, 1.0),
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 18,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Don't have account?",
                        style: TextStyle(fontWeight: FontWeight.w300),
                      ),
                      TextButton(
                        onPressed: () {
                          // Get.off(() => const Signup());
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => Signup()));
                          emailController.clear();
                          passwordController.clear();
                        },
                        child: const Text(
                          "Create now",
                          style: TextStyle(
                              color: Colors.pink, fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
