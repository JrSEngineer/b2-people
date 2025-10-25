class LoginInfo {
  final String uuid;
  final String username;

  LoginInfo({
    required this.uuid,
    required this.username,
  });

  factory LoginInfo.frommap(Map<String, dynamic> map) => LoginInfo(
    uuid: map['uuid'],
    username: map['username'],
  );

  Map<String, dynamic> tomap() => {
    'uuid': uuid,
    'username': username,
  };

  factory LoginInfo.empty() => LoginInfo(uuid: '', username: '');
}
