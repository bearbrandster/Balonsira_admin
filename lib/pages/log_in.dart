import 'package:admin/components/text_field.dart';
import 'package:flutter/material.dart';

class login_page extends StatefulWidget {
  final void Function()? onTap;

  login_page({super.key, required this.onTap});

  @override
  State<login_page> createState() => _login_pageState();
}

class _login_pageState extends State<login_page> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool passToggle = true;
  bool _isLoading = false;
  String? _errorMessage;

  // correct email and password
  final String correctEmail = 'BalonSira@gmail.com';
  final String correctPassword = 'Thesis4dawin';

  // Function to validate credentials
  void _loginUser() {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    // Simulate loading delay
    Future.delayed(Duration(seconds: 1), () {
      if (_emailController.text.trim() == correctEmail &&
          _passwordController.text.trim() == correctPassword) {
        // Navigate to the homepage if login is successful
        Navigator.pushReplacementNamed(context, '/home');
      } else {
        setState(() {
          _errorMessage = 'Invalid email or password. Please try again.';
        });
      }
      setState(() {
        _isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color.fromARGB(255, 21, 94, 204),
            Color.fromARGB(255, 103, 190, 231),
            const Color.fromARGB(255, 21, 94, 204)
          ],
        )),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(children: [
              SizedBox(height: 30),
              Title(
                  color: const Color.fromARGB(255, 128, 33, 33),
                  child: Text(
                    'BalonSira',
                    style: TextStyle(
                        fontSize: 50,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  )),
              SizedBox(height: 60),
              Text(
                'ADMIN PANEL',
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w400,
                    color: Colors.white),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),

              // Email input field
              Mytextfield(
                  controller: _emailController,
                  prefixIcon: Icon(Icons.email),
                  suffixIcon: null,
                  hintText: "Email",
                  obscureText: false),

              SizedBox(height: 25),

              // Password input field with visibility toggle
              Mytextfield(
                  controller: _passwordController,
                  suffixIcon: InkWell(
                    onTap: () {
                      setState(() {
                        passToggle = !passToggle;
                      });
                    },
                    child: Icon(
                        passToggle ? Icons.visibility : Icons.visibility_off),
                  ),
                  prefixIcon: Icon(Icons.lock),
                  hintText: "Password",
                  obscureText: passToggle),

              SizedBox(height: 20),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Remember Me?"),
                  Text(
                    "Forgot Password?",
                    style: TextStyle(color: Colors.red),
                  )
                ],
              ),

              SizedBox(height: 50),

              if (_errorMessage != null)
                Text(
                  _errorMessage!,
                  style: TextStyle(color: Colors.red),
                ),
              if (_isLoading)
                CircularProgressIndicator()
              else
                ElevatedButton(
                  onPressed: _loginUser, // Call login function
                  child: Text('Login'),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                    textStyle: TextStyle(fontSize: 20),
                  ),
                ),
            ]),
          ),
        ),
      ),
    );
  }
}
