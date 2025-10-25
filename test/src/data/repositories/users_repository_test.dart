import 'package:b2_people/src/data/repositories/users_repository.dart';
import 'package:b2_people/src/models/prefered_user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../mocks/users.dart';

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
      final result = await repository.markUserAsPrefered(preferedUser);

      expect(result, isTrue);
    },
  );

  test(
    'getPreferedUsers should retrieve a list of users previously marked as prefered (returns a List<PreferedUserModel>)',
    () async {
      final markResult = await repository.markUserAsPrefered(preferedUser);

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
      final markResult = await repository.markUserAsPrefered(preferedUser);

      expect(markResult, isTrue);

      final (result, errorString) = await repository.getPreferedUsers('ownerpreference@email.com');

      expect(result, isA<List<PreferedUserModel>>());
      expect(result, isNotEmpty);
      expect(errorString, isNull);
    },
  );

  test(
    'verifyUserMark should return true if user user is remove from preferences and false otherwise.',
    () async {
      final result = await repository.markUserAsPrefered(preferedUser);

      expect(result, isTrue);

      final (usersResult, errorString) = await repository.getPreferedUsers('ownerpreference@email.com');

      expect(usersResult, isA<List<PreferedUserModel>>());
      expect(usersResult, isNotEmpty);
      expect(errorString, isNull);

      final hasMarkedAsFavorite = await repository.verifyUserMark(preferedUser.id, 'ownerpreference@email.com');

      expect(hasMarkedAsFavorite, isTrue);

      final hasBeenRemoved = await repository.removePreference(preferedUser);

      expect(hasBeenRemoved, isTrue);

      final hasMarkedAsFavoriteYet = await repository.verifyUserMark(preferedUser.id, 'ownerpreference@email.com');

      expect(hasMarkedAsFavoriteYet, isFalse);
    },
  );

  test(
    'removerPreference should return true to account owner that has selected the profile as favorite.',
    () async {
      final result = await repository.markUserAsPrefered(preferedUser);

      expect(result, isTrue);

      final (usersResult, errorString) = await repository.getPreferedUsers('ownerpreference@email.com');

      expect(usersResult, isA<List<PreferedUserModel>>());
      expect(usersResult, isNotEmpty);
      expect(errorString, isNull);

      final removingResult = await repository.removePreference(preferedUser);

      expect(removingResult, isTrue);

      final (removedUsersResult, _) = await repository.getPreferedUsers('ownerpreference@email.com');

      expect(removedUsersResult, isA<List<PreferedUserModel>>());
      expect(removedUsersResult, isEmpty);
    },
  );

  test(
    'getUserMarks should retrieve the amount of preferences of a single user (returns an int with the value)',
    () async {
      final markResult = await repository.markUserAsPrefered(preferedUser);

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
