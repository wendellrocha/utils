import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BorderButtonWidget extends StatelessWidget {
  final String title;
  final Color color;
  final Function callback;
  final bool showProgress;

  const BorderButtonWidget(
      {Key key,
      this.title,
      this.color,
      this.callback,
      this.showProgress = false})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.transparent,
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
          minimumSize: Size(88, 36),
          padding: EdgeInsets.all(0),
          side: BorderSide(color: Theme.of(context).accentColor),
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
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
        onPressed: !this.showProgress ? this.callback : () {},
      ),
    );
  }
}
