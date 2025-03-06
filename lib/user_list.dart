// ignore_for_file: sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:untitled10/user.dart';
import 'package:untitled10/user_provider.dart';
import 'package:untitled10/container_all.dart';

class UserList extends StatelessWidget {
  const UserList({super.key});

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = UserProvider.of(context) as UserProvider;

    return Scaffold(
      appBar: AppBar(
        title: Text('User List'),
        leading: BackButton(
          onPressed: () {
            userProvider.userSelected = null;
            Navigator.popAndPushNamed(context, "/create");
          },
        ),
      ),
      body: ContainerAll(
        child: FutureBuilder(
          future:
              userProvider.loadUsers(), // Carrega os usuários do banco de dados
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              ); // Exibe um loading enquanto os dados são carregados
            }

            if (userProvider.users.isEmpty) {
              return Center(
                child: Text("Nenhum usuário cadastrado."),
              ); // Mensagem se a lista estiver vazia
            }

            return ListView.builder(
              itemCount: userProvider.users.length,
              itemBuilder:
                  (BuildContext contextBuilder, indexBuilder) => Container(
                    child: ListTile(
                      title: Text(userProvider.users[indexBuilder].name),
                      subtitle: Text(userProvider.users[indexBuilder].email),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            onPressed: () {
                              userProvider.userSelected =
                                  userProvider.users[indexBuilder];
                              userProvider.indexUser = indexBuilder;
                              Navigator.popAndPushNamed(context, "/create");
                            },
                            icon: Icon(Icons.edit),
                          ),
                          IconButton(
                            onPressed: () {
                              userProvider.userSelected =
                                  userProvider.users[indexBuilder];
                              userProvider.indexUser = indexBuilder;
                              Navigator.popAndPushNamed(context, "/view");
                            },
                            icon: Icon(Icons.visibility, color: Colors.blue),
                          ),
                          IconButton(
                            onPressed: () async {
                              await userProvider.deleteUser(
                                userProvider.users[indexBuilder].id!,
                              );
                              Navigator.popAndPushNamed(context, "/list");
                            },
                            icon: Icon(Icons.delete, color: Colors.red),
                          ),
                        ],
                      ),
                    ),
                    decoration: BoxDecoration(
                      border: Border(bottom: BorderSide(width: 0.4)),
                    ),
                  ),
            );
          },
        ),
      ),
    );
  }
}
