import 'package:flutter/material.dart';
import 'circle_button_tile.dart';

class FoundationTileText extends StatelessWidget {
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
                  SingleChildScrollView(
                    child: Center(
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height / 15, horizontal: 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Text('test', style: TextStyle(fontSize: 55),),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: EdgeInsets.all(8),
                      child: ClipOval(
                        child: Material(
                          color: Colors.indigoAccent,
                          child: InkWell(
                            child: SizedBox(width: 40, height: 40, child: Icon(Icons.content_copy, size: 25, color: Colors.white,)),
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
                            child: SizedBox(width: 40, height: 40, child: Icon(Icons.play_arrow, size: 25, color: Colors.white,)),
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
