import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class InputDateWidget extends StatelessWidget {
  final String label;
  final String hint;
  final Function callback;

  InputDateWidget(this.label, this.hint, this.callback);

  final format = DateFormat("dd/MM/yyyy");
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).dividerColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: DateTimeField(
        decoration: InputDecoration(
          contentPadding: new EdgeInsets.symmetric(
            vertical: 17,
            horizontal: 16,
          ),
          labelText: this.label,
          hintText: this.hint,
          labelStyle: TextStyle(
            color: Theme.of(context).primaryColor,
            fontSize: 16,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
              color: Theme.of(context).primaryColor,
              width: 1,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
              color: Theme.of(context).dividerColor,
              width: 1,
            ),
          ),
        ),
        format: format,
        initialValue: DateTime.now(),
        onChanged: (value) => this.callback(value),
        onShowPicker: (context, currentValue) {
          return showDatePicker(
              context: context,
              firstDate: DateTime(DateTime.now().year),
              initialDate: currentValue ?? DateTime.now(),
              lastDate: DateTime(DateTime.now().year + 2));
        },
      ),
    );
  }
}
