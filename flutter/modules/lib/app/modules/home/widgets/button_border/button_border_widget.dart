import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ButtonBorderWidget extends StatefulWidget {
  final String text;
  final Function callback;
  final Color color;
  final bool showProgress;

  ButtonBorderWidget(this.text, this.callback,
      {this.showProgress = false, this.color});

  @override
  _ButtonBorderWidgetState createState() => _ButtonBorderWidgetState();
}

class _ButtonBorderWidgetState extends State<ButtonBorderWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 50,
      child: RaisedButton(
        elevation: 0.0,
        color: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6),
          side: BorderSide(
            width: 2.0,
            color: widget.color != null
                ? widget.color
                : Theme.of(context).primaryColor,
          ),
        ),
        child: widget.showProgress
            ? Center(
                child: CupertinoActivityIndicator(
                  animating: true,
                ),
              )
            : Text(
                widget.text,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: widget.color != null
                      ? widget.color
                      : Theme.of(context).primaryColor,
                ),
              ),
        onPressed: !widget.showProgress ? widget.callback : () {},
      ),
    );
  }
}
