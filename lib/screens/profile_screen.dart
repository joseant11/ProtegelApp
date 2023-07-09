import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  DateTime birthDate = new DateTime(2000);

  Widget _textInput(
      String inputLabel, String inputPlaceholder, Icon inputIcon) {
    return Container(
      margin: EdgeInsets.all(16),
      child: TextFormField(
        decoration: InputDecoration(
          icon: inputIcon,
          label: Text(inputLabel),
          labelStyle: new TextStyle(color: const Color(0xff5C4DB1)),
          hintText: inputPlaceholder,
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: const Color(0xff5C4DB1)),
          ),
        ),
      ),
    );
  }

  void _showDateTimePicker(BuildContext context) async {
    await showDatePicker(
      context: context,
      initialDate: birthDate,
      firstDate: DateTime(1930),
      lastDate: DateTime(2005),
    ).then(
      (value) => {
        if (value != null && value != birthDate)
          {
            setState(() {
              birthDate = value;
            })
          }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
        backgroundColor: Color(0xff5C4DB1),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 20),
                child: Column(
                  children: <Widget>[
                    CircleAvatar(
                      backgroundColor: Color(0xff5C4DB1),
                      radius: 110,
                      child: CircleAvatar(
                        backgroundImage: AssetImage('images/Profile.png'),
                        radius: 100,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 12),
                      child: Text(
                        "Kate",
                        style: TextStyle(
                          fontStyle: FontStyle.italic,
                          fontSize: 24,
                          color: Color(0xff5C4DB1),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              _textInput("Nombre", "Juan Clase",
                  Icon(Icons.person, color: Color(0xff5C4DB1))),
              _textInput("Email", "jclase@gmail.com",
                  Icon(Icons.email, color: Color(0xff5C4DB1))),
              Padding(
                padding: EdgeInsets.all(16),
                child: Row(
                  children: <Widget>[
                    Icon(Icons.calendar_today, color: Color(0xff5C4DB1)),
                    Container(
                      margin: EdgeInsets.only(left: 14),
                      child: TextButton(
                        child: Text(
                          "Select your birth date",
                          style: TextStyle(fontSize: 14),
                        ),
                        style: TextButton.styleFrom(
                          shape: StadiumBorder(),
                          padding: EdgeInsets.all(12),
                          foregroundColor: Colors.white,
                          backgroundColor: Color(0xff5C4DB1),
                        ),
                        onPressed: () {
                          _showDateTimePicker(context);
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 20),
                child: TextButton(
                  onPressed: () {},
                  child: Text(
                    "Save",
                    style: TextStyle(fontSize: 16),
                  ),
                  style: TextButton.styleFrom(
                    shape: StadiumBorder(),
                    padding: EdgeInsets.all(14),
                    foregroundColor: Colors.white,
                    backgroundColor: Color(0xff5C4DB1),
                  ),
                ),
              ),
              Text(birthDate.toString()),
            ],
          ),
        ),
      ),
    );
  }
}
