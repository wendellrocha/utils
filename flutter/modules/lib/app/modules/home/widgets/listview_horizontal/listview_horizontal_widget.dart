import 'package:flutter/material.dart';

class ListviewHorizontalWidget extends StatelessWidget {
  final List<Color> colors = [
    Colors.red,
    Colors.yellow,
    Colors.blue,
    Colors.orange,
    Colors.black
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.18,
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: Theme.of(context).dividerColor,
            width: 5,
          ),
        ),
      ),
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: colors.length,
        itemBuilder: (_, i) {
          return Container(
            width: 120,
            height: 75,
            color: colors[i],
          );
        },
      ),
      // CarouselParceiroWidget(
      //     hideDots: true, viewport: 0.9),
    );
  }
}
