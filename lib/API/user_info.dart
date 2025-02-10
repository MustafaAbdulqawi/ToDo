class UserInfo {
  //final String id;
  final String displayName;
  final String username;
  //final List<String> roles;
  //final bool active;
  final int experienceYears;
  final String address;
  final String level;
  //final DateTime createdAt;
  //final DateTime updatedAt;
  //final int v;

  UserInfo({
   // required this.id,
    required this.displayName,
    required this.username,
   // required this.roles,
   // required this.active,
    required this.experienceYears,
    required this.address,
    required this.level,
  //  required this.createdAt,
  //  required this.updatedAt,
  //  required this.v,
  });
  factory UserInfo.json(json) {
    return UserInfo(
     // id: json["id"],
      displayName: json["displayName"],
      username: json["username"],
    //  roles: [json["roles"]],
    //  active: json["active"],
      experienceYears: json["experienceYears"],
      address: json["address"],
      level: json["level"],
     // createdAt: json["createdAt"],
   //   updatedAt: json["updatedAt"],
   //   v: json["__v"],
    );
  }
}
