import 'package:flutter/material.dart';

void main() => runApp(
      MaterialApp(
        title: 'Named Routes',
        routes: {
          '/': (_) => MainApp(),
          '/list': (_) => NavListScreen(),
        },
        onGenerateRoute: (RouteSettings settings) {
          final List<String> pathElements = settings.name.split('/');
          if (pathElements[1] == 'list') {
            return MaterialPageRoute(
              builder: (_) => ItemDetailScreen(itemId: pathElements[2]),
            );
          }
          return null;
        },
        onUnknownRoute: (RouteSettings settings) {
          return MaterialPageRoute(
            builder: (_) => NotFoundScreen(),
          );
        },
      ),
    );

class MainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Main Nav'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RaisedButton(
              onPressed: () {
                Navigator.of(context).pushNamed('/list');
              },
              child: Text('Move To List'),
            ),
            RaisedButton(
              onPressed: () {
                Navigator.of(context).pushNamed('/notFound');
              },
              child: Text('Movoe To Not Found'),
            )
          ],
        ),
      ),
    );
  }
}

class NavListScreen extends StatelessWidget {
  final List<String> items = List.generate(30, (index) => 'item_$index');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Main Nav'),
      ),
      body: ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text(this.items[index]),
            onTap: () {
              Navigator.of(context).pushNamed('/list/${this.items[index]}');
            },
          );
        },
        itemCount: items.length,
      ),
    );
  }
}

class ItemDetailScreen extends StatelessWidget {
  final String itemId;

  ItemDetailScreen({this.itemId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Main Nav'),
      ),
      body: Center(
        child: Text(
          this.itemId,
          style: TextStyle(
            fontSize: 100,
          ),
        ),
      ),
    );
  }
}

class NotFoundScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Not Found'),
        ),
        body: Center(
          child: Text(
            'Not Found',
            style: TextStyle(
              fontSize: 40,
            ),
          ),
        ));
  }
}
