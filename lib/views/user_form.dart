import 'package:flutter/material.dart';
import 'package:flutter_crud/models/user.dart';
import 'package:flutter_crud/provider/users.dart';
import 'package:provider/provider.dart';

class UserForm extends StatefulWidget {
  UserForm({Key? key}) : super(key: key);

  @override
  State<UserForm> createState() => _UserFormState();
}

class _UserFormState extends State<UserForm> {
  final _form = GlobalKey<FormState>();

  final _formData = {};

  void _loadFormData(User user) {
    _formData['id'] = user.id;
    _formData['name'] = user.name;
    _formData['email'] = user.email;
    _formData['avatarUrl'] = user.avatarUrl;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _formData['id'] = '';
    RouteSettings settings = ModalRoute.of(context)!.settings;
    if (settings.arguments != null) {
      final User user = settings.arguments as User;
      _loadFormData(user);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Formulário de Usuário'),
        actions: [
          IconButton(
              onPressed: () {
                final isValid = _form.currentState!.validate();
                if (isValid) {
                  _form.currentState!.save();

                  Provider.of<Users>(context, listen: false).put(
                    User(
                        id: _formData['id'],
                        name: _formData['name'],
                        email: _formData['email'],
                        avatarUrl: _formData['avatarUrl']),
                  );

                  Navigator.of(context).pop();
                }
              },
              icon: const Icon(Icons.save)),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _form,
          child: Column(
            children: [
              TextFormField(
                initialValue: _formData['name'],
                decoration: const InputDecoration(labelText: 'Nome'),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Campo obrigatório';
                  }

                  int minLength = 5;

                  if (value.trim().length < minLength) {
                    return 'Nome deve conter no mínimo ' +
                        minLength.toString() +
                        ' caracteres.';
                  }
                },
                onSaved: (newValue) => _formData['name'] = newValue!,
              ),
              TextFormField(
                initialValue: _formData['email'],
                decoration: const InputDecoration(labelText: 'E-mail'),
                onSaved: (newValue) => _formData['email'] = newValue!,
              ),
              TextFormField(
                initialValue: _formData['avatarUrl'],
                decoration: const InputDecoration(labelText: 'URL Avatar'),
                onSaved: (newValue) => _formData['avatarUrl'] = newValue!,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
