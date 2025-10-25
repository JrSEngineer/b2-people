import 'package:b2_people/src/models/basic_person_model.dart';

abstract interface class IHomeRepository {
  Future<(List<BasicPersonModel>?, String?)> getPersons(String seed, int page, int results);
  Future<(List<BasicPersonModel>?, String?)> getSavedPersons();
}
