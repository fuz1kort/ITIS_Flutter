class Session {
  final String username;
  final String sessionId;

  Session({required this.username, required this.sessionId});

  Map<String, String> toJson() => {
    'username': username,
    'sessionId': sessionId,
  };

  static Session fromJson(Map<String, dynamic> json) {
    return Session(
      username: json['username'],
      sessionId: json['sessionId'],
    );
  }
}
