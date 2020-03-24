import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'cupertino_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Startup Name Generator',
      theme: ThemeData(          // Add the 3 lines from here...
        primaryColor: Colors.white,
      ),
      home: RandomWords(),
    );
    //home: CupertinoPage());
  }
}

class RandomWords extends StatefulWidget {
  @override
  RandomWordsState createState() => RandomWordsState();
}

//단어 목록을 저장할 _suggestions 변수를 RandomWordsState 클래스에 추가한다 .
//그리고 글꼴을 크게 만드는 텍스트 스타일 _biggerFont도 추가한다.
class RandomWordsState extends State<RandomWords> {
  final List<WordPair> _suggestions = <WordPair>[];
  final Set<WordPair> _saved = Set<WordPair>(); // Add this line.
  final TextStyle _biggerFont = TextStyle(fontSize: 18.0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Startup Name Generator'),
        actions: <Widget>[
          // Add 3 lines from here...
          IconButton(icon: Icon(Icons.list), onPressed: _pushSaved),
        ], // ... to here.
      ),
      body: _buildSuggestions(),
    );
  }

  Widget _buildSuggestions() {
    //ListView.builder 메서드는 목록 뷰를 필요할 때에 지연 생성 할 수 있다.
    //﻿ListView 클래스는 builder 속성으로 팩토리 빌더 및 콜백 함수인 itemBuilder를 제공한다.
    //이 함수에는 두 개의 매개 변수 BuildContext와 row iterator가 전달된다.
    // iterator는 0부터 시작하여 함수가 호출 될 때마다 매번 증가한다. 이 모델이 무한 스크롤을 가능하게 한다.
    return ListView.builder(
        padding: const EdgeInsets.all(16.0),
        // itemBuilder 콜백은 생성된 단어마다 한 번씩 호출되고 각 단어를 _buildRow()할 때 ListTitle의 하나의 행에 배치한다.
        // 짝수 행의 경우 이 함수는 단어를 ListTitle의 하나의 행에 배치한다.
        // 홀수 행의 경우 Divider()를 호출하는데 구분선을 긋기 위함이다.
        itemBuilder: /*1*/ (context, i) {
          // 홀수 행의 경우 구분선(Divider) 위젯을 추가한다
          if (i.isOdd) return Divider(); /*2*/
          // 코드 "i ~/ 2"는 i를 2로 나눈 몫을 반환한다.
          // 예를 들면, 1, 2, 3, 4, 5는 0, 1, 1, 2, 2이 된다.
          // Divider 위젯을 제외한 ListView의 실제 단어 수를 계산하기 위함이다.
          final index = i ~/ 2; /*3*/

          // 사용 가능한 단어 목록이 끝나면 ...
          // ... 단어 10개를 더 생성하고 단어 목록에 추가.
          if (index >= _suggestions.length) {
            _suggestions.addAll(generateWordPairs().take(10)); /*4*/
          }

          return _buildRow(_suggestions[index]);
        });
  }

  //_buildSuggestions 함수는 단어마다 한 번씩 _buildRow 함수를 호출한다.
  Widget _buildRow(WordPair pair) {
    final alreadySaved = _saved.contains(pair);
    return ListTile(
      title: Text(
        pair.asPascalCase,
        style: _biggerFont,
      ),
      //trailing : 리스트에서 사용할 수 있는 위젯, 글자 뒤에 배치하게 해준다.
      trailing: Icon(
        alreadySaved ? Icons.favorite : Icons.favorite_border,
        color: alreadySaved ? Colors.red : null,
      ),
      onTap: () {
        // Add 9 lines from here...
        setState(() {
          if (alreadySaved) {
            _saved.remove(pair);
          } else {
            _saved.add(pair);
          }
        });
      }, // ... to here.
    );
  }

  void _pushSaved() {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        // Add 20 lines from here...
        builder: (BuildContext context) {
          return LikeRoute(_saved, _biggerFont);
        },
      ), // ... to here.
    );
  }
}
class LikeRoute extends StatelessWidget {

  final Set<WordPair> _saved;
  final _biggerFont;
  LikeRoute(this._saved, this._biggerFont);

  @override
  Widget build(BuildContext context) {
    //ListTile은 ListView의 하나의 항목 아이템이다.
    final Iterable<ListTile> tiles = _saved.map(
          (pair) => ListTile(title: Text(
        pair.asPascalCase,
        style: _biggerFont,
      ),
      )
      ,
    );
    final List<Widget> divided = ListTile.divideTiles(
      context: context,
      tiles: tiles,
    ).toList();

    return Scaffold(         // Add 6 lines from here...
      appBar: AppBar(
        title: Text('Saved Suggestions'),
      ),
      body: ListView(children: divided),
    );
  }
}
