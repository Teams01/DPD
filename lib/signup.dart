import 'package:flutter/material.dart';
import 'home.dart'; // Import de la page d'accueil
import 'login.dart'; // Import de la page de login

class SignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String _successMessage = "";

  void _signup() {
    if (_usernameController.text.isNotEmpty &&
        _emailController.text.isNotEmpty &&
        _passwordController.text.isNotEmpty) {
      setState(() {
        _successMessage = "Inscription réussie !";
      });
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[900],
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 80),
              _buildLogo(),
              SizedBox(height: 50),
              _buildUsernameField(),
              SizedBox(height: 20),
              _buildEmailField(),
              SizedBox(height: 20),
              _buildPasswordField(),
              if (_successMessage.isNotEmpty) _buildSuccessMessage(),
              SizedBox(height: 30),
              _buildSignupButton(),
              SizedBox(height: 20),  // Space before the login prompt
              _buildLoginPrompt(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLogo() {
    return Center(
      child: Text(
        'Signup',
        style: TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.bold,
          color: Colors.orangeAccent,
          letterSpacing: 2,
        ),
      ),
    );
  }

  Widget _buildUsernameField() {
    return _buildTextField(
      controller: _usernameController,
      labelText: "Nom d'utilisateur",
      icon: Icons.person,
      hintText: 'Entrez votre nom d\'utilisateur',
    );
  }

  Widget _buildEmailField() {
    return _buildTextField(
      controller: _emailController,
      labelText: 'Email',
      icon: Icons.email,
      hintText: 'Entrez votre email',
    );
  }

  Widget _buildPasswordField() {
    return _buildTextField(
      controller: _passwordController,
      labelText: 'Mot de passe',
      icon: Icons.lock,
      hintText: 'Entrez votre mot de passe',
      obscureText: true,
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String labelText,
    required IconData icon,
    required String hintText,
    bool obscureText = false,
  }) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      style: TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: TextStyle(color: Colors.white),
        filled: true,
        fillColor: Colors.blueGrey[700],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        prefixIcon: Icon(icon, color: Colors.white),
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.white70),
      ),
    );
  }

  Widget _buildSuccessMessage() {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: Text(
        _successMessage,
        style: TextStyle(color: Colors.green, fontSize: 14),
      ),
    );
  }

  Widget _buildSignupButton() {
    return ElevatedButton(
      onPressed: _signup,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.orangeAccent,
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        elevation: 5,
      ),
      child: Text(
        'S\'inscrire',
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildLoginPrompt() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Vous avez déjà un compte ? ',
          style: TextStyle(
            color: Colors.white,
            fontSize: 14,
          ),
        ),
        TextButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => LoginScreen()),
            );
          },
          child: Text(
            'Se connecter',
            style: TextStyle(
              color: Colors.orangeAccent,
              fontSize: 14,
            ),
          ),
        ),
      ],
    );
  }
}
