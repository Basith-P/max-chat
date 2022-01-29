import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AuthForm extends StatefulWidget {
  const AuthForm(this._submitFn, this.isLoading, {Key? key}) : super(key: key);

  final void Function(
    String email,
    String username,
    String passwd,
    File image,
    bool wantLogin,
    BuildContext ctx,
  ) _submitFn;
  final bool isLoading;

  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();

  var _wantLogin = true;
  var _email = '';
  var _username = '';
  var _passwd = '';

  XFile? imageFile;
  File? _pickedImage;

  void _pickImage() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        content: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            InkWell(
              borderRadius: BorderRadius.circular(16),
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Icon(Icons.camera_alt_outlined),
                    Text('Camera'),
                  ],
                ),
              ),
              onTap: () async {
                Navigator.of(ctx).pop();
                imageFile = await ImagePicker().pickImage(source: ImageSource.camera);
              },
            ),
            InkWell(
              borderRadius: BorderRadius.circular(16),
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Icon(Icons.photo_library_outlined),
                    Text('Gallery'),
                  ],
                ),
              ),
              onTap: () async {
                Navigator.of(ctx).pop();
                imageFile = await ImagePicker().pickImage(source: ImageSource.gallery);
              },
            ),
          ],
        ),
      ),
    );

    setState(() {
      _pickedImage = File(imageFile!.path);
    });
  }

  void _submitForm() {
    if (_pickedImage == null && !_wantLogin) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please pick an image..!'),
        ),
      );
      return;
    }

    if (_formKey.currentState!.validate()) {
      FocusScope.of(context).unfocus();
      _formKey.currentState!.save();
      widget._submitFn(
        _email,
        _username,
        _passwd,
        _pickedImage!,
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
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                if (!_wantLogin)
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: _pickedImage != null ? FileImage(_pickedImage!) : null,
                    child: CircleAvatar(
                      backgroundColor: Colors.black26,
                      radius: 50,
                      child: IconButton(
                        icon: const Icon(
                          Icons.camera_alt_outlined,
                          color: Colors.white,
                        ),
                        onPressed: _pickImage,
                      ),
                    ),
                  ),
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
                  onSaved: (value) => _email = value!.trim(),
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
                    onSaved: (value) => _username = value!.trim(),
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
                  onSaved: (value) => _passwd = value!.trim(),
                ),
                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed: _submitForm,
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: widget.isLoading
                        ? const SizedBox(
                            height: 19,
                            width: 19,
                            child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                          )
                        : Text(
                            _wantLogin ? 'Log in' : 'Sign up',
                            style: const TextStyle(fontSize: 16),
                          ),
                  ),
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
