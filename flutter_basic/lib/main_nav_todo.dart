import 'package:flutter/material.dart';

class Todo {
  final String title;
  final String description;

  Todo(this.title, this.description);
}

void main() {
  runApp(MaterialApp(
    initialRoute: '/',
    routes: {
      '/': (context) => TodosScreen(
            todos: List.generate(
              20,
              (i) => Todo(
                'Todo $i',
                'A description of what needs to be done for Todo $i',
              ),
            ),
          ),
      '/detail': (context) => DetailScreen(),
    },
    title: 'Passing Data',
  ));
}

class TodosScreen extends StatelessWidget {
  final List<Todo> todos;

  TodosScreen({Key key, @required this.todos}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Todos'),
      ),
      body: ListView.builder(
        itemCount: todos.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(todos[index].title),
            // 사용자가 ListTile을 선택하면, DetailScreen으로 이동합니다.
            // DetailScreen을 생성할 뿐만 아니라, 현재 todo를 같이 전달해야
            // 한다는 것을 명심하세요.
            onTap: () {
              Navigator.pushNamed(context, '/detail',
                  arguments: Todo('Title Hello $index', 'description Hello $index'));
            },
          );
        },
      ),
    );
  }
}

class DetailScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Todo args = ModalRoute.of(context).settings.arguments; //pushName의 arguments값을 ModalRoute.of(context).settings가 가지고 있음.

    return Scaffold(
      appBar: AppBar(
        title: Text(args.title),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Text(args.description),
      ),
    );
  }
}