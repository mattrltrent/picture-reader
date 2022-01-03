import 'package:flutter/material.dart';

class FoundationTileImage extends StatelessWidget {

  final dynamic image;
  final Function onDeletePress;

  FoundationTileImage({@required this.image, @required this.onDeletePress});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.all(
        Radius.circular(25),
      ),
      child: Container(
        margin: EdgeInsets.all(10),
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(25),
            boxShadow: [
              BoxShadow(
                color: Colors.black45,
                offset: Offset(2, 1),
                blurRadius: 8,
              ),
            ]),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(25),
          child: Container(
            child: Center(
              child: Stack(
                children: <Widget>[
                  Center(child: image),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: EdgeInsets.all(8),
                      child: ClipOval(
                        child: Material(
                          color: Colors.indigoAccent,
                          child: InkWell(
                            child: SizedBox(width: 40, height: 40, child: Icon(Icons.delete, size: 25, color: Colors.white,)),
                            onTap: null,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: Padding(
                      padding: EdgeInsets.all(8),
                      child: ClipOval(
                        child: Material(
                          color: Colors.indigoAccent,
                          child: InkWell(
                            child: SizedBox(width: 40, height: 40, child: Icon(Icons.add, size: 25, color: Colors.white,)),
                            onTap: null,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

