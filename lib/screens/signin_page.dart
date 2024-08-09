import 'package:flutter/material.dart';
import 'package:simple_crud/screens/home_page.dart';
import 'package:simple_crud/services/authentication.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  // Form key
  final _formKey = GlobalKey<FormState>();

  // Text field controller
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // Authentication service
  final AuthenticationService _authenticationService = AuthenticationService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Card(
        color: Colors.white,
        margin: const EdgeInsets.all(20),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              const Icon(
                Icons.lock_rounded,
                size: 100,
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                'Welcome to our app, Hope you are doing well!',
                style: TextStyle(
                    fontFamily: 'montserrat',
                    fontSize: 15,
                    fontWeight: FontWeight.w400),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                    hintText: 'youremail123@gmail.com',
                    labelText: 'Email',
                    prefixIcon: Icon(Icons.email)),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                    hintText: 'yourpassword123',
                    labelText: 'Password',
                    prefixIcon: Icon(Icons.password)),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    const Text('Please enter your password');
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentContext != null) {
                      if (_formKey.currentState!.validate()) {
                        try {
                          await _authenticationService.signIn(
                              _emailController.text, _passwordController.text);

                          _emailController.clear();
                          _passwordController.clear();

                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('Sign In Successful')));

                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (context) => const HomePage()));
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text(
                                    'Your email or password is wrong, or you don\'t have an account')),
                          );
                        }
                      }
                    }
                  },
                  child: const Text('Sign In'))
            ]),
          ),
        ),
      ),
    ));
  }
}
