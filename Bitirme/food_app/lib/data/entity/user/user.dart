class AppUser {
  String id;
  String username;
  String email;
  String imageURL;
  AppUser({
    required this.id,
    required this.username,
    required this.email,
    required this.imageURL,
  });

  factory AppUser.fromJson(Map<dynamic, dynamic> json, String key) {
    return AppUser(
      id: key,
      username: json["username"] as String,
      email: json["email"] as String,
      imageURL: json["imageURL"] as String,
    );
  }
}
