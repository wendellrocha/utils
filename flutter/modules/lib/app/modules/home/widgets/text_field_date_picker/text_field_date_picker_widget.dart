import 'package:flutter/material.dart';

class TextFieldDatePickerWidget extends StatefulWidget {
  final String title;
  final String hint;
  final TextEditingController controller;
  final double fontSize;
  final Color textColor;
  final DateTime firstDate;
  final DateTime lastDate;
  final Function theme;

  const TextFieldDatePickerWidget({
    Key key,
    @required this.title,
    @required this.hint,
    @required this.controller,
    this.fontSize,
    this.textColor,
    this.firstDate,
    this.lastDate,
    this.theme,
  }) : super(key: key);

  @override
  _TextFieldDatePickerWidgetState createState() =>
      _TextFieldDatePickerWidgetState();
}

class _TextFieldDatePickerWidgetState extends State<TextFieldDatePickerWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
          color: Colors.black.withOpacity(0.0),
        ),
        height: 60,
        child: TextField(
          onTap: () {
            FocusScope.of(context).unfocus();
            datePicker(context);
          },
          controller: widget.controller,
          textAlignVertical: TextAlignVertical.top,
          textAlign: TextAlign.start,
          style: TextStyle(color: Colors.black),
          decoration: InputDecoration(
            alignLabelWithHint: true,
            fillColor: Colors.white,
            hoverColor: Colors.white,
            focusColor: Colors.white,
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Theme.of(context).dividerColor,
                width: 0.5,
              ),
              borderRadius: BorderRadius.all(
                Radius.circular(20),
              ),
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide(
                color: Theme.of(context).dividerColor,
                width: 0.5,
              ),
              borderRadius: BorderRadius.all(
                Radius.circular(20),
              ),
            ),
            labelText: widget.title,
            hintText: widget.hint,
            labelStyle: TextStyle(
              fontSize: widget.fontSize,
              color: widget.textColor,
            ),
          ),
        ),
      ),
    );
  }

  Future<void> datePicker(_) async {
    final DateTimeRange picked = await showDateRangePicker(
      context: _,
      firstDate: widget.firstDate ?? DateTime(1920),
      lastDate: widget.lastDate ?? DateTime(2100),
      builder: widget.theme ??
          (BuildContext context, Widget child) {
            return Theme(
              data: ThemeData(
                buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.accent),
                accentColor: Theme.of(context).accentColor,
                primaryColor: Theme.of(context).primaryColor,
              ),
              child: child,
            );
          },
    );
    if (picked != null) {
      setState(() {
        widget.controller.text = '${picked.start} - ${picked.end}';
      });
    }
  }
}
