import 'dart:async';

import 'package:flutter/material.dart';

const int aSec = 1;

const String secPostFix = 's';
const String labelSplitter = "|";

class ButtonTimerWidget extends StatefulWidget {
  final String label;
  final int timeout;
  final Color color;
  final Color disabledColor;
  final TextStyle activeText;
  final TextStyle disabledText;
  final VoidCallback onPressed;
  final String toastMessage;

  const ButtonTimerWidget({
    Key key,
    @required this.label,
    @required this.timeout,
    @required this.onPressed,
    this.color,
    this.disabledColor,
    this.activeText,
    this.disabledText,
    @required this.toastMessage,
  }) : super(key: key);

  @override
  _ButtonTimerWidgetState createState() => _ButtonTimerWidgetState();
}

class _ButtonTimerWidgetState extends State<ButtonTimerWidget> {
  bool timeUpFlag = false;
  int timer = 0;

  String get _timerText => '$timer$secPostFix';

  @override
  void initState() {
    super.initState();
    timer = widget.timeout;
    _timerUpdate();
  }

  _timerUpdate() {
    Timer(const Duration(seconds: aSec), () async {
      if (this.mounted) {
        setState(() {
          timer--;
        });
      }
      if (timer != 0)
        _timerUpdate();
      else
        timeUpFlag = true;
    });
  }

  Widget _buildChild() {
    return timeUpFlag
        ? Text(
            widget.label,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: widget.color != null
                  ? widget.color
                  : Theme.of(context).splashColor,
            ),
          )
        : Text(
            '${widget.label} $labelSplitter $_timerText',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: widget.color != null
                  ? widget.color
                  : Theme.of(context).dividerColor,
            ),
          );
  }

  _onPressed() {
    if (timeUpFlag) if (widget.onPressed != null) widget.onPressed();
    timer = widget.timeout;
    timeUpFlag = false;
    _timerUpdate();
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text(widget.toastMessage),
    ));
  }

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
            color: timeUpFlag
                ? Theme.of(context).splashColor
                : Theme.of(context).dividerColor,
          ),
        ),
        child: _buildChild(),
        onPressed: _onPressed,
      ),
    );
  }
}
