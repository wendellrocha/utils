import 'package:flutter/material.dart';

class DrawerWidget extends StatefulWidget {
  @override
  _DrawerWidgetState createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          UserAccountsDrawerHeader(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: (MediaQuery.of(context).platformBrightness ==
                        Brightness.dark)
                    ? AssetImage('assets/backgrounds/bg_chat_dark.png')
                    : AssetImage('assets/backgrounds/bg_chat_ligth.png'),
                fit: BoxFit.cover,
              ),
            ),
            accountName: Text(
              'Wendell R.',
              style: TextStyle(
                color: Theme.of(context).primaryColor,
              ),
            ),
            accountEmail: Text(
              'wendellrocha@outlook.com',
              style: TextStyle(
                color: Theme.of(context).primaryColor,
              ),
            ),
            currentAccountPicture: CircleAvatar(
              radius: 30.0,
              backgroundImage: NetworkImage(
                  'https://cdn.cloudflare.steamstatic.com/steamcommunity/public/images/avatars/32/32d1275f6fc8d8005ef40d54fab41135aaf2a82d_full.jpg'),
              backgroundColor: Colors.transparent,
            ),
          ),
          Expanded(
            child: ListView(
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              children: <Widget>[
                ListTile(
                  title: Text(
                    'Início',
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  leading: Icon(
                    Icons.home,
                    size: 20,
                    color: Color(0XFF68696A),
                  ),
                  onTap: () {
                    // Update the state of the app
                    // ...
                    // Then close the drawer
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  title: Text(
                    'Notificações',
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  leading: Icon(
                    Icons.notifications,
                    size: 20,
                    color: Color(0XFF68696A),
                  ),
                  onTap: () {
                    // Update the state of the app
                    // ...
                    // Then close the drawer
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  title: Text(
                    'Financeiro',
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  leading: Icon(
                    Icons.monetization_on,
                    size: 20,
                    color: Color(0XFF68696A),
                  ),
                  onTap: () {
                    // Update the state of the app
                    // ...
                    // Then close the drawer
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  title: Text(
                    'Dados cadastrais',
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  leading: Icon(
                    Icons.person,
                    size: 20,
                    color: Color(0XFF68696A),
                  ),
                  onTap: () {
                    // Update the state of the app
                    // ...
                    // Then close the drawer
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  title: Text(
                    'Campanhas',
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  leading: Icon(
                    Icons.access_alarm,
                    size: 20,
                    color: Color(0XFF68696A),
                  ),
                  onTap: () {
                    // Update the state of the app
                    // ...
                    // Then close the drawer
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  title: Text(
                    'Validadores',
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  leading: Icon(
                    Icons.person,
                    size: 20,
                    color: Color(0XFF68696A),
                  ),
                  onTap: () {
                    // Update the state of the app
                    // ...
                    // Then close the drawer
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  title: Text(
                    'Fale com o Psiu!',
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  leading: Icon(
                    Icons.email,
                    size: 15,
                    color: Color(0XFF68696A),
                  ),
                  onTap: () {
                    // Update the state of the app
                    // ...
                    // Then close the drawer
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  title: Text(
                    'Termos de privacidade',
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  leading: Icon(
                    Icons.picture_as_pdf,
                    size: 20,
                    color: Color(0XFF68696A),
                  ),
                  onTap: () {
                    // Update the state of the app
                    // ...
                    // Then close the drawer
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  title: Text(
                    'Ajuda',
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  leading: Icon(
                    Icons.info,
                    size: 20,
                    color: Color(0XFF68696A),
                  ),
                  onTap: () {
                    // Update the state of the app
                    // ...
                    // Then close the drawer
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  title: Text(
                    'Sair',
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  leading: Icon(
                    Icons.local_grocery_store,
                    size: 20,
                    color: Color(0XFF68696A),
                  ),
                  onTap: () {
                    // Update the state of the app
                    // ...
                    // Then close the drawer
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
