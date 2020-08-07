import 'package:flutter/material.dart';
import 'package:modules/app/modules/home/widgets/drawer/drawer_widget.dart';

class HomePage extends StatefulWidget {
  final String title;
  const HomePage({Key key, this.title = "Home"}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Theme.of(context).primaryColor,
          ),
        ),
        elevation: 0.0,
        backgroundColor: Theme.of(context).backgroundColor,
        bottom: PreferredSize(
          child: Container(
            color: Theme.of(context).dividerColor,
            height: 1.0,
          ),
          preferredSize: Size.fromHeight(1.0),
        ),
        iconTheme: IconThemeData(
          color: Theme.of(context).splashColor,
        ),
        centerTitle: true,
      ),
      body: Container(color: Colors.red),
      drawer: DrawerWidget(),
    );
  }
}
