import 'package:flutter/material.dart';
import 'package:goaly/main.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Consumer<MyAppState>(builder:(context, state, child) {
        return Column(
        spacing: 20,
        children: [
          Center(
            child: Container(
              width: 69.2,
              height: 69.2,
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(shape: BoxShape.circle),
              child: Image.network(
                state.user.avatar,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Text(state.user.email),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.max,
            children: [
              Column(children: [Text('5'), Text('Goals Completed')]),
              Column(children: [Text('12'), Text('Day Streak')]),
              Column(children: [Text('90%'), Text('Success Rate')]),
            ],
          ),
          Expanded(
            child: ListView(
              children: [
                Text('Account'),
                ListTile(
                  title: Text('Edit Profile'),
                  trailing: Icon(Icons.arrow_forward_ios_sharp),
                  leading: Icon(Icons.person),
                ),
                ListTile(
                  title: Text('Change Password'),
                  trailing: Icon(Icons.arrow_forward_ios_sharp),
                  leading: Icon(Icons.lock),
                ),
                ListTile(
                  title: Text('Privacy Settings'),
                  trailing: Icon(Icons.arrow_forward_ios_sharp),
                  leading: Icon(Icons.privacy_tip),
                ),
                Text('Preferences'),
                ListTile(
                  title: Text('Notifications'),
                  trailing: Switch(value: false, onChanged: (value){}),
                  leading: Icon(Icons.notifications),
                ),
                ListTile(
                  title: Text('Dark Mode'),
                  trailing: Switch(value: false, onChanged: (value){}),
                  leading: Icon(Icons.dark_mode),
                ),
                ListTile(
                  title: Text('Language'),
                  subtitle: Text('English'),
                  trailing: Icon(Icons.arrow_forward_ios_sharp),
                  leading: Icon(Icons.language),
                ),
                Text('Support'),
                ListTile(
                  title: Text('Help Center'),
                  trailing: Icon(Icons.arrow_forward_ios_sharp),
                  leading: Icon(Icons.help),
                ),
                ListTile(
                  title: Text('Contact Support'),
                  trailing: Icon(Icons.arrow_forward_ios_sharp),
                  leading: Icon(Icons.support_agent),
                ),
                ListTile(
                  title: Text('Rate App'),
                  trailing: Icon(Icons.arrow_forward_ios_sharp),
                  leading: Icon(Icons.star),
                ),
                Text(''),
                ListTile(
                  title: Text('Sign Out'),
                  leading: Icon(Icons.logout),
                ),
              ],
            ),
          ),
        ],
      );
      },),
    );
  }
}
