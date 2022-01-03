import 'package:flutter/material.dart';

class CircleButtonTile extends StatelessWidget {

  final IconData icon;
  final Function onClick;

  CircleButtonTile({@required this.icon, @required this.onClick});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8),
      child: ClipOval(
        child: Material(
          color: Colors.indigoAccent,
          child: InkWell(
            child: SizedBox(width: 40, height: 40, child: Icon(icon, size: 25, color: Colors.white,)),
            onTap: onClick,
          ),
        ),
      ),
    );
  }
}
