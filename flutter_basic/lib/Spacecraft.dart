class Spacecraft {
  String name;
  DateTime launchDate;

  // Constructor, with syntactic sugar for assignment to members.
  Spacecraft(this.name, this.launchDate) {
    // Initialization code goes here.
  }
  Spacecraft.origin(){
    name = "무탈리스크";
    launchDate = DateTime.now();
  }

  // Named constructor that forwards to the default one.
  Spacecraft.unlaunched(String name) : this(name, null);

  //이 문법은 화살표 함수 문법인데 get 키워드가 무엇을 의미하는지 아직 모르겠음.
  int get launchYear => 
      launchDate?.year; // read-only non-final property

  // Method.
  void describe() {
    print('Spacecraft: $name');
    if (launchDate != null) {
      int days =
          DateTime.now().difference(launchDate).inDays;
      print('Launched: $launchYear ($days days ago)');
    } else {
      print('Unlaunched');
    }
  }
}

class Orbiter extends Spacecraft {
  num altitude;
  Orbiter(String name, DateTime launchDate, this.altitude)
      : super(name, launchDate);
}

void main() {
  Spacecraft sc = Spacecraft("스카우트", DateTime.now());
  print(sc.name);
  print(sc.launchDate);
  print("\n");

  Spacecraft sc2 = Spacecraft.origin();
  print(sc2.name);
  print(sc2.launchDate);
  print("\n");

  Spacecraft sc3 = Spacecraft.unlaunched("캐리어");
  print(sc3.name);
  print(sc3.launchDate);
  print("\n");
  
  Spacecraft sc4 = Spacecraft("배틀크루저", DateTime.now());
  sc4.describe(); //  ~/ 연산자는 실수가 나올 때 정수를 리턴한다.
  
  //Dart는 Java와는 다르게 mixin을 할 수 있음. mixin은 with 키워드로 추가 상속하는 방법
  Orbiter ob = Orbiter("히드라", DateTime.now(), 50);
  ob.describe();

}