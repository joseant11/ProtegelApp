import 'package:flutter/material.dart';
import 'package:protegelapp/screens/emergency_screen.dart';
import 'package:protegelapp/screens/settings_screen.dart';
import 'package:protegelapp/screens/empoderate_screen.dart';
import 'package:protegelapp/screens/agresiones_screens/fisica_screen.dart';



class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List tipoAgresion = [    'Fisica',    'Sexual',    'Psicologica',    'Economica',    'Digital',    'Verbal',  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff5C4DB1),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 50),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 50,
                    height: 50,
                    child: Image.asset('images/Logo.png'),
                  ),
                  SizedBox(width: 10),
                  Text(
                    'ProtegelApp',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1,
                      wordSpacing: 2,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Container(
              width: double.infinity,
              padding: EdgeInsets.only(top: 20, left: 15),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(40),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Padding(
                    padding: EdgeInsets.only(right: 15),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SettingsScreen(),
                          ),
                        );
                      },
                      child: Icon(
                        Icons.settings,
                        size: 30,
                      ),
                    ),
                  ),
                  Center(
                    child: Text(
                      'Protegete',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      InkWell(
                        onTap: () {
                          // Navigator.push(context, MaterialPageRoute(
                          //    builder: (context) => LoginScreen(),
                          //  )
                          // );
                        },
                        child: Container(
                            padding: EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: Color(0xffDFDEFF),
                              borderRadius: BorderRadius.circular(40),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  blurRadius: 6,
                                  spreadRadius: 4,
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  height: 60,
                                  width: 110,
                                  child: Image.asset('images/Reporta.png'),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  "Reporta",
                                  style: TextStyle(
                                   color: Colors.black,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            )),
                      ),
                      InkWell(
                        onTap: () {
                           Navigator.push(context, MaterialPageRoute(
                              builder: (context) => EmpoderateScreen(),
                            )
                           );
                        },
                        child: Container(
                            padding: EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: Color(0xffDFDEFF),
                              borderRadius: BorderRadius.circular(40),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  blurRadius: 6,
                                  spreadRadius: 4,
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  height: 60,
                                  width: 110,
                                  child: Image.asset('images/Empoderate.png'),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  "Empoderate",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                ),
                               ),
                            ],
                          )
                        ),
                      ),
                    ],
                  ),
              SizedBox(height: 25),
              Padding(
                padding: EdgeInsets.only(left: 0),
                child: Center(
                  child: Text(
                    'Selecciona el tipo de agresion',
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              GridView.count(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                childAspectRatio: 1.8,
                children: List.generate(tipoAgresion.length, (index) {
                  return InkWell(
                    onTap: () {
                      switch (index) {
                        case 0:
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => FisicaScreen(),
                            ),
                          );
                          break;
                         }
                      },
                    //     case 1:
                    //       Navigator.push(
                    //         context,
                    //         MaterialPageRoute(
                    //           builder: (context) => SexualScreen(),
                    //         ),
                    //       );
                    //       break;
                    //     case 2:
                    //       Navigator.push(
                    //         context,
                    //         MaterialPageRoute(
                    //           builder: (context) => PsicologicaScreen(),
                    //         ),
                    //       );
                    //       break;
                    //     case 3:
                    //       Navigator.push(
                    //         context,
                    //         MaterialPageRoute(
                    //           builder: (context) => EconomicaScreen(),
                    //         ),
                    //       );
                    //       break;
                    //     case 4:
                    //       Navigator.push(
                    //         context,
                    //         MaterialPageRoute(
                    //           builder: (context) => DigitalScreen(),
                    //         ),
                    //       );
                    //       break;
                    //     case 5:
                    //       Navigator.push(
                    //         context,
                    //         MaterialPageRoute(
                    //           builder: (context) => VerbalScreen(),
                    //         ),
                    //       );
                    //       break;

                    child: Container(
                      margin:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                      padding: EdgeInsets.symmetric(horizontal: 5),
                      decoration: BoxDecoration(
                        color: Color(0xff5C4DB1),
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            blurRadius: 4,
                            spreadRadius: 2,
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'images/Logo.png',
                            width: 50,
                            height: 50,
                          ),
                          SizedBox(height: 10),
                          Text(
                            tipoAgresion[index],
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              ),
            ],
          ),
        ),
        Container(
          height: MediaQuery.of(context).size.height/9.5,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(40),
              topRight: Radius.circular(40),
            ),
            color: Color(0xffDC4F89),
          ),
          child: InkWell(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(
                 builder: (context) => EmergencyScreen(),
               )
              );
            },
            child: Center(
              child: Text(
                'Emergencia!!!',
                style: TextStyle(
                  color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

                             
