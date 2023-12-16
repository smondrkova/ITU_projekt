class User {
  String id;
  String name;
  String surname;
  String phoneNumber;
  String? photoUrl;
  String password;

  User({
    required this.id, 
    required this.name, 
    required this.surname,
    required this.phoneNumber,
    required this.photoUrl,
    required this.password
  });
}
