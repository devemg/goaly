import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        spacing: 20,
        children: [
          Center(
            child: Container(
              width: 69.2,
              height: 69.2,
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(shape: BoxShape.circle),
              child: Image.network(
                'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w0NTYyMDF8MHwxfHNlYXJjaHw0fHx1c2VyfGVufDB8fHx8MTc0ODk5OTI3N3ww&ixlib=rb-4.1.0&q=80&w=1080',
                fit: BoxFit.cover,
              ),
            ),
          ),
          Text('john@example.com'),
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
      ),
    );
  }
}
