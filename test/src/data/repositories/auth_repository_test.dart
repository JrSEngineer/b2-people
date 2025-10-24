import 'package:b2_people/src/data/repositories/auth_repository.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mocktail/mocktail.dart';

class GoogleSignInMock extends Mock implements GoogleSignIn {}

class GoogleSignInInvalidAccountMock implements GoogleSignInAccount {
  @override
  GoogleSignInAuthentication get authentication => GoogleSignInAuthentication(idToken: null);
  @override
  GoogleSignInAuthorizationClient get authorizationClient => throw UnimplementedError();
  @override
  String? get displayName => throw UnimplementedError();
  @override
  String get email => throw UnimplementedError();
  @override
  String get id => throw UnimplementedError();
  @override
  String? get photoUrl => throw UnimplementedError();
}

class GoogleSignInAccountMock implements GoogleSignInAccount {
  @override
  GoogleSignInAuthentication get authentication => GoogleSignInAuthentication(idToken: 'fake_id_token');
  @override
  GoogleSignInAuthorizationClient get authorizationClient => throw UnimplementedError();
  @override
  String? get displayName => throw UnimplementedError();
  @override
  String get email => 'user@email.com';
  @override
  String get id => throw UnimplementedError();
  @override
  String? get photoUrl => throw UnimplementedError();
}

void main() {
  late GoogleSignInMock googleSignIn;
  late GoogleSignInAccount googleAccount;
  late FakeFirebaseFirestore firebase;
  late AuthRepository repository;

  setUpAll(
    () {
      googleSignIn = GoogleSignInMock();
      firebase = FakeFirebaseFirestore();
      repository = AuthRepository(googleSignIn, firebase);
    },
  );
  group(
    'signInWithGoogle should',
    () {
      test(
        'return an error string if authentication fails',
        () async {
          googleAccount = GoogleSignInInvalidAccountMock();
          when(() => googleSignIn.initialize(serverClientId: any(named: 'serverClientId'))).thenAnswer((_) async => Future.value());
          when(() => googleSignIn.authenticate()).thenAnswer((_) async => googleAccount);

          final result = await repository.signInWithGoogle();

          expect(result, isNotNull);
          expect(result, isNotEmpty);
          expect(result, equals('Nenhuma conta informada.'));
        },
      );
      test(
        'return null value, after setting "online" status in firestore, if authentication succeeds',
        () async {
          googleAccount = GoogleSignInAccountMock();

          when(() => googleSignIn.initialize(serverClientId: any(named: 'serverClientId'))).thenAnswer((_) async => Future.value());
          when(() => googleSignIn.authenticate()).thenAnswer((_) async => googleAccount);

          final result = await repository.signInWithGoogle();

          expect(result, isNull);
        },
      );
    },
  );
}
