import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  const AuthForm(this._submitFn, {Key? key}) : super(key: key);

  final void Function(
    String email,
    String username,
    String passwd,
    bool wantLogin,
    BuildContext ctx,
  ) _submitFn;

  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();

  var _wantLogin = true;
  var _email = '';
  var _username = '';
  var _passwd = '';

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      FocusScope.of(context).unfocus();
      _formKey.currentState!.save();
      widget._submitFn(
        _email,
        _username,
        _passwd,
        _wantLogin,
        context,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: const EdgeInsets.all(20),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  key: const ValueKey('email'),
                  decoration: const InputDecoration(labelText: 'Email'),
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  validator: (value) {
                    if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]").hasMatch(value!)) {
                      return "Please Enter a valid email";
                    }
                  },
                  onSaved: (value) => _email = value!,
                ),
                if (!_wantLogin)
                  TextFormField(
                    key: const ValueKey('username'),
                    decoration: const InputDecoration(labelText: 'Username'),
                    textInputAction: TextInputAction.next,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please provide a username";
                      }
                      if (value.length < 3) {
                        return "username should be at least 3 Characters long";
                      }
                    },
                    onSaved: (value) => _username = value!,
                  ),
                TextFormField(
                  key: const ValueKey('passwd'),
                  decoration: const InputDecoration(labelText: 'Password'),
                  obscureText: true,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please provide a password";
                    }
                    if (value.length < 6) {
                      return "Password should be at least 6 Characters long";
                    }
                  },
                  onSaved: (value) => _passwd = value!,
                ),
                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed: _submitForm,
                  child: Text(_wantLogin ? 'Login' : 'Sign up'),
                ),
                TextButton(
                  onPressed: () {
                    setState(() {
                      _wantLogin = !_wantLogin;
                    });
                  },
                  child: Text(
                    _wantLogin ? 'Create account' : 'Log in',
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
