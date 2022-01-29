import 'dart:io';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'auth_widgets/auth_form.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final _auth = FirebaseAuth.instance;
  var _isLoading = false;

  void _submitAuthForm(
    String email,
    String username,
    String passwd,
    File image,
    bool wantLogin,
    BuildContext ctx,
  ) async {
    var _snackbar = ScaffoldMessenger.of(ctx);
    try {
      setState(() {
        _isLoading = true;
      });
      UserCredential user;
      if (wantLogin) {
        user = await _auth.signInWithEmailAndPassword(email: email, password: passwd);
        _snackbar.hideCurrentSnackBar();
        _snackbar.showSnackBar(const SnackBar(content: Text('Logged in successfully')));
      } else {
        user = await _auth.createUserWithEmailAndPassword(email: email, password: passwd);
        await FirebaseFirestore.instance.collection('users').doc(user.user!.uid).set({
          'username': username,
          'email': email,
        });
        _snackbar.hideCurrentSnackBar();
        _snackbar.showSnackBar(const SnackBar(content: Text('Registered successfully')));
      }
    } on FirebaseAuthException catch (e) {
      var msg = 'Please check your credentials';
      if (e.message != null) msg = e.message!;
      _snackbar.hideCurrentSnackBar();
      _snackbar.showSnackBar(SnackBar(content: Text(msg)));
    } catch (e) {
      print(e);
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: AuthForm(_submitAuthForm, _isLoading),
    );
  }
}
