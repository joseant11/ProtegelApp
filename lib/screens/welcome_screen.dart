import 'package:flutter/material.dart';
import 'package:protegelapp/screens/home_screen.dart';
import 'package:protegelapp/screens/login_screen.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff5C4DB1),
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          padding: EdgeInsets.all(10),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 10),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HomeScreen(),
                          ));
                    },
                    child: Text(
                      'Skip',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 40),
                Padding(
                  padding: EdgeInsets.all(20),
                  child: SizedBox(
                    width: 200,
                    height: 200,
                    child: Image.asset('images/Logo.png'),
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'ProtegelApp',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1,
                    wordSpacing: 2,
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  'El amor no duele: denuncia y\n busca ayuda.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 60),
                Stack(
                  children: [
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: SizedBox(
                        width: 300,
                        height: 300,
                        child: Image.asset('images/banner.png'),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Padding(
                        padding: EdgeInsets.all(16.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            bottomRight: Radius.circular(20),
                          ),
                          child: Material(
                            color: Colors.white,
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => LoginScreen(),
                                  ),
                                );
                              },
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 15, horizontal: 40),
                                child: Text(
                                  'Log In',
                                  style: TextStyle(
                                    color: Color(0xff5C4DB1),
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
