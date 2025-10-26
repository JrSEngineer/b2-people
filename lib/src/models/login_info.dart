// ignore_for_file: public_member_api_docs, sort_constructors_first
class LoginInfo {
  final String uuid;
  final String username;
  final String password;
  final String salt;
  final String md5;
  final String sha1;
  final String sha256;

  LoginInfo({
    required this.uuid,
    required this.username,
    required this.password,
    required this.salt,
    required this.md5,
    required this.sha1,
    required this.sha256,
  });

  factory LoginInfo.fromMap(Map<String, dynamic> map) {
    return LoginInfo(
      uuid: map['uuid'],
      username: map['username'],
      password: map['password'],
      salt: map['salt'],
      md5: map['md5'],
      sha1: map['sha1'],
      sha256: map['sha256'],
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uuid': uuid,
      'username': username,
      'password': password,
      'salt': salt,
      'md5': md5,
      'sha1': sha1,
      'sha256': sha256,
    };
  }

  factory LoginInfo.empty() => LoginInfo(uuid: '', username: '', password: '', salt: '', md5: '', sha1: '', sha256: '');
}
