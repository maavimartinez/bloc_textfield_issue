import 'dart:io';
import 'package:bloc_textfield_issue/authentication/authentication_bloc.dart';
import 'package:bloc_textfield_issue/data/models/user.dart';
import 'package:bloc_textfield_issue/infraestructure/repositories/user_repository.dart';
import 'package:bloc_textfield_issue/presentation/screens/edit_user/bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class EditUserScreen extends StatefulWidget {
  @override
  _EditUserScreenState createState() => _EditUserScreenState();
}

class _EditUserScreenState extends State<EditUserScreen> {
  final _formKey = GlobalKey<FormState>();
  String? fullName;
  bool isFirstTime = true;
  late TextEditingController _nameController;

  @override
  Widget build(BuildContext context) {
    final AuthenticationBloc authenticationBloc =
        BlocProvider.of<AuthenticationBloc>(context);
    return Scaffold(
        appBar: AppBar(),
        resizeToAvoidBottomInset: true,
        body: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: BlocProvider<EditUserBloc>(
                create: (context) => EditUserBloc(
                    userRepository: GetIt.instance<UserRepository>(),
                    authenticationBloc: authenticationBloc),
                child: BlocListener<EditUserBloc, EditUserState>(
                    listener: (context, state) {
                  if (state is EditCompletedState) {
                    Navigator.pop(context);
                  }
                }, child: BlocBuilder<EditUserBloc, EditUserState>(
                        builder: (context, state) {
                  if (isFirstTime && state.user != null) {
                    _nameController =
                        TextEditingController(text: state.user!.fullName);

                    isFirstTime = false;
                  }
                  return SingleChildScrollView(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Center(child: _renderForm()),
                      _renderButton(context, state)
                    ],
                  ));
                })))));
  }

  Widget _renderForm() {
    return SizedBox(
        width: MediaQuery.of(context).orientation == Orientation.portrait
            ? MediaQuery.of(context).size.width * 0.85
            : MediaQuery.of(context).size.width * 0.4,
        child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _renderNameField(),
                Container(height: 20),
              ],
            )));
  }

  Widget _renderNameField() {
    return Container(
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            child: TextFormField(
              keyboardType: TextInputType.name,
              textCapitalization: TextCapitalization.words,
              cursorColor: Theme.of(context).primaryColor,
              style:
                  Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 20),
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return 'Enter a valid name';
                }
              },
              //   initialValue: fullName,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              autocorrect: false,
              controller: _nameController,
              // onChanged: (String? value) {
              //   setState(() {
              //     fullName = value;
              //   });
              // },
              decoration: InputDecoration(
                  errorStyle: Theme.of(context).textTheme.caption!,
                  hintText: 'Full name'),
            )));
  }

  Widget _renderButton(BuildContext context, EditUserState state) {
    if (state is LoadingState) {
      return Padding(
          padding: EdgeInsets.only(bottom: 80),
          child: CircularProgressIndicator());
    } else {
      return Padding(
          padding: EdgeInsets.only(bottom: 80),
          child: MaterialButton(
            onPressed: () => _updateUser(context),
            child: Text('Save changes'),
          ));
    }
  }

  void _updateUser(BuildContext context) {
    if (_formKey.currentState?.validate() ?? false) {
      if (context.read<AuthenticationBloc>().state.user != null) {
        User user = context.read<AuthenticationBloc>().state.user!;
        user = user.copyWith(
          username: 'maavimartinez',
          email: 'maavimartinez@gmail.com',
          fullName: fullName,
        );
        BlocProvider.of<EditUserBloc>(context)
            .add(EditUserSubmittedEvent(avatar: null, user: user));
      }
    }
  }
}
