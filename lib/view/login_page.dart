import 'package:flutter/material.dart';
import 'package:mobileappdev/view/home_page.dart';
import 'package:provider/provider.dart';
import '../viewmodel/Auth_viewmodel.dart';
import 'package:get/get.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  AuthenticationViewModel authController = Get.put(AuthenticationViewModel());
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final bool _rememberMe = true; // Change this value as per your logic

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextField(
                controller: _usernameController,
                decoration: InputDecoration(
                  labelText: 'Username',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20.0),
              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () async {
                  String username = _usernameController.text.trim();
                  String password = _passwordController.text.trim();
                  if (username.isNotEmpty && password.isNotEmpty) {
                    String? token = await authController.login(username, password, _rememberMe);
                    print(token);
                    if (token != null) {
                      // Login successful, navigate to the next screen
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HomePage()
                        ),
                      );
                    } else {
                      // Show error message to the user or handle authentication failure
                    }
                  } else {
                    // Show error message for empty fields
                  }
                },
                child: Text('Login'),
              ),
              SizedBox(height: 20.0),
              GestureDetector(
                onTap: () {
                  // Navigate to the registration page
                  Navigator.pushReplacementNamed(context, '/register');
                },
                child: Text(
                  'Don\'t have an account? Sign up here',
                  style: TextStyle(
                    color: Colors.blue, // You can customize the color
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
