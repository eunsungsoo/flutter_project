import 'package:flutter/material.dart';
import './login/settings.dart';
import './login/login.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp>{

  String _title = 'Please Login';
  Widget _screen;
  Login _login;
  Settings _settings;
  bool _authenticated;

  _MyAppState(){
    _login = new Login(onSubmit);
    _settings = new Settings();
    _screen = _login;
    _authenticated = false;
  }

  void onSubmit(){
    print('Login with: '+_login.username+' '+_login.password);
    if(_login.username == 'user' && _login.password == 'password'){
      _setAuthenticated(true);
    }
  }

  void _goHome(){
    print('_goHome()');
    setState(() {
      if(_authenticated == true){
        _screen  = _settings;
      }else{
        _screen  = _login;
      }
    });
  }

  void logout(){
    print('logout()');
    _setAuthenticated(false);
  }

  void _setAuthenticated(bool auth){
    setState(() {
      if(auth == true){
        _screen  = _settings;
        _title = 'Welcome';
      }else{
        _screen  = _login;
        _title = 'Please Login';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login App',
      home: Scaffold(
        appBar: AppBar(
          title: Text(_title),
          actions: <Widget>[
            IconButton(icon:Icon(Icons.home), onPressed: _goHome,),
            IconButton(icon:Icon(Icons.exit_to_app), onPressed: logout,)
          ],
        ),
        body: _screen
      )
    );
  }
}