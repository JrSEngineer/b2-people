import 'package:b2_people/src/models/address_model.dart';
import 'package:b2_people/src/models/prefered_user_model.dart';
import 'package:b2_people/src/models/profile_model.dart';
import 'package:b2_people/src/models/user_model.dart';

final userMapsResultsMock = {
  "results": [
    {
      "gender": "female",
      "name": {"title": "Miss", "first": "Jennie", "last": "Nichols"},
      "location": {
        "street": {"number": 8929, "name": "Valwood Pkwy"},
        "city": "Billings",
        "state": "Michigan",
        "country": "United States",
        "postcode": "63104",
        "coordinates": {"latitude": "-69.8246", "longitude": "134.8719"},
        "timezone": {"offset": "+9:30", "description": "Adelaide, Darwin"},
      },
      "email": "jennie.nichols@example.com",
      "login": {
        "uuid": "7a0eed16-9430-4d68-901f-c0d4c1c3bf00",
        "username": "yellowpeacock117",
        "password": "addison",
        "salt": "sld1yGtd",
        "md5": "ab54ac4c0be9480ae8fa5e9e2a5196a3",
        "sha1": "edcf2ce613cbdea349133c52dc2f3b83168dc51b",
        "sha256": "48df5229235ada28389b91e60a935e4f9b73eb4bdb855ef9258a1751f10bdc5d",
      },
      "dob": {"date": "1992-03-08T15:13:16.688Z", "age": 30},
      "registered": {"date": "2007-07-09T05:51:59.390Z", "age": 14},
      "phone": "(272) 790-0888",
      "cell": "(489) 330-2385",
      "id": {"name": "SSN", "value": "405-88-3636"},
      "picture": {
        "large": "https://randomuser.me/api/portraits/men/75.jpg",
        "medium": "https://randomuser.me/api/portraits/med/men/75.jpg",
        "thumbnail": "https://randomuser.me/api/portraits/thumb/men/75.jpg",
      },
      "nat": "US",
    },
    {
      "gender": "female",
      "name": {"title": "Miss", "first": "Jennie", "last": "Nichols"},
      "location": {
        "street": {"number": 8929, "name": "Valwood Pkwy"},
        "city": "Billings",
        "state": "Michigan",
        "country": "United States",
        "postcode": "63104",
        "coordinates": {"latitude": "-69.8246", "longitude": "134.8719"},
        "timezone": {"offset": "+9:30", "description": "Adelaide, Darwin"},
      },
      "email": "jennie.nichols@example.com",
      "login": {
        "uuid": "7a0eed16-9430-4d68-901f-c0d4c1c3bf00",
        "username": "yellowpeacock117",
        "password": "addison",
        "salt": "sld1yGtd",
        "md5": "ab54ac4c0be9480ae8fa5e9e2a5196a3",
        "sha1": "edcf2ce613cbdea349133c52dc2f3b83168dc51b",
        "sha256": "48df5229235ada28389b91e60a935e4f9b73eb4bdb855ef9258a1751f10bdc5d",
      },
      "dob": {"date": "1992-03-08T15:13:16.688Z", "age": 30},
      "registered": {"date": "2007-07-09T05:51:59.390Z", "age": 14},
      "phone": "(272) 790-0888",
      "cell": "(489) 330-2385",
      "id": {"name": "SSN", "value": "405-88-3636"},
      "picture": {
        "large": "https://randomuser.me/api/portraits/men/75.jpg",
        "medium": "https://randomuser.me/api/portraits/med/men/75.jpg",
        "thumbnail": "https://randomuser.me/api/portraits/thumb/men/75.jpg",
      },
      "nat": "US",
    },
  ],
  "info": {"seed": "56d27f4a53bd5441", "results": 1, "page": 1, "version": "1.4"},
};

final user1Mock = UserModel(
  id: 'd912a4cc-52b3-4c92-bc21-9c37a7c937f1',
  fullName: 'Laura Stevens',
  gender: UserGender.female,
  profile: ProfileModel(
    email: 'laura.stevens@example.com',
    profileImage: 'https://randomuser.me/api/portraits/women/68.jpg',
    profileUsername: 'silverfox912',
    phone: '(312) 555-2389',
    cell: '(412) 777-9087',
  ),
  address: AddressModel(
    naturallity: 'US',
    postcode: '90210',
    city: 'Beverly Hills',
    state: 'California',
    country: 'United States',
  ),
);

final user2Mock = UserModel(
  id: 'e53f7c1a-1472-4a79-a8f0-d83b82e81a2c',
  fullName: 'Robert Jenkins',
  gender: UserGender.male,
  profile: ProfileModel(
    email: 'robert.jenkins@example.com',
    profileImage: 'https://randomuser.me/api/portraits/men/75.jpg',
    profileUsername: 'bluedolphin21',
    phone: '(212) 593-4455',
    cell: '(917) 540-7712',
  ),
  address: AddressModel(
    naturallity: 'US',
    postcode: '10022',
    city: 'New York',
    state: 'New York',
    country: 'United States',
  ),
);

final usersList = [user1Mock, user2Mock];

final preferedUser = PreferedUserModel(
  id: 'user_id',
  fullName: 'user_name',
  email: 'user@email.com',
  profileImage: 'image',
  preferenceOwner: 'ownerpreference@email.com',
);

final seccondPreferedUser = PreferedUserModel(
  id: 'user_id',
  fullName: 'user_name',
  email: 'user@email.com',
  profileImage: 'image',
  preferenceOwner: 'ownerpreference@email.com',
);

final preferedUsersListMock = [preferedUser, seccondPreferedUser];
