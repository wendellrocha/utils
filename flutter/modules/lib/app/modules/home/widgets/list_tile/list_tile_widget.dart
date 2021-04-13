import 'package:app_claudio_flutter/app/shared/theme/theme.dart';
import 'package:flutter/material.dart';

class ListTileWidget extends StatelessWidget {
  final String title;
  final Function callback;
  final Widget leading;

  const ListTileWidget({Key key, this.title, this.callback, this.leading})
      : assert(title != null, 'Title must not be null'),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Theme.of(context).dividerColor,
            width: 0.5,
          ),
        ),
      ),
      child: ListTile(
        onTap: () => this.callback(),
        leading: this.leading,
        title: Text(
          this.title,
          style: TextStyle(
            color: ThemeColor.textBody,
          ),
        ),
      ),
    );
  }
}
