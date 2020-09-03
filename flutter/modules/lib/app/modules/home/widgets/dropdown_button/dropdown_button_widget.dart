import 'package:flutter/material.dart';

class DropdownButtonWidget extends StatefulWidget {
  final String label;
  final List itens;
  final Function onChanged;

  const DropdownButtonWidget({Key key, this.label, this.itens, this.onChanged})
      : super(key: key);
  @override
  _DropdownButtonWidgetState createState() => _DropdownButtonWidgetState();
}

class _DropdownButtonWidgetState extends State<DropdownButtonWidget> {
  String _selected;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: Theme.of(context).dividerColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: DropdownButton(
        icon: Icon(
          Icons.arrow_drop_down,
          color: Theme.of(context).splashColor,
        ),
        iconSize: 30,
        isExpanded: true,
        value: _selected,
        underline: SizedBox(),
        hint: Text(
          widget.label,
          style: TextStyle(
            color: Theme.of(context).primaryColor,
            fontSize: 14,
          ),
        ),
        focusColor: Theme.of(context).primaryColor,
        onChanged: (String newValue) {
          setState(() => _selected = newValue);
          widget.onChanged(newValue);
        },
        items: widget.itens.map<DropdownMenuItem<String>>((item) {
          return DropdownMenuItem<String>(
            child: new Text(
              item,
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            value: item,
          );
        }).toList(),
      ),
    );
  }
}
