import 'package:flutter/material.dart';

class TextFieldWidget extends StatefulWidget {
  final Key key;
  final TextEditingController controller;
  final String title;
  final String hint;
  final bool expands;
  final int maxLines;
  final Color containerColor;
  final Color iconColor;
  final IconData icon;
  final TextAlign align;
  final TextInputType inputType;
  final bool isPassword;
  final bool isSearch;
  final double opacity;
  final Color textColor;
  final Function onChanged;
  final Function callbackSearch;
  final double fontSize;
  final bool readyOnly;
  const TextFieldWidget({
    this.key,
    @required this.controller,
    @required this.title,
    this.hint,
    this.maxLines = 1,
    this.expands = false,
    this.icon,
    this.align,
    this.inputType = TextInputType.text,
    this.isPassword = false,
    this.isSearch = false,
    this.opacity = 0.5,
    this.containerColor = Colors.black,
    this.iconColor = Colors.white,
    this.textColor = Colors.white,
    this.onChanged,
    this.callbackSearch,
    this.fontSize = 16,
    this.readyOnly = false,
  })  : assert(controller != null, 'Controller must not be null'),
        assert(title != null, 'Title must not be null'),
        super(key: key);

  @override
  _TextFieldWidgetState createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  bool isVisible = false;
  bool isNotEmpty = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
          color: widget.containerColor.withOpacity(widget.opacity),
        ),
        height: 60,
        child: TextField(
          textAlignVertical: TextAlignVertical.top,
          textAlign: TextAlign.start,
          keyboardType: widget.inputType,
          obscureText: widget.isPassword ? !isVisible : false,
          readOnly: widget.readyOnly,
          controller: widget.controller,
          cursorColor: widget.textColor,
          expands: widget.expands,
          maxLines: widget.expands ? null : widget.maxLines,
          style: TextStyle(color: widget.textColor),
          onChanged: (String value) => _onChanged(value),
          decoration: InputDecoration(
            alignLabelWithHint: true,
            fillColor: Colors.white,
            hoverColor: Colors.white,
            focusColor: Colors.white,
            suffixIcon: widget.isPassword
                ? IconButton(
                    icon: Icon(
                      isVisible ? Icons.visibility : Icons.visibility_off,
                      color: widget.textColor,
                    ),
                    onPressed: () => _toggle(),
                  )
                : widget.isSearch
                    ? IconButton(
                        icon: Icon(
                          isNotEmpty ? Icons.clear : Icons.search,
                          color: widget.iconColor,
                        ),
                        onPressed: () => _searchCalllback(),
                      )
                    : widget.icon != null
                        ? Icon(widget.icon, color: widget.iconColor)
                        : null,
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

  _toggle() {
    setState(() {
      if (!mounted) return;
      setState(() {
        isVisible = !isVisible;
      });
    });
  }

  _searchCalllback() {
    setState(() {
      widget.controller.clear();
      widget.callbackSearch();
      isNotEmpty = false;
    });
  }

  _onChanged(String value) {
    setState(() {
      isNotEmpty = true;
    });
    if (widget.onChanged != null) widget.onChanged(value);
  }
}
