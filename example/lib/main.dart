import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:windowbase/windowbase.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Size size = Size(500, 300);
  Color color = Colors.purple;

  _changeSize() {
    setState(() {
      size = Size(200, 200);
    });
    print('changed');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WindowBase(
        windows: [
          Window(
            child: ListButtons(),
          ),
          Window(
            menuButtons: true,
            height: size.height,
            width: size.width,
            onTap: _changeSize,
            borderColor: color,
            refreshOnUpdate: true,
          ),
          Window(
            borderColor: Colors.green,
            title: 'Título da janela',
          ),
          Window(
            child: Image.network(
              'https://miro.medium.com/max/1740/1*nebfmOdQ2XVS_quqxSV7wQ.png',
            ),
          ),
          Window(
            boundConstraints: false,
            title: 'Janela não constrita',
          ),
        ],
      ),
    );
  }
}

class ListButtons extends StatefulWidget {
  const ListButtons({
    Key key,
  }) : super(key: key);

  @override
  _ListButtonsState createState() => _ListButtonsState();
}

class _ListButtonsState extends State<ListButtons> {
  List<bool> buttonsSet = [true, false, true, false, true, false, true];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: buttonsSet.length,
      itemBuilder: (conxtes, index) {
        return TileExample(
          text: index.toString(),
          setted: buttonsSet[index],
          onSet: (value) {
            setState(() {
              buttonsSet[index] = value;
            });
          },
        );
      },
    );
  }
}

class TileExample extends StatelessWidget {
  const TileExample({
    Key key,
    @required this.text,
    @required this.onSet,
    @required this.setted,
  }) : super(key: key);

  final String text;
  final Function onSet;
  final bool setted;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(text),
      trailing: CupertinoSwitch(
          value: setted,
          onChanged: (value) {
            onSet(value);
          }),
    );
  }
}
