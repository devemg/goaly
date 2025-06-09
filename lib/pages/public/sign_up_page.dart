import 'package:flutter/material.dart';

class SignUpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              spacing: 10,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Begin your journey with',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Image.asset('assets/images/logo-alt.png', width: 150),
                SizedBox(height: 30),
                TextFormField(
                  // controller: newDescription,
                  decoration: InputDecoration(labelText: 'Name'),
                ),
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
                      child: FilledButton(
                        onPressed: () {},
                        child: Text('Sign Up'),
                      ),
                    ),
                  ],
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
            Wrap(
              spacing: 3,
              children: [
                Text('By using this app, you agree to our '),
                Text('Terms of Use', style: TextStyle(fontWeight: FontWeight.bold),),
                Text('and'),
                Text('Primvacy Policy.',style: TextStyle(fontWeight: FontWeight.bold),),
              ],
            )
          ],
        ),
      ),
    );
  }
}
