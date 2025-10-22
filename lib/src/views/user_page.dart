// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:b2_people/src/models/user_model.dart';
import 'package:country_flags/country_flags.dart';
import 'package:flutter/material.dart';

class UserPage extends StatefulWidget {
  const UserPage({
    super.key,
    required this.user,
  });

  final UserModel user;

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  @override
  Widget build(BuildContext context) {
    final avatarBorderColor = switch (widget.user.gender) {
      UserGender.female => Colors.pinkAccent,
      UserGender.male => Colors.blueAccent,
    };

    final profileImage = widget.user.profile.profileImage;

    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xff321F5D),
                  Color(0xff5596FF),
                ],
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 48, horizontal: 24),
            width: MediaQuery.sizeOf(context).width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: MediaQuery.sizeOf(context).width * 0.4,
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 8,
                      color: avatarBorderColor,
                    ),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(profileImage),
                      radius: MediaQuery.sizeOf(context).width * 0.2,
                    ),
                  ),
                ),
                Text(
                  widget.user.fullName,
                  style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                  ),
                ),
                Text(
                  widget.user.profile.email,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  widget.user.profile.phone,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  widget.user.profile.profileUsername,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Spacer(),
                ElevatedButton(
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (_) {
                        return BottomSheet(
                          onClosing: () {},
                          builder: (context) {
                            return ListView(
                              physics: const NeverScrollableScrollPhysics(),
                              padding: EdgeInsets.symmetric(vertical: 24, horizontal: 24),
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  spacing: 24,
                                  children: [
                                    Column(
                                      spacing: 4,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Naturalidade',
                                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            CountryFlag.fromCountryCode(
                                              widget.user.address.naturallity,
                                              theme: const ImageTheme(
                                                shape: RoundedRectangle(4),
                                              ),
                                            ),
                                            SizedBox(width: 24),
                                            Text(
                                              widget.user.address.country,
                                              style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                                                fontWeight: FontWeight.w800,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Column(
                                      spacing: 4,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Cidade',
                                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          widget.user.address.city,
                                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      spacing: 4,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Estado',
                                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          widget.user.address.state,
                                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      spacing: 4,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Celular',
                                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          widget.user.profile.cell,
                                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      spacing: 4,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Código Postal',
                                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          widget.user.address.postcode,
                                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            );
                          },
                        );
                      },
                    );
                  },
                  child: Text(
                    'Mais Informações',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
