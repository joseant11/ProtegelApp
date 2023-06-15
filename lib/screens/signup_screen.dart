import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:protegelapp/screens/login_screen.dart';

class SignupScreen extends StatefulWidget{
  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool passToggle = true;

  @override
  Widget build(BuildContext context) {
      return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              SizedBox(height: 10),
              Padding(
                padding: EdgeInsets.all(20), 
                child: SizedBox(
                  width: 150,
                  height: 150,
                  child: Image.asset('images/Logo.png'),
                  ),
                ),
                Text(
                  "Sign Up",
                  style: TextStyle(
                    color: Color(0xff5C4DB1),
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              SizedBox(height: 15),
              Padding(padding: EdgeInsets.symmetric(vertical: 8, horizontal:15 ), 
                child: TextField(
                  decoration: InputDecoration(
                    labelText: 'Name',
                    prefixIcon: Icon(Icons.person),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10),
              Padding(padding: EdgeInsets.all(12), 
                child: TextField(
                  decoration: InputDecoration(
                    labelText: 'Email',
                    prefixIcon: Icon(Icons.email),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10),
              Padding(padding: EdgeInsets.all(12), 
                child: TextField(
                  decoration: InputDecoration(
                    labelText: 'Phone Number',
                    prefixIcon: Icon(Icons.phone),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ),
              Padding(padding: EdgeInsets.all(12), 
              child: TextField(
                obscureText: passToggle ? true : false,
                decoration: InputDecoration(
                  labelText: 'Password',
                  prefixIcon: Icon(Icons.lock),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  suffixIcon: InkWell(
                    onTap: (){
                      if(passToggle == true){
                        passToggle = false;
                      }else {
                          passToggle = true;
                      }
                      setState(() {});
                    },
                    child: passToggle
                     ? Icon(CupertinoIcons.eye_slash_fill)
                     : Icon(CupertinoIcons.eye_fill),
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(10),
              child: SizedBox(
                width: double.infinity,
                child: Material(
                  color: Color(0xFF7165D6),
                  borderRadius: BorderRadius.circular(10),
                    child: InkWell(
                      onTap: () {
                        // Navigator.push(context, MaterialPageRoute(
                        //    builder: (context) => LoginScreen(),
                        //  ));
                      },
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 40),
                        child: Center(
                          child: Text(
                            'Create Account',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Already have an account?",
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) => LoginScreen(),
                      ));
                  },
                  child: Text(
                    'Log In',
                    style: TextStyle(
                      color: Color(0xFF7165D6),
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}