import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class TextLinkWidget extends StatelessWidget {
  final String text;
  final TextAlign textAlign;

  const TextLinkWidget({Key key, this.text, this.textAlign = TextAlign.center})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            style: TextStyle(
              color: Colors.blueAccent,
              fontSize: 12,
            ),
            text: this.text,
            recognizer: TapGestureRecognizer()
              ..onTap = () async {
                final url = this.text;
                if (await canLaunch(url)) {
                  await launch(
                    url,
                    forceSafariVC: false,
                  );
                }
              },
          ),
        ],
      ),
      textAlign: this.textAlign,
    );
  }
}
