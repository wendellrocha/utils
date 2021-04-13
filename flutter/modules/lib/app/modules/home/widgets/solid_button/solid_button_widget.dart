import 'package:app_claudio_flutter/app/shared/theme/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SolidButtonWidget extends StatelessWidget {
  final String title;
  final Color color;
  final Function callback;
  final bool showProgress;
  final double fontSize;

  const SolidButtonWidget(
      {Key key,
      this.title,
      this.color,
      this.callback,
      this.showProgress = false,
      this.fontSize = 16})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).accentColor,
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
      ),
      width: MediaQuery.of(context).size.width,
      height: 55,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          primary:
              this.color != null ? this.color : Theme.of(context).accentColor,
          backgroundColor: ThemeColor.accentColor,
          minimumSize: Size(88, 36),
          padding: EdgeInsets.all(0),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(20),
            ),
          ),
        ),
        child: this.showProgress
            ? Center(
                child: CupertinoActivityIndicator(
                  animating: true,
                ),
              )
            : Center(
                child: Text(
                  this.title,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: this.fontSize,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
        onPressed: !this.showProgress ? this.callback : () {},
      ),
    );
  }
}
