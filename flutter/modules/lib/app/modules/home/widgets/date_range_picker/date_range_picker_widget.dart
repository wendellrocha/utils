import 'package:flutter/material.dart';

class DateRangePickerWidget extends StatefulWidget {
  @override
  _DateRangePickerWidgetState createState() => _DateRangePickerWidgetState();
}

class _DateRangePickerWidgetState extends State<DateRangePickerWidget> {
  DateTime _inicio;
  DateTime _fim;
  DateTime initialDate = DateTime(1920);
  DateTime lastDate = DateTime(2100);

  Future<void> _selectDate(BuildContext context) async {
    final DateTimeRange picked = await showDateRangePicker(
      context: context,
      firstDate: initialDate,
      lastDate: lastDate,
      builder: (BuildContext context, Widget child) {
        return Theme(
          data: ThemeData(
            colorScheme:
                (MediaQuery.of(context).platformBrightness == Brightness.dark)
                    ? ColorScheme.dark().copyWith(
                        primary: Colors.white,
                        onPrimary: Theme.of(context).splashColor,
                        surface: Theme.of(context).splashColor,
                        onSurface: Colors.white,
                      )
                    : ColorScheme.light().copyWith(
                        primary: Color(0XFF363738),
                        onPrimary: Theme.of(context).splashColor,
                        surface: Theme.of(context).splashColor,
                        onSurface: Color(0XFF363738),
                      ),
          ),
          child: child,
        );
      },
    );
    if (picked != null)
      setState(() {
        _inicio = picked.start;
        _fim = picked.end;
      });
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        Text("$_inicio - $_fim"),
        SizedBox(
          height: 20.0,
        ),
        RaisedButton(
          onPressed: () => _selectDate(context),
          child: Text('Select date'),
        ),
      ],
    );
  }
}
