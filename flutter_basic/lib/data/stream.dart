import 'dart:async';

/*
  스트림은 무엇입니까?
  스트림은 파이프이다. 해당 파이프에는 여러가지 데이터가 들어올 수 있다.
  데이터가 파이프의 입구에서 들어왔다가 출구로 빠져나간다.
*/

/*
  스트림에 의해 전달 될 수있는 것은 무엇입니까?
  값, 이벤트, 객체, 컬렉션, 맵, 오류 또는 심지어 다른 스트림에서 
  모든 유형의 데이터가 스트림에 의해 전달 될 수 있습니다.
*/
Future<int> sumStream(Stream<int> stream) async {
  var sum = 0;
  await for (var value in stream) {
    sum += value;
  }
  return sum;
}
/*
  async* 게으른 연산 : 요청이 있을 때는 연산을 미루다가 sumStream함수에서 사용할 때
  연산을 한다.

  yield : return과 비슷하게 값을 반환해주는데 한번에 하나씩 return함과 동시에
  함수가 종료되지 않고 계속 열려있으면서 지속적으로 return을 해준다.
*/
Stream<int> countStream(int to) async* {
  for (int i = 1; i <= to; i++) {
    yield i;
  }
}

main() async {
  var stream = countStream(10); //실행안됨.왜냐면 게으르니까!!
  
  /*
    이때 stream이 만들어짐. 사용할 때!!
    stream에 데이터가 1,2,3,4,5,6,7,8,9,10 이렇게 들어가 있음.
  */
  var sum = await sumStream(stream);
  print(sum); // 55
  
}