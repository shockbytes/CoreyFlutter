import 'package:Corey/data/login/firebase_login_repository.dart';
import 'package:Corey/data/login/login_repository.dart';
import 'package:Corey/model/corey_user.dart';
import 'package:Corey/ui/workout_widget.dart';
import 'package:Corey/presentation/corey_icons.dart';
import 'package:Corey/ui/body_widget.dart';
import 'package:Corey/ui/schedule_widget.dart';
import 'package:flutter/material.dart';

import 'package:fluttertoast/fluttertoast.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Corey',
        theme: ThemeData(
          fontFamily: 'Montserrat',
          primarySwatch: Colors.green,
          accentColor: Colors.orangeAccent,
        ),
        home: MyHomePage(title: 'Corey'),
        debugShowCheckedModeBanner: false);
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

enum OverflowState { SETTINGS, LOGOUT, DREAM_WEIGHT }

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 1;
  String _url = "";
  LoginRepository loginRepository = FirebaseLoginRepository();

  final List<Widget> _children = [
    WorkoutWidget(),
    ScheduleWidget(),
    BodyWidget()
  ];

  void _updateBottomNavigationBar(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  void _onOverflowSelected(OverflowState state) {
    Fluttertoast.showToast(
        msg: state.toString(),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM);
  }

  @override
  void initState() {
    super.initState();

    loginRepository.signIn().then((CoreyUser user) {
      print(user);
      setState(() {
        _url = user.photoUrl;
        Fluttertoast.showToast(msg: "Welcome back ${user.name}");
      });
    }).catchError((e) {
      print(e);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 240, 240, 240),
      appBar: AppBar(title: Text(widget.title), actions: [
        Container(
            margin: EdgeInsets.all(8),
            child: CircleAvatar(
              backgroundImage: NetworkImage(_url),
            )),
        PopupMenuButton<OverflowState>(
          onSelected: _onOverflowSelected,
          itemBuilder: (BuildContext context) =>
              <PopupMenuEntry<OverflowState>>[
                const PopupMenuItem<OverflowState>(
                  value: OverflowState.DREAM_WEIGHT,
                  child: Text('Dream weight'),
                ),
                const PopupMenuItem<OverflowState>(
                  value: OverflowState.LOGOUT,
                  child: Text('Logout'),
                ),
                const PopupMenuItem<OverflowState>(
                  value: OverflowState.SETTINGS,
                  child: Text('Settings'),
                ),
              ],
        )
      ]),
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: _updateBottomNavigationBar,
          items: [
            BottomNavigationBarItem(
                title: Text("Workouts"),
                icon: Icon(CoreyIcons.workout, color: Colors.grey),
                activeIcon: Icon(CoreyIcons.workout, color: Colors.green)),
            BottomNavigationBarItem(
                title: Text("Schedule"),
                icon: Icon(CoreyIcons.schedule, color: Colors.grey),
                activeIcon: Icon(CoreyIcons.schedule, color: Colors.green)),
            BottomNavigationBarItem(
                title: Text("My body"),
                icon: Icon(CoreyIcons.body, color: Colors.grey),
                activeIcon: Icon(CoreyIcons.body, color: Colors.green)),
          ]),
      body: _children[
          _currentIndex], // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
