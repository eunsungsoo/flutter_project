class User {
  final String name;
  final String email;

  User(this.name, this.email);

  User.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        email = json['email'];

  Map<String, dynamic> toJson() =>
    {
      'name': name,
      'email': email,
    };
}

void main(){
  User userToJson = User("jooho", "jooho@nate.com");
  print(userToJson.toJson());

  User jsonToUser = User.fromJson(userToJson.toJson());
  print(jsonToUser.name);
  print(jsonToUser.email);
}