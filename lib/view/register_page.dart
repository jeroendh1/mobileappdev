import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
  final TextEditingController _firstNameController = TextEditingController(); // Added field
  final TextEditingController _lastNameController = TextEditingController();  // Added field

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
              TextField(  // Added field
                controller: _firstNameController,
                decoration: InputDecoration(
                  labelText: 'First Name',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20.0),
              TextField(  // Added field
                controller: _lastNameController,
                decoration: InputDecoration(
                  labelText: 'Last Name',
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
                  String firstName = _firstNameController.text.trim();  // Added field
                  String lastName = _lastNameController.text.trim();    // Added field

                  var registered = authController.register(username, email, firstName, lastName, password);
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
                  // Navigate to the registration page
                  Navigator.pushReplacementNamed(context, '/login');
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
