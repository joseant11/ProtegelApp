import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutUsScreen extends StatelessWidget {
  final List<Map<String, dynamic>> teamMembers = [
    {
      'name': 'Jose Rosa',
      'role': 'Developer',
      'image': 'images/banner.png',
      'githubUrl': 'https://github.com/joseant11/',
    },
    {
      'name': 'Alexis',
      'role': 'Designer',
      'image': 'images/banner.png',
      'githubUrl': 'https://github.com/example2/',
    },
    {
      'name': 'Leo',
      'role': 'Backend',
      'image': 'images/banner.png',
      'githubUrl': 'https://github.com/example3/',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(0xff5C4DB1),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 230,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(50),
                ),
                color: Color(0xff5C4DB1),
              ),
              child: Stack(
                children: [
                  Positioned(
                    top: 50,
                    left: 0,
                    child: Container(
                      height: 100,
                      width: 300,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(50),
                          bottomRight: Radius.circular(50),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 80,
                    left: 20,
                    child: Text(
                      "About Us",
                      style: TextStyle(
                        fontSize: 30,
                        color: Color(0xff5C4DB1),
                      ),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.05),
            Container(
              height: 250,
              child: PageView.builder(
                itemCount: teamMembers.length,
                itemBuilder: (context, index) {
                  return buildTeamMemberCard(context, teamMembers[index]);
                },
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 10, top: 15),
              height: MediaQuery.of(context).size.height *
                  (MediaQuery.of(context).orientation == Orientation.portrait
                      ? 0.23
                      : 0.43),
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.only(left: 20, right: 20, bottom: 20),
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0xff5C4DB1),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(80.0),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0xff363f93).withOpacity(0.3),
                      offset: Offset(-10.0, 0.0),
                      blurRadius: 20.0,
                      spreadRadius: 4.0,
                    ),
                  ],
                ),
                padding: EdgeInsets.only(left: 32, top: 50.0, bottom: 50),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "ProtegelApp",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      "Lorem Ipsum is simply dummy text.",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildTeamMemberCard(
      BuildContext context, Map<String, dynamic> teamMember) {
    final double width = MediaQuery.of(context).size.width;

    return Stack(
      children: [
        Positioned(
          top: 35,
          left: 20,
          child: Material(
            child: Container(
              height: 180.0,
              width: width * 0.9,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(0.8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    offset: new Offset(-10.0, 10.0),
                    blurRadius: 20.0,
                    spreadRadius: 4.0,
                  )
                ],
              ),
            ),
          ),
        ),
        Positioned(
          top: 0,
          left: 30,
          child: Card(
            color: Color(0xff5C4DB1),
            elevation: 10.0,
            shadowColor: Color(0xff5C4DB1).withOpacity(0.5),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: Container(
              height: 200,
              width: 150,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: AssetImage(teamMember['image']),
                ),
              ),
            ),
          ),
        ),
        Positioned(
          top: 60,
          left: 200,
          child: Container(
            height: 150,
            width: 160,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  teamMember['name'],
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff5C4DB1),
                  ),
                ),
                Text(
                  teamMember['role'],
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                  ),
                ),
                Divider(color: Colors.black),
                TextButton(
                  onPressed: () {
                    launch(teamMember['githubUrl']);
                  },
                  child: Text(
                    'Github',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
