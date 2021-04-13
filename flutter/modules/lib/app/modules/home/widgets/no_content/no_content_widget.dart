import 'package:flutter/material.dart';

class NoContentWidget extends StatelessWidget {
  final String title;
  final String text;
  final String image;

  const NoContentWidget({
    Key key,
    @required this.title,
    @required this.text,
    this.image = 'assets/images/ops.png',
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 15,
      ),
      width: MediaQuery.of(context).size.width,
      child: ListView(
        cacheExtent: double.maxFinite,
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              height: 250,
              width: 250,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(this.image),
                ),
              ),
            ),
          ),
          Text(
            this.title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 21,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            this.text,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 16,
              height: 1.5,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
