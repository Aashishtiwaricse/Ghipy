import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gipy/screens/GifSearchScreen%20.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();
  bool _isLogin = true;
  String _email = '';
  String _password = '';

  @override
  void initState() {
    super.initState();
    _checkUserStatus();
  }

  void _checkUserStatus() async {
    User? user = _auth.currentUser;
    if (user != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => GifSearchScreen()),
        );
      });
    }
  }

  void _submitAuthForm() async {
    final isValid = _formKey.currentState?.validate();
    if (isValid != true) {
      return;
    }

    try {
      if (_isLogin) {
        await _auth.signInWithEmailAndPassword(
            email: _email, password: _password);
      } else {
        await _auth.createUserWithEmailAndPassword(
            email: _email, password: _password);
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(_isLogin
              ? 'Logged in successfully!'
              : 'Account created successfully!'),
          backgroundColor: Colors.green,
        ),
      );

      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => GifSearchScreen()),
        );
      });
    } catch (e) {
      print(e);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('An error occurred. Please try again.'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(_isLogin ? 'Login' : 'Signup')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Email'),
                onChanged: (value) {
                  setState(() {
                    _email = value;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  return null;
                },
              ),
              SizedBox(height: 10),
              TextFormField(
                decoration: InputDecoration(labelText: 'Password'),
                obscureText: true,
                onChanged: (value) {
                  setState(() {
                    _password = value;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }
                  return null;
                },
              ),
              SizedBox(height: 15),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: (_email.isNotEmpty && _password.isNotEmpty)
                      ? Theme.of(context).primaryColor
                      : Colors.blue,
                ),
                child: Text(_isLogin ? 'Login' : 'Signup',
                    style: TextStyle(color: Colors.black)),
                onPressed: _submitAuthForm,
              ),
              SizedBox(height: 15),
              TextButton(
                child: Text(_isLogin
                    ? 'Create new account'
                    : 'Already have an account?'),
                onPressed: () {
                  setState(() {
                    _isLogin = !_isLogin;
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
