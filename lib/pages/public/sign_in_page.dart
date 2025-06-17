import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:goaly/utils/errors.dart';
import 'package:goaly/utils/validators.dart';

class SignInPage extends StatefulWidget {
  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController newEmail = TextEditingController();
  final TextEditingController newPassword = TextEditingController();
  bool hiddenPassword = true;
  late String errorMessage = '';
  void _submit() async {
    setState(() {
      errorMessage = '';
    });
    if (!_formKey.currentState!.validate()) return;
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: newEmail.text,
        password: newPassword.text,
      );
      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = authErrorMessage(e, false);
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          spacing: 10,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Welcome back to ',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Image.asset('assets/images/logo-alt.png', width: 150),
            SizedBox(height: 30),
            Form(
              key: _formKey,
              child: Column(
                spacing: 15,
                children: [
                  TextFormField(
                    controller: newEmail,
                    decoration: InputDecoration(labelText: 'Email'),
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    validator: (value) {
                      if (value == null) return 'The email is required';
                      if (!isEmail(value)) return 'The email is not valid.';
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: newPassword,
                    obscureText: hiddenPassword,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      suffixIcon: IconButton(
                        icon: Icon(
                          hiddenPassword
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                        onPressed: () {
                          setState(() {
                            hiddenPassword = !hiddenPassword;
                          });
                        },
                      ),
                    ),
                    keyboardType: TextInputType.visiblePassword,
                    textInputAction: TextInputAction.next,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'The password is required';
                      }
                      final errors = <String>[];
                      if (value.length < 6) {
                        errors.add('6 characters minimum');
                      }
                      if (!RegExp(r'[A-Z]').hasMatch(value)) {
                        errors.add('one uppercase letter');
                      }
                      if (!RegExp(r'[0-9]').hasMatch(value)) {
                        errors.add('one number');
                      }
                      return errors.isEmpty
                          ? null
                          : 'Requires: ${errors.join(', ')}';
                    },
                  ),
                  if (errorMessage.isNotEmpty)
                    Text(
                      errorMessage,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.error,
                      ),
                    ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        child: FilledButton(
                          onPressed: _submit,
                          child: Text('Sign In'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Row(
              spacing: 10,
              children: [
                Expanded(child: Divider()),
                Text('or'),
                Expanded(child: Divider()),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 10,
              mainAxisSize: MainAxisSize.max,
              children: [
                FilledButton(onPressed: () {}, child: Text('Google')),
                FilledButton(onPressed: () {}, child: Text('Facebook')),
                FilledButton(onPressed: () {}, child: Text('X')),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
