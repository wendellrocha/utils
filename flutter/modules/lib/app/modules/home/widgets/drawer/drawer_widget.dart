import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

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
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: (MediaQuery.of(context).platformBrightness ==
                        Brightness.dark)
                    ? AssetImage('assets/backgrounds/bg_chat_dark.png')
                    : AssetImage('assets/backgrounds/bg_chat_ligth.png'),
                fit: BoxFit.cover,
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: UserAccountsDrawerHeader(
                    decoration: BoxDecoration(color: Colors.transparent),
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
                    currentAccountPicture: GestureDetector(
                      onTap: () {
                        Modular.to.pushNamed('/perfil');
                      },
                      child: CircleAvatar(
                        radius: 30.0,
                        backgroundImage: NetworkImage('url'),
                        backgroundColor: Colors.transparent,
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(16),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(100),
                    radius: 100,
                    onTap: () {
                      Navigator.pop(context);
                      Modular.to.pushNamed('/perfil');
                    },
                    child: Icon(
                      Icons.arrow_forward_ios,
                      color: Theme.of(context).splashColor,
                      size: 14,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              children: <Widget>[
                ListTile(
                  title: Text(
                    'Notificações',
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  leading: Icon(
                    Icons.ac_unit,
                    size: 20,
                    color: Color(0XFF68696A),
                  ),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    size: 14,
                    color: Color(0XFF68696A),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    Modular.to.pushNamed('/notificacoes');
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
                    Icons.ac_unit,
                    size: 20,
                    color: Color(0XFF68696A),
                  ),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    size: 14,
                    color: Color(0XFF68696A),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    Modular.to.pushNamed('/financeiro');
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
                    Icons.ac_unit,
                    size: 20,
                    color: Color(0XFF68696A),
                  ),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    size: 14,
                    color: Color(0XFF68696A),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    Modular.to.pushNamed('/dados-cadastrais');
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
                    Icons.ac_unit,
                    size: 20,
                    color: Color(0XFF68696A),
                  ),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    size: 14,
                    color: Color(0XFF68696A),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    Modular.to.pushNamed('/campanhas');
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
                    Icons.ac_unit,
                    size: 20,
                    color: Color(0XFF68696A),
                  ),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    size: 14,
                    color: Color(0XFF68696A),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    Modular.to.pushNamed('/validadores');
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
                    Icons.ac_unit,
                    size: 15,
                    color: Color(0XFF68696A),
                  ),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    size: 14,
                    color: Color(0XFF68696A),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    Modular.to.pushNamed('/contato');
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
                    Icons.ac_unit,
                    size: 20,
                    color: Color(0XFF68696A),
                  ),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    size: 14,
                    color: Color(0XFF68696A),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    Modular.to.pushNamed('/termos');
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
                    Icons.ac_unit,
                    size: 20,
                    color: Color(0XFF68696A),
                  ),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    size: 14,
                    color: Color(0XFF68696A),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    Modular.to.pushNamed('/ajuda');
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
                    Icons.ac_unit,
                    size: 20,
                    color: Color(0XFF68696A),
                  ),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    size: 14,
                    color: Color(0XFF68696A),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    Modular.to.pushReplacementNamed('/acesso');
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
