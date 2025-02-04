import 'dart:developer';
import 'package:auth/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseDB {
  static final FirebaseFirestore _firebaseFirestore =
      FirebaseFirestore.instance;

  // Signup with email and Password
  static Future<bool> signUp(
      {required String email,
      required String password,
      required String userName,
      required String country}) async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      String timestamp = DateTime.now().millisecondsSinceEpoch.toString();
      String userId = "${email.split('@')[0]}_$timestamp";
      await _firebaseFirestore //await _firebaseFirestore.collection("collectionPath").doc("users").set({
          .collection("users")
          .doc("userData: ${userCredential.user!.uid}")
          .set({
        'email': email,
        'userName': userName,
        'country': country,
        'password': password,
        'userId': userId,
      });
      log("Account created successfully");
      return true;
    } on FirebaseException catch (e) {
      if (e.code == 'weak-password') {
        log('The password provided is too weak.');
        // Get.snackbar(
        //   "Signup Failed",
        //   "The password provided is too weak",
        //   colorText: Colors.white,
        //   backgroundColor: Colors.black,
        //   snackPosition: SnackPosition.BOTTOM,
        // );
      } else if (e.code == 'email-already-in-use') {
        log('The account already exists for that email.');
        // Get.snackbar(
        //   "Signup Failed",
        //   "The account already exists for that email",
        //   colorText: Colors.white,
        //   backgroundColor: Colors.black,
        //   snackPosition: SnackPosition.BOTTOM,
        // );
      } else {
        // Get.snackbar(
        //   "Signup Failed",
        //   "Invalid Input",
        //   colorText: Colors.white,
        //   backgroundColor: Colors.black,
        //   snackPosition: SnackPosition.BOTTOM,
        // );
      }
      return false;
    } catch (e) {
      log(e.toString());
      // Get.snackbar(
      //   "Signup Failed",
      //   "Enter the Details correctly",
      //   colorText: Colors.white,
      //   backgroundColor: Colors.black,
      //   snackPosition: SnackPosition.BOTTOM,
      // );
      return false;
    }
  }

  // Signin with Email and password
  static Future<bool> signIn(
      {required String email, required String password}) async {
    log("in signin function");
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      return true;
    } on FirebaseException catch (e) {
      if (e.code == 'user-not-found') {
        log('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        log('Wrong password provided for that user.');
      }
      return false;
    }
  }

  // static Future<void> getDataFromCloud() async {
  //   DocumentSnapshot userSnapshot =
  //       await FirebaseFirestore.instance.collection('users').doc().get();
  //   var userName = userSnapshot['userName'];
  //   log(userName.toString());
  // }
}