import 'package:b2_people/src/models/person_model.dart';

abstract interface class IPersonsRepository {
  Future<(PersonModel?, String?)> fetchPerson(String seed);
  Future<bool> markPersonAsPrefered(String accountEmail, PersonModel user);
  Future<bool> verifyPersonMark(String userId, String accountEmail);
  Future<bool> removePreference(String accountEmail, PersonModel user);
  Future<(List<PersonModel>?, String?)> getPreferedPersons(String accountEmail);
  Future<(int?, String?)> getPersonMarks(String userId);
}
