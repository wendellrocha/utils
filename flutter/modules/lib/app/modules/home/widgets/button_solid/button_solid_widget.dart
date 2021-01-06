import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ButtonSolidWidget extends StatelessWidget {
  final String text;
  final Function callback;
  final bool showProgress;
  final Color color;

  ButtonSolidWidget(this.text, this.callback,
      {this.showProgress = false, this.color});

  @override
  Widget build(BuildContext context) {
    final textColor = Colors.white;

    return Container(
      width: MediaQuery.of(context).size.width,
      height: 50,
      child: RaisedButton(
        elevation: 0.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6),
        ),
        color: color != null ? color : Theme.of(context).splashColor,
        child: showProgress
            ? Center(
                child: CupertinoActivityIndicator(
                  animating: true,
                ),
              )
            : Text(
                text,
                style: TextStyle(
                  fontSize: 15,
                  color: textColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
        onPressed: !showProgress ? callback : () {},
      ),
    );
  }
}
