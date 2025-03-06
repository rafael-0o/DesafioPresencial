import 'package:flutter/material.dart';
import 'package:untitled10/fild_form.dart';
import 'package:untitled10/user.dart';
import 'package:untitled10/user_provider.dart';
import 'package:untitled10/container_all.dart';

class UserView extends StatelessWidget {
  UserView({super.key});

  String title = " Show User";

  TextEditingController controllerName = TextEditingController();
  TextEditingController controllerEmail = TextEditingController();
  TextEditingController controllerPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = UserProvider.of(context) as UserProvider;

    int? index;

    if (userProvider.indexUser != null) {
      index = userProvider.indexUser;
      controllerName.text = userProvider.userSelected!.name;
      controllerEmail.text = userProvider.userSelected!.email;
      controllerPassword.text = userProvider.userSelected!.password;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(this.title),
        actions: [
          Container(
            child: TextButton(
              child: Text("User list"),
              onPressed: () {
                Navigator.popAndPushNamed(context, "/list");
              },
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
            margin: EdgeInsets.all(8),
          ),
        ],
      ),
      body: ContainerAll(
        child: Center(
          child: Column(
            children: [
              FildForm(
                Label: "Name",
                isPassword: false,
                controller: controllerName,
                isForm: false,
                isEmail: false,
              ),
              FildForm(
                Label: "Number",
                isPassword: false,
                controller: controllerEmail,
                isForm: false,
                isEmail: false,
              ),
              FildForm(
                Label: "Details",
                isPassword: false,
                controller: controllerPassword,
                isForm: false,
                isEmail: false,
              ),
              SizedBox(
                width: double.infinity,
                child: TextButton(
                  onPressed: () {
                    Navigator.popAndPushNamed(context, "/create");
                  },
                  child: Text("Edit"),
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all(
                      Theme.of(context).primaryColor,
                    ),
                    foregroundColor: WidgetStateProperty.all(Colors.white),
                  ),
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: TextButton(
                  onPressed: () async {
                    await userProvider.deleteUser(
                      userProvider.userSelected!.id!,
                    );
                    Navigator.popAndPushNamed(context, "/list");
                  },
                  child: Text("Delete"),
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all(Colors.red),
                    foregroundColor: WidgetStateProperty.all(Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
