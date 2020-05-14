import 'package:flutter/material.dart';
import 'package:flutter_crud/models/user.dart';
import 'package:flutter_crud/provider/users.dart';
import 'package:provider/provider.dart';

class UserForm extends StatelessWidget {

  final _form = GlobalKey<FormState>();
  final Map<String, String> _formData = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Formulário de Usuário'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              final isValid = _form.currentState.validate();
              if(isValid){
                _form.currentState.save();

                Provider.of<Users>(context, listen: false).put(
                  User(
                  id: _formData['id'],
                  name: _formData['name'],
                  email: _formData['email'],
                  avatarUrl: _formData['avatarUrl'],
                  ),
                );

                Navigator.of(context).pop();  
              }//if
            },//onPressed
          ),
        ],
      ),

      body: Padding(
        padding: EdgeInsets.all(15),
        child: Form(
          key: _form,
          child: Column(
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(labelText: 'Nome'),
                validator: (value){
                  if(value == null|| value.trim().isEmpty){
                    return 'Nome inválido';
                  }//if
                  
                  if(value.trim().length <3){
                    return 'Nome muito pequeno. No mínimo 3 letras.';
                  }//if
                },//validator

                onSaved: (value) => _formData['name'] = value,

              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'E-mail'),
                onSaved: (value) => _formData['email'] = value,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'URL do Avatar'),
                onSaved: (value) => _formData['avatarUrl'] = value,
              ),
            ],
          )
        )
      ),
    );
  }//Widget
}//class