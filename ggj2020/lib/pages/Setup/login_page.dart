import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ggj2020/elements/social_button.dart';
import 'package:ggj2020/pages/Setup/emailSignInCard.dart';
import 'package:ggj2020/sidebar/sideBarLayout.dart';
import 'package:provider/provider.dart';
//import 'package:ggj2020/ThemeHandler.dart';

class LoginPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    checkSignedIn();
  }

  Future<void> checkSignedIn() async {
    FirebaseAuth result = FirebaseAuth.instance;
    FirebaseUser user = await result.currentUser();
    if(user != null){
      isLoading = false;
      Navigator.of(context).pop();
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SideBarLayout(user: user,)));
    } else {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return _loginBody(context);
  }

  Widget _loginBody(BuildContext context){
    if(isLoading){
      return Center(
        child: Container(
          width: 50, height: 50,
          child: Card(
            child: CircularProgressIndicator(
              strokeWidth: 5,
            ),
          ),
        ),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          title: Text('Sign in'),
        ),
        body: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              SizedBox(
                height: 50.0,
                //child: _buildHeader(),
              ),
              SizedBox(height: 48.0),
              SocialButton(
                  imageDirectory: 'images/google-logo.png',
                  text: 'Sign in with Google',
                  textColor: Colors.black87,
                  color: Colors.white,
                  onPressed: (){} //isLoading ? null : () => _signInWithGoogle(context),
              ),
              SizedBox(height: 8.0),
              SocialButton(
                  imageDirectory: 'images/facebook-logo.png',
                  text: 'Sign in with Facebook',
                  textColor: Colors.white,
                  color: Color(0xFF334D92),
                  onPressed: (){} // isLoading ? null : () => _signInWithFacebook(context),
              ),
              SizedBox(height: 8.0),
              SocialButton(
                  icon: Icons.email,
                  text: 'Sign in with email',
                  textColor: Colors.white,
                  color: Colors.teal[700],
                  onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => EmailSignInCard(), fullscreenDialog: true)) // isLoading ? null : () => _signInWithEmail(context),
              ),
              SizedBox(height: 8.0),
              Text(
                'or',
                style: TextStyle(fontSize: 14.0, color: Colors.black87),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 8.0),
              SocialButton(
                icon: Icons.person_outline,
                text: 'Go anonymous',
                textColor: Colors.black,
                color: Colors.lime[300],
                onPressed: () => _signInAnonymously(context), // isLoading ? null : () => _signInAnonymously(context),
              ),
            ],
          ),
        ),
      );
    }
  }

  Future<void> _signInAnonymously(BuildContext context) async {
    try {
      setState(() {
        isLoading = true;
      });
      AuthResult result = await FirebaseAuth.instance.signInAnonymously();
      FirebaseUser user = result.user;
      //user.sendEmailVerification();
      //Display for the user that we sent an email.
      setState(() {
        isLoading = false;
      });
      Navigator.of(context).pop();
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SideBarLayout(user: user,)));
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print(e.message);
    }
  }
}

