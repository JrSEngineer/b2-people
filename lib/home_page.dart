// ignore_for_file: use_build_context_synchronously

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Map<String, dynamic>> usersList = [];
  bool isLoading = false;

  Future<void> _fetchUsers() async {
    try {
      isLoading = true;
      setState(() {});

      final dio = Dio();

      final response = await dio.get('https://randomuser.me/api/?page=1&results=20&seed=myusers');

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

  @override
  void initState() {
    super.initState();

    _fetchUsers();
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
      body: ListView(
        padding: EdgeInsets.symmetric(
          vertical: 12,
          horizontal: 24,
        ),
        children: [
          if (!isLoading)
            Text(
              'Usuários',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
          if (!isLoading)
            ListView.builder(
              physics: const BouncingScrollPhysics(),
              shrinkWrap: true,
              itemCount: usersList.length,
              itemBuilder: (_, i) {
                final userMap = usersList[i];
                final icon = userMap['gender'] == 'female' ? Icons.woman : Icons.man;
                final iconColor = userMap['gender'] == 'female' ? Colors.pinkAccent : Colors.blueAccent;

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
                    '${userMap['name']['first']} ${userMap['name']['last']}',
                  ),
                  subtitle: Text(
                    '${userMap['email']}',
                  ),
                  trailing: Icon(
                    icon,
                    color: iconColor,
                  ),
                );
              },
            ),
          if (isLoading)
            SizedBox(
              height: MediaQuery.sizeOf(context).height,
              width: MediaQuery.sizeOf(context).width,
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.center,
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
    );
  }
}
