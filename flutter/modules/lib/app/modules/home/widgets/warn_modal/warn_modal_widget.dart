import 'package:app_claudio_flutter/app/shared/widgets/border_button/border_button_widget.dart';
import 'package:flutter/material.dart';

class WarnModalWidget extends StatelessWidget {
  final String title;
  final String text;
  final String assetImage;

  const WarnModalWidget(
      {Key key,
      @required this.title,
      @required this.text,
      this.assetImage = 'assets/images/warn.png'})
      : assert(title != null, 'Title must not be null'),
        assert(text != null, 'Text must not be null'),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Container(
        height: 500.0,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: <Widget>[
            Expanded(
              child: ListView(
                cacheExtent: double.maxFinite,
                children: <Widget>[
                  SizedBox(height: 8),
                  Stack(
                    children: <Widget>[
                      Align(
                        alignment: Alignment.topCenter,
                        child: Container(
                          height: 250,
                          width: 250,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(this.assetImage),
                                fit: BoxFit.fill),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.topRight,
                        child: IconButton(
                            color: Colors.black,
                            iconSize: 32,
                            icon: Icon(Icons.close),
                            onPressed: () {
                              Navigator.pop(context);
                            }),
                      )
                    ],
                  ),
                  SizedBox(height: 8),
                  Text(
                    this.title,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 21,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      this.text,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 18,
                        height: 1.5,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            ClipRRect(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(15.0),
                bottomRight: Radius.circular(15.0),
              ),
              child: Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(
                      width: 0.5,
                      color: Theme.of(context).dividerColor,
                    ),
                  ),
                ),
                child: BorderButtonWidget(
                  title: 'FECHAR',
                  callback: () => Navigator.pop(context),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
