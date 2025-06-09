import 'package:flutter/material.dart';

class SignInPage extends StatelessWidget {
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
            Image.asset('assets/images/logo-alt.png', width: 150,),
            SizedBox(height: 30,),
            TextFormField(
              // controller: newDescription,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextFormField(
              // controller: newDescription,
              decoration: InputDecoration(labelText: 'Password'),
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: FilledButton(onPressed: () {}, child: Text('Sign In')),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 10,
              children: [Text('Dont have an account?'), Text('Sign Up')],
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
            )
          ],
        ),
      ),
    );
  }
}
