import 'package:flutter/material.dart';

class DropdownWidget extends StatefulWidget {
  final List<String> content;
  final String hintText;
  final Function onChanged;
  final String selected;

  const DropdownWidget(
      {Key key,
      @required this.hintText,
      @required this.onChanged,
      @required this.content,
      this.selected})
      : super(key: key);
  @override
  _DropdownWidgetState createState() => _DropdownWidgetState();
}

class _DropdownWidgetState extends State<DropdownWidget> {
  var _selected;
  var _item;

  @override
  void initState() {
    super.initState();
    print(widget.selected);
    _selected = widget.selected;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
          border: Border.all(
            color: Theme.of(context).dividerColor,
            width: 0.5,
          ),
        ),
        height: 60,
        child: Center(
          child: DropdownButton(
            icon: Icon(
              Icons.arrow_drop_down,
              color: Theme.of(context).accentColor,
            ),
            iconSize: 30,
            isExpanded: true,
            value: _selected,
            underline: SizedBox(),
            hint: Text(
              widget.hintText != null ? widget.hintText : 'Pick',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            onChanged: (newValue) {
              FocusScope.of(context).unfocus();
              setState(() {
                _selected = newValue;
                _item =
                    widget.content.firstWhere((element) => element == newValue);
              });
              widget.onChanged(_item);
            },
            items: widget.content.map((value) {
              return DropdownMenuItem(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
