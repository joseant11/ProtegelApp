import 'package:flutter/material.dart';
import 'package:protegelapp/screens/settings_screens/aboutus_screen.dart';
import 'package:get/get.dart';
import 'package:protegelapp/screens/repository/authentication_repository/authentication_repository.dart';
import 'package:protegelapp/screens/welcome_screen.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff5C4DB1),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(0xff5C4DB1),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: MediaQuery.of(context).size.height,
          ),
          child: IntrinsicHeight(
            child: Column(
              children: [
                SizedBox(height: 0),
                _buildProfileHeader(),
                SizedBox(height: 20),
                Expanded(
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.only(top: 20, left: 15),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40),
                      ),
                    ),
                    child: _buildSettingsList(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Column(
      children: [
        Stack(
          children: [
            Container(
              height: 100,
              width: 100,
              child: Image.asset(('images/Template.png')),
            ),
            Positioned(
              top: 13,
              left: 18,
              child: CircleAvatar(
                radius: 33,
                backgroundImage: AssetImage('images/Profile.png'),
              ),
            ),
          ],
        ),
        SizedBox(height: 10),
        Text(
          'Hi! Kate,\nWelcome Back',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
            letterSpacing: 1,
            wordSpacing: 2,
          ),
        ),
      ],
    );
  }

  Widget _buildSettingsList() {
    return Column(
      children: [
        _buildSettingsListItem(
          icon: Icons.person,
          title: 'Profile',
          onTap: () {
            // Navegar a la pantalla de perfil
          },
        ),
        SizedBox(height: 20),
        _buildSettingsListItem(
          icon: Icons.notifications_none_rounded,
          title: 'Notifications',
          onTap: () {
            // Navegar a la pantalla de notificaciones
          },
        ),
        SizedBox(height: 20),
        _buildSettingsListItem(
          icon: Icons.privacy_tip_rounded,
          title: 'Privacy',
          onTap: () {
            // Navegar a la pantalla de privacidad
          },
        ),
        SizedBox(height: 20),
        _buildSettingsListItem(
          icon: Icons.settings_outlined,
          title: 'General',
          onTap: () {
            // Navegar a la pantalla de configuración general
          },
        ),
        SizedBox(height: 20),
        _buildSettingsListItem(
          icon: Icons.info_outline_rounded,
          title: 'About Us',
          onTap: () {
            // Navegar a la pantalla "Sobre nosotros"
          },
        ),
        Divider(height: 40),
        _buildSettingsListItem(
          icon: Icons.logout,
          title: 'Log Out',
          onTap: () {
            AuthenticationRepository.instance.logout();
            // Get.to(() => const WelcomeScreen());
          },
        ),
      ],
    );
  }

  Widget _buildSettingsListItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Color(0xff5C4DB1),
          shape: BoxShape.circle,
        ),
        child: Icon(
          icon,
          color: Colors.white,
          size: 35,
        ),
      ),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w500,
        ),
      ),
      trailing: Icon(
        Icons.arrow_forward_ios_rounded,
        size: 20,
      ),
      onTap: onTap,
    );
  }
}
