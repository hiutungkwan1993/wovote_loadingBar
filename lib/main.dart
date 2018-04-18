import 'package:flutter/material.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      theme: new ThemeData.light(),
      title: 'Animation Slider',
      home: new HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new _HomePageState();
  }
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  Animation animation;
  AnimationController controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = new AnimationController(
      vsync: this,
      duration: new Duration(
        milliseconds: 800,
      ),
    );
    animation = new Tween(begin: 0.0, end: 1.0)
        .animate(new CurvedAnimation(parent: controller, curve: Curves.linear))
          ..addListener(() {
            setState(() {});
          })
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              controller.repeat();
            } else if (status == AnimationStatus.dismissed) {
              controller.forward();
            }
          });
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      backgroundColor: new Color.fromRGBO(255, 255, 255, 1.0),
      body: new Center(
        child: new Container(
          width: double.infinity,
          height: 6.0,
          child: new CustomPaint(
            painter: new Artboard(
              value: animation.value,
            ),
          ),
        ),
      ),
    );
  }
}

class Artboard extends CustomPainter {
  Artboard({this.value});

  final double value;

  final List<Color> colors = [
    new Color.fromRGBO(237, 86, 69, 1.0),
    new Color.fromRGBO(255, 255, 145, 1.0),
    new Color.fromRGBO(57, 237, 213, 1.0),
    new Color.fromRGBO(255, 108, 253, 1.0),
  ];

  @override
  void paint(Canvas canvas, Size size) {
    // TODO: implement paint
    canvas.translate(value * size.width, 0.0);
    var redLine = new Paint()
      ..color = colors[0]
      ..strokeWidth = size.height
      ..strokeCap = StrokeCap.round;
    canvas.drawLine(
        new Offset(-size.width / 4, 0.0), new Offset(0.0, 0.0), redLine);

    var yellowLine = new Paint()
      ..color = colors[1]
      ..strokeWidth = size.height
      ..strokeCap = StrokeCap.round;
    canvas.drawLine(new Offset(-size.width / 2, 0.0),
        new Offset(-size.width / 4, 0.0), yellowLine);

    var blueLine = new Paint()
      ..color = colors[2]
      ..strokeWidth = size.height
      ..strokeCap = StrokeCap.round;
    canvas.drawLine(new Offset(-size.width / 4 * 3, 0.0),
        new Offset(-size.width / 2, 0.0), blueLine);

    var pinkLine = new Paint()
      ..color = colors[3]
      ..strokeWidth = size.height
      ..strokeCap = StrokeCap.round;
    canvas.drawLine(new Offset(-size.width, 0.0),
        new Offset(-size.width / 4 * 3, 0.0), pinkLine);

    canvas.drawLine(new Offset(size.width / 4 * 3, 0.0),
        new Offset(size.width, 0.0), redLine);

    canvas.drawLine(new Offset(size.width / 2, 0.0),
        new Offset(size.width / 4 * 3, 0.0), yellowLine);

    canvas.drawLine(new Offset(size.width / 4, 0.0),
        new Offset(size.width / 2, 0.0), blueLine);

    canvas.drawLine(
        new Offset(0.0, 0.0), new Offset(size.width / 4, 0.0), pinkLine);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return true;
  }
}
