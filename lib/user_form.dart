import 'package:flutter/material.dart';
import 'package:untitled10/fild_form.dart';
import 'package:untitled10/user.dart';
import 'package:untitled10/user_provider.dart';
import 'package:untitled10/container_all.dart';

class UserForm extends StatefulWidget {
  const UserForm({super.key});

  @override
  State<UserForm> createState() => _UserFormState();
}

class _UserFormState extends State<UserForm> {
  String title = "Create contact";

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
      setState(() {
        this.title = "Edit contact";
      });
    }

    GlobalKey<FormState> _key = GlobalKey();

    void save() async {
      final isValidate = _key.currentState?.validate();
      if (isValidate == false) {
        return;
      }
      _key.currentState?.save();

      User user = User(
        name: controllerName.text,
        email: controllerEmail.text,
        password: controllerPassword.text,
      );

      if (index != null) {
        // Atualiza o usuário existente
        user.id = userProvider.userSelected!.id;
        await userProvider.addUser(user);
      } else {
        // Adiciona um novo usuário
        await userProvider.addUser(user);
      }

      Navigator.popAndPushNamed(context, "/list");
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(this.title),
        actions: [
          Container(
            child: TextButton(
              child: Text("Contact list"),
              onPressed: () {
                Navigator.popAndPushNamed(context, "/list");
              },
            ),
            margin: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
          ),
        ],
      ),
      body: ContainerAll(
        child: Center(
          child: Form(
            key: _key,
            child: Column(
              children: [
                FildForm(
                  Label: "Name",
                  isPassword: false,
                  controller: controllerName,
                  isEmail: false,
                ),
                FildForm(
                  Label: "Number",
                  isPassword: false,
                  controller: controllerEmail,
                  isEmail: true,
                ),
                FildForm(
                  Label: "Details",
                  isPassword: true,
                  controller: controllerPassword,
                  isEmail: false,
                ),
                SizedBox(
                  width: double.infinity,
                  child: TextButton(
                    onPressed: save,
                    child: Text("Save"),
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all(
                        Theme.of(context).primaryColor,
                      ),
                      foregroundColor: WidgetStateProperty.all(Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
