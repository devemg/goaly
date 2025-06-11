import 'package:flutter/material.dart';
import 'package:goaly/pages/public/sign_in_page.dart';
import 'package:goaly/pages/public/sign_up_page.dart';

class RootPublicPage extends StatelessWidget {

  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,      
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.end,
          mainAxisSize: MainAxisSize.max,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Image.asset('assets/images/logo.png', width: 300)
              ],
            ),
            SizedBox(height: 150,),
            Text('Turn your weekly goals into real achievements—more productivity, fewer excuses. With Goaly, every week is a win!',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Theme.of(context).colorScheme.primaryContainer,
              fontSize: 16,
              fontWeight: FontWeight.w500,
              
            ),),
            SizedBox(height: 100,),
            Row(
              spacing: 10,
              children: [
                Expanded(child: ElevatedButton(onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> SignInPage()));
                }, child: Text('Sign In'))),
                Expanded(child: ElevatedButton(onPressed: (){
                   Navigator.push(context, MaterialPageRoute(builder: (context)=> SignUpPage()));
                }, child: Text('Sign Up')))
              ],
            )
          ],
        )),
    );
  }
}