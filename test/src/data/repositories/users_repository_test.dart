import 'package:b2_people/src/data/repositories/users_repository.dart';
import 'package:b2_people/src/models/prefered_user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late FirebaseFirestore firebase;
  late UsersRepository repository;

  setUpAll(
    () {
      firebase = FakeFirebaseFirestore();
      repository = UsersRepository(firebase);
    },
  );

  test(
    'markUserAsPrefered should return true if user user is saved successfully',
    () async {
      final result = await repository.markUserAsPrefered(
        PreferedUserModel(
          id: 'user_id',
          fullName: 'user_name',
          email: 'user@email.com',
          profileImage: 'image',
          preferenceOwner: 'ownerpreference@email.com',
        ),
      );

      expect(result, isTrue);
    },
  );

  test(
    'getPreferedUsers should retrieve a list of users previously marked as prefered (returns a List<PreferedUserModel>)',
    () async {
      final markResult = await repository.markUserAsPrefered(
        PreferedUserModel(
          id: 'user_id',
          fullName: 'user_name',
          email: 'user@email.com',
          profileImage: 'image',
          preferenceOwner: 'ownerpreference@email.com',
        ),
      );

      expect(markResult, isTrue);

      final (result, errorString) = await repository.getPreferedUsers('ownerpreference@email.com');

      expect(result, isA<List<PreferedUserModel>>());
      expect(result, isNotEmpty);
      expect(errorString, isNull);
    },
  );

  test(
    'getPreferedUsers retrieve a list of users previously marked as prefered (returns a List<PreferedUserModel>)',
    () async {
      final markResult = await repository.markUserAsPrefered(
        PreferedUserModel(
          id: 'user_id',
          fullName: 'user_name',
          email: 'user@email.com',
          profileImage: 'image',
          preferenceOwner: 'ownerpreference@email.com',
        ),
      );

      expect(markResult, isTrue);

      final (result, errorString) = await repository.getPreferedUsers('ownerpreference@email.com');

      expect(result, isA<List<PreferedUserModel>>());
      expect(result, isNotEmpty);
      expect(errorString, isNull);
    },
  );

  test(
    'removerPreference should return true if user user is remove from preferences',
    () async {
      final user = PreferedUserModel(
        id: 'user_id',
        fullName: 'user_name',
        email: 'user@email.com',
        profileImage: 'image',
        preferenceOwner: 'ownerpreference@email.com',
      );

      final result = await repository.markUserAsPrefered(
        user,
      );

      expect(result, isTrue);

      final (usersResult, errorString) = await repository.getPreferedUsers('ownerpreference@email.com');

      expect(usersResult, isA<List<PreferedUserModel>>());
      expect(usersResult, isNotEmpty);
      expect(errorString, isNull);

      final removingResult = await repository.removePreference(user);

      expect(removingResult, isTrue);

      final (removedUsersResult, _) = await repository.getPreferedUsers('ownerpreference@email.com');

      expect(removedUsersResult, isA<List<PreferedUserModel>>());
      expect(removedUsersResult, isEmpty);
    },
  );

  test(
    'getUserMarks should retrieve the amount of preferences of a single user (returns an int with the value)',
    () async {
      final markResult = await repository.markUserAsPrefered(
        PreferedUserModel(
          id: 'user_id',
          fullName: 'user_name',
          email: 'user@email.com',
          profileImage: 'image',
          preferenceOwner: 'ownerpreference@email.com',
        ),
      );

      expect(markResult, isTrue);

      final (result, errorString) = await repository.getPreferedUsers('ownerpreference@email.com');

      expect(result, isA<List<PreferedUserModel>>());
      expect(result, isNotEmpty);
      expect(errorString, isNull);

      final (markAmount, error) = await repository.getUserMarks('user_id');

      expect(markAmount, isA<int>());
      expect(markAmount, isNotNull);
      expect(markAmount, equals(1));
      expect(error, isNull);
    },
  );
}
