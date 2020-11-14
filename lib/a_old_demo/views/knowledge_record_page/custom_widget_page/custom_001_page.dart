import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Custom001Page extends StatefulWidget {
  final String title;

  Custom001Page({Key key, this.title = "组合 Widget：GradientButton"}) : super(key: key);

  @override
  _Custom001PageState createState() => _Custom001PageState();
}

class _Custom001PageState extends State<Custom001Page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: GradientButton(
        width: 200,
        height: 100,
        colors: [Colors.blue, Colors.red],
        child: Text("让我偷偷看着你"),
        onPressed: () {
          Fluttertoast.showToast(msg: "fjx");
        },
      ),
    );
  }
}

class GradientButton extends StatelessWidget {
  final List<Color> colors;
  final double width;
  final double height;
  final GestureTapCallback onPressed;
  final BorderRadius borderRadius;
  final Widget child;

  GradientButton({
    this.colors,
    this.width,
    this.height,
    this.onPressed,
    this.borderRadius,
    @required this.child,
  });

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    List<Color> _colors = colors ??
        [theme.primaryColor, theme.primaryColorDark ?? theme.primaryColor];

    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: _colors),
        borderRadius: borderRadius,
      ),
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          splashColor: _colors.last,
          highlightColor: Colors.transparent,
          borderRadius: borderRadius,
          onTap: onPressed,
          child: ConstrainedBox(
            constraints: BoxConstraints.tightFor(
              height: height,
              width: width,
            ),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: DefaultTextStyle(
                  style: TextStyle(fontWeight: FontWeight.bold),
                  child: child,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
