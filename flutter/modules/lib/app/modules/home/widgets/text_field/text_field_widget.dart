import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextFieldWidget extends StatefulWidget {
  final String label;
  final String hint;
  final String initialValue;
  final bool readyOnly;
  final bool expands;
  final int maxLines;
  final Function onChanged;
  final Function validator;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final List<TextInputFormatter> inputFormatters;

  const TextFieldWidget(
      {@required this.label,
      @required this.hint,
      this.initialValue,
      this.readyOnly = false,
      this.expands = false,
      this.maxLines = 1,
      this.onChanged,
      this.validator,
      this.controller,
      this.keyboardType,
      this.inputFormatters})
      : assert(label != null),
        assert(hint != null);

  @override
  _TextFieldWidgetState createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  void initState() {
    super.initState();
    if (widget.controller != null) widget.controller.text = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).dividerColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: TextFormField(
        textAlignVertical: TextAlignVertical.top,
        textAlign: TextAlign.start,
        controller: widget.controller != null ? widget.controller : null,
        initialValue: widget.controller == null ? widget.initialValue : null,
        keyboardType: widget.keyboardType != null
            ? widget.keyboardType
            : TextInputType.text,
        inputFormatters:
            widget.inputFormatters != null ? widget.inputFormatters : [],
        onChanged: (value) => widget.onChanged(value),
        readOnly: widget.readyOnly,
        expands: widget.expands,
        maxLines: widget.expands ? null : widget.maxLines,
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.normal,
        ),
        validator:
            widget.validator != null ? (text) => widget.validator() : null,
        decoration: InputDecoration(
          alignLabelWithHint: true,
          contentPadding: new EdgeInsets.symmetric(
            vertical: 17,
            horizontal: 16,
          ),
          labelText: widget.label,
          hintText: widget.hint,
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
      ),
    );
  }
}
