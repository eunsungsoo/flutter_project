import 'package:flutter/material.dart';

/*
  const와 final의 차이
  https://medium.com/dartlang-korea/dart-final-%EA%B3%BC-const-bc8c6c024ef4

  요점 :  ***둘 다 상수를 정의한다는 면에서는 동일함.
         final은 컴파일시와 runtime시에 값을 대입가능
         const는 컴파일시에는 값을 대입할 수 있지만 runtime시에는 값을 대입할 수 없음.
 */

class Login extends StatelessWidget {
  const Login(this.onSubmit);

  final VoidCallback onSubmit;

  static final TextEditingController _user = new TextEditingController();
  static final TextEditingController _pass = new TextEditingController();

  String get username => _user.text;
  String get password => _pass.text;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        TextField(
          controller: _user,
          decoration: InputDecoration(hintText: 'Enter a username'),
        ),
        TextField(
          controller: _pass,
          decoration: InputDecoration(hintText: 'Enter a password'),
          obscureText: true,
        ),
        RaisedButton(
          child: Text('Submit'),
          onPressed: onSubmit,
        )
      ],
    );
  }
}
