import 'package:flutter/cupertino.dart';
import 'package:untitled10/database_helper.dart';
import 'user.dart';

class UserProvider extends InheritedWidget with ChangeNotifier {
  final Widget child;
  final DatabaseHelper _dbHelper = DatabaseHelper();
  List<User> users = [];
  User? userSelected;
  int? indexUser;

  UserProvider({required this.child}) : super(child: child);

  static UserProvider? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<UserProvider>();
  }

  Future<void> loadUsers() async {
    users = await _dbHelper.getUsers(); // Carrega os usuários do banco de dados
    notifyListeners(); // Notifica os ouvintes após carregar os usuários
  }

  Future<void> addUser(User user) async {
    await _dbHelper.insertUser(user); // Insere o usuário no banco de dados
    await loadUsers(); // Recarrega os usuários após adicionar um novo
  }

  Future<void> deleteUser(int id) async {
    await _dbHelper.deleteUser(id); // Deleta o usuário do banco de dados
    await loadUsers(); // Recarrega os usuários após deletar
  }

  @override
  bool updateShouldNotify(UserProvider oldWidget) {
    return true;
  }
}
