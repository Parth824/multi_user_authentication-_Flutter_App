class User {
  int? id;
  final String email;
  final String password;
  final String type;

  User(
      {this.id,
      required this.email,
      required this.password,
      required this.type});

  factory User.fromMap({required Map data}) {
    return User(
        id: data['id'],email: data['email'], password: data['password'], type: data['type']);
  }
}
