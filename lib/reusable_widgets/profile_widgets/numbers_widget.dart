import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NumbersWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Wrap(
        children: <Widget>[
          buildButton(context, '4.8/5.0', 'Ranking'),
          buildDivider(),
          buildButton(context, '${DateFormat("dd,MMM yy").format(DateTime(2023))}', 'Joining Date'),
          buildDivider(),
          buildButton(context, '55/month', 'Avg Sales'),
        ],
      );
  Widget buildDivider() => Container(
        height: 24,
        child: VerticalDivider(),
      );

  Widget buildButton(BuildContext context, String value, String text) => MaterialButton(
        padding: EdgeInsets.symmetric(vertical: 4),
        onPressed: () {},
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text(
              value,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
            ),
            SizedBox(height: 2),
            Text(
              text,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      );
}
