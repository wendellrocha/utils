import 'package:flutter/material.dart';

class DropdownButtonWidget extends StatefulWidget {
  @override
  _DropdownButtonWidgetState createState() => _DropdownButtonWidgetState();
}

class _DropdownButtonWidgetState extends State<DropdownButtonWidget> {
  String _selected;

  final List<String> itens = ['cc_pf', 'cp_pf'];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: Theme.of(context).dividerColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: DropdownButton(
        icon: Icon(Icons.arrow_drop_down, color: Theme.of(context).splashColor),
        iconSize: 30,
        isExpanded: true,
        value: _selected,
        underline: SizedBox(),
        hint: Text(
          'Selecione a categoria',
          style: TextStyle(
            fontSize: 16,
          ),
        ),
        focusColor: Theme.of(context).primaryColor,
        onChanged: (String newValue) {
          setState(() {
            _selected = newValue;
          });
        },
        items: itens.map<DropdownMenuItem<String>>((item) {
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
