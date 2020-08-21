import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AlertWidget extends StatefulWidget {
  final String title;
  final String text;
  final VoidCallback confirmCallback;
  final VoidCallback cancelCallback;

  const AlertWidget(
      {Key key,
      @required this.title,
      @required this.text,
      @required this.confirmCallback,
      @required this.cancelCallback})
      : super(key: key);

  @override
  _AlertWidgetState createState() => _AlertWidgetState();
}

class _AlertWidgetState extends State<AlertWidget> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.title),
      content: SingleChildScrollView(
        child: ListBody(
          children: [
            Text(widget.text),
          ],
        ),
      ),
      actions: [
        FlatButton(
          child: Text(
            'Cancelar',
            style: TextStyle(
              color: Colors.red,
            ),
          ),
          onPressed: widget.cancelCallback,
        ),
        FlatButton(
          child: Text(
            'Confirmar',
          ),
          onPressed: widget.confirmCallback,
        )
      ],
    );
  }
}
