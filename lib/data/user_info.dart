class UserInfo {
  final String displayName;
  final String username;
  final int experienceYears;
  final String address;
  final String level;
  UserInfo({
    required this.displayName,
    required this.username,
    required this.experienceYears,
    required this.address,
    required this.level,
  });
  factory UserInfo.json(json) {
    return UserInfo(
      displayName: json["displayName"],
      username: json["username"],
      experienceYears: json["experienceYears"],
      address: json["address"],
      level: json["level"],
    );
  }
}
