import 'package:flutter/material.dart';
import 'package:weatherappriverpodprovider/HomeScreen.dart';
import 'package:weatherappriverpodprovider/firebase_db.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State createState() => _SignupState();
}

TextEditingController userNameController = TextEditingController();
TextEditingController emailController = TextEditingController();
TextEditingController passwordController = TextEditingController();
String? selectedValue;

class _SignupState extends State {
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
              height: screenHeight * 0.05,
            ),
            Image.asset(
              "assets/app_logo.png",
              height: screenHeight * 0.2,
              width: screenWidth * 1,
            ),
            const Text(
              "Sign up",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(
              height: screenHeight * 0.04,
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: screenWidth * 0.035, right: screenWidth * 0.035),
              child: Column(
                children: [
                  TextFormField(
                    controller: userNameController,
                    decoration: const InputDecoration(
                      label: Text(
                        "Enter Your Username",
                      ),
                    ),
                    cursorColor: Colors.white,
                    style: const TextStyle(color: Colors.white),
                  ),
                  SizedBox(
                    height: screenHeight / 50,
                  ),
                  TextFormField(
                    controller: emailController,
                    decoration: const InputDecoration(
                      label: Text("Enter Your Email"),
                    ),
                    cursorColor: Colors.white,
                    style: const TextStyle(color: Colors.white),
                  ),
                  SizedBox(
                    height: screenHeight / 50,
                  ),
                  DropdownButtonFormField<String>(
                    decoration: const InputDecoration(
                      labelText: "Select the country",
                    ),
                    dropdownColor: Colors.grey.withOpacity(0.3),
                    value: selectedValue,
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedValue = newValue;
                      });
                    },
                    items: <String>[
                      'India',
                      'USA',
                      'England',
                      'China',
                      'Russia',
                      'Japan',
                      'Pakistan',
                      'Nepal',
                      'Shrilanka',
                      'Afganistan',
                      'Ukrain',
                      'France',
                      'Isrel',
                      'Brazil',
                      'South Africa',
                      'Maldiv',
                      'Scotland'
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: const TextStyle(
                            color: Color.fromRGBO(255, 255, 255, 1.0),
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  SizedBox(
                    height: screenHeight / 50,
                  ),
                  TextFormField(
                    controller: passwordController,
                    decoration: const InputDecoration(
                      label: Text(
                        "Enter Your Password",
                      ),
                    ),
                    cursorColor: Colors.white,
                    style: const TextStyle(color: Colors.white),
                  ),
                  SizedBox(
                    height: screenHeight * 0.05,
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      if (emailController.text.isNotEmpty &&
                          passwordController.text.isNotEmpty &&
                          userNameController.text.isNotEmpty &&
                          selectedValue!.isNotEmpty) {
                        bool isValid = await FirebaseDB.signUp(
                          email: emailController.text.trim(),
                          password: passwordController.text.trim(),
                          userName: userNameController.text.trim(),
                          country: selectedValue!,
                        );
                        if (isValid) {
                          //   Get.offAll(() => const HomePageScreen());
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HomeScreen()));
                          userNameController.clear();
                          emailController.clear();
                          selectedValue = null;
                          passwordController.clear();
                        }
                      } else {
                        // Get.snackbar(
                        //   "Error",
                        //   "Details cannot be empty",
                        //   colorText: Colors.white,
                        //   backgroundColor: Colors.black,
                        //   snackPosition: SnackPosition.BOTTOM,
                        // );
                      }
                    },
                    style: ButtonStyle(
                      backgroundColor: const WidgetStatePropertyAll(
                        Color.fromRGBO(9, 9, 22, 1),
                      ),
                      minimumSize: WidgetStatePropertyAll(
                        Size(screenWidth * 0.95, screenHeight * 0.06),
                      ),
                      shape: const WidgetStatePropertyAll(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                        ),
                      ),
                      side: const WidgetStatePropertyAll(
                        BorderSide(color: Colors.white),
                      ),
                    ),
                    child: const Text(
                      "Sign up",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  SizedBox(
                    height: screenHeight / 18,
                  ),
                  TextButton(
                    onPressed: () {
                      //   Get.off(() => const SignIn());
                      Navigator.pop(context);
                      userNameController.clear();
                      emailController.clear();
                      selectedValue = null;
                      passwordController.clear();
                    },
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Have an account? ",
                          style: TextStyle(
                              color: Color.fromRGBO(255, 255, 255, 1.0),
                              fontWeight: FontWeight.w300),
                        ),
                        Text(
                          "Sign in now",
                          style: TextStyle(
                              color: Colors.pink, fontWeight: FontWeight.w700),
                        ),
                      ],
                    ),
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
