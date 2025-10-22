// ignore_for_file: use_build_context_synchronously

import 'package:b2_people/user_page.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List usersList = [];
  bool isLoading = false;

  int page = 1;
  int results = 20;

  Future<void> _fetchUsers() async {
    try {
      isLoading = true;
      setState(() {});

      page = 1;

      final dio = Dio();

      final response = await dio.get('https://randomuser.me/api/?page=$page&results=$results&seed=myusers');

      final users = response.data['results'] as List;

      for (var item in users) {
        usersList.add(item);
      }
    } on DioException catch (_) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red.shade800,
          content: Text(
            'Ops! Algum erro ocorreu durante a busca.',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.white),
          ),
        ),
      );
    } catch (_) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red.shade800,
          content: Text(
            'Erro desconhecido.',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.white),
          ),
        ),
      );
    } finally {
      isLoading = false;
      setState(() {});
    }
  }

  final scrollController = ScrollController();

  _onScroll() async {
    if (scrollController.position.maxScrollExtent == scrollController.offset) {
      page++;

      final dio = Dio();

      final response = await dio.get('https://randomuser.me/api/?page=$page&results=$results&seed=myusers');

      final users = response.data['results'] as List;

      usersList.addAll(users);

      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();

    _fetchUsers();

    scrollController.addListener(_onScroll);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff5109F9),
        title: Text(
          'B2 People',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: _fetchUsers,
            padding: EdgeInsets.zero,
            visualDensity: VisualDensity.compact,
            icon: Icon(
              Icons.refresh,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: Container(
        height: MediaQuery.sizeOf(context).height,
        width: MediaQuery.sizeOf(context).width,
        padding: EdgeInsets.symmetric(
          vertical: 12,
          horizontal: 12,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (!isLoading)
              Text(
                'Usuários',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
            if (!isLoading)
              Expanded(
                child: ListView.builder(
                  controller: scrollController,
                  physics: const BouncingScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: usersList.length + 1,
                  itemBuilder: (_, i) {
                    if (i < usersList.length) {
                      final userMap = usersList[i];
                      final icon = userMap['gender'] == 'female' ? Icons.woman : Icons.man;
                      final iconColor = userMap['gender'] == 'female' ? Colors.pinkAccent : Colors.blueAccent;

                      final profileImage = userMap['picture']['large'];
                      final userName = '${userMap['name']['first']} ${userMap['name']['last']}';
                      final userEmail = '${userMap['email']}';
                      final userPhone = '${userMap['phone']}';
                      final userCell = '${userMap['cell']}';
                      final profileUsername = '${userMap['login']['username']}';
                      final gender = '${userMap['gender']}';
                      final naturallity = '${userMap['nat']}';
                      final postcode = '${userMap['location']['postcode']}';
                      final city = '${userMap['location']['city']}';
                      final state = '${userMap['location']['state']}';
                      final country = '${userMap['location']['country']}';

                      return ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: Container(
                          height: 36,
                          width: 36,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            image: DecorationImage(
                              fit: BoxFit.fill,
                              image: NetworkImage(
                                userMap['picture']['thumbnail'],
                              ),
                            ),
                          ),
                        ),
                        title: Text(
                          userName,
                        ),
                        subtitle: Text(
                          userEmail,
                        ),
                        trailing: Icon(
                          icon,
                          color: iconColor,
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => UserPage(
                                profileImage: profileImage,
                                userName: userName,
                                userEmail: userEmail,
                                userPhone: userPhone,
                                userCell: userCell,
                                profileUsername: profileUsername,
                                gender: gender,
                                naturallity: naturallity,
                                postcode: postcode,
                                city: city,
                                state: state,
                                country: country,
                              ),
                            ),
                          );
                        },
                      );
                    } else {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                ),
              ),
            if (isLoading)
              SizedBox(
                height: MediaQuery.sizeOf(context).height * 0.6,
                width: MediaQuery.sizeOf(context).width,
                child: Column(
                  children: [
                    Container(
                      height: MediaQuery.sizeOf(context).width * 0.6,
                      width: MediaQuery.sizeOf(context).width * 0.6,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        image: DecorationImage(
                          fit: BoxFit.fill,
                          image: AssetImage(
                            'assets/images/no-users-image.png',
                          ),
                        ),
                      ),
                    ),
                    Text(
                      'Sem Usuários no momento...',
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    scrollController.removeListener(_onScroll);
    super.dispose();
  }
}
