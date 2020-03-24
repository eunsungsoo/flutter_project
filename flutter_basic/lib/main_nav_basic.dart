import 'package:flutter/material.dart';

void main() => runApp(
    MaterialApp(
      title: 'Navigation Basics',
      home: FirstRoute()
    )
);


class FirstRoute extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Text('First Route')
      ),
      body:Center(
        child:RaisedButton(
          child:Text('Open route'),
          onPressed: (){
            Navigator.push(
              context,
              MaterialPageRoute(builder:(context) => SecondRoute()), //현재 context를 다음 라우트에 넘겨줌.
            );
          },
        )
      )
    );
  }
}
class SecondRoute extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Second Route'),
        ),
        body:Center(
            child: RaisedButton(
                onPressed: (){
                  Navigator.pop(context); //현재 라우트 context를 제거함.
                },
                child:Text('Go back!')
            )
        )
    );
  }
}