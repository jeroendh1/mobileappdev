import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:mobileappdev/view/login_page.dart';

import '../viewmodel/Auth_viewmodel.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  AuthenticationViewModel authController = Get.put(AuthenticationViewModel());
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register'),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20.0),
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
                  // Handle registration logic here
                  String email = _emailController.text.trim();
                  String username = _usernameController.text.trim();
                  String password = _passwordController.text.trim();

                  // Perform registration logic (e.g., call an API, save to database)
                  // ...
                  var registered = authController.register(username, email, password);
                  if (await registered){
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => LoginPage()
                      ),
                    );
                  }
                },
                child: Text('Register'),
              ),
              SizedBox(height: 20.0),
              GestureDetector(
                onTap: () {
                  // Navigate to the login page
                  Navigator.pop(context);
                },
                child: Text(
                  'Already have an account? Login here',
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
