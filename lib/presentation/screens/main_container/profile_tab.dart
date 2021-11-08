import 'package:bloc_textfield_issue/authentication/authentication_bloc.dart';
import 'package:bloc_textfield_issue/authentication/authentication_event.dart';
import 'package:bloc_textfield_issue/data/models/user.dart';
import 'package:bloc_textfield_issue/presentation/screens/edit_user/screens/edit_user_screen.dart';
import 'package:bloc_textfield_issue/presentation/utils/custom_decorations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/main_container_bloc.dart';
import 'bloc/main_container_state.dart';

class ProfileTab extends StatefulWidget {
  final BuildContext context;
  const ProfileTab(this.context);
  @override
  _ProfileTabState createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  final scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        body: BlocBuilder<MainContainerBloc, MainContainerState>(
            bloc: BlocProvider.of<MainContainerBloc>(context),
            builder: (BuildContext context, MainContainerState state) {
              final user =
                  context.select((MainContainerBloc bloc) => bloc.state.user);
              return SingleChildScrollView(
                  physics: NeverScrollableScrollPhysics(),
                  child: Column(children: [
                    _renderLogoAndLogout(),
                    Container(
                        height: MediaQuery.of(context).size.height * 0.8,
                        child: ListView(children: [
                          Container(height: 20),
                          _renderAccountInfoCard(user),
                          Container(height: 20),
                          Container(height: 40)
                        ]))
                  ]));
            }));
  }

  Widget _renderAccountInfoCard(User? user) {
    if (user != null) {
      if (MediaQuery.of(context).orientation == Orientation.portrait) {
        return Container(
          margin: EdgeInsets.symmetric(horizontal: 25),
          padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
          decoration: CustomDecorations.elevatedButtonBoxDecoration(
              backgroundColor: Colors.white),
          child: Column(children: [
            Container(width: 30),
            Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(
                    Icons.edit,
                    color: Colors.transparent,
                    size: 25,
                  ),
                  _renderAvatar(user),
                  GestureDetector(
                      onTap: () => _goToEditUser(),
                      child: Icon(
                        Icons.edit,
                        color: Colors.black,
                        size: 25,
                      ))
                ]),
            Container(width: 30),
            _renderUserInfo(user)
          ]),
        );
      } else {
        return Container(
          margin: EdgeInsets.symmetric(horizontal: 25),
          padding: EdgeInsets.symmetric(vertical: 15, horizontal: 40),
          decoration: CustomDecorations.elevatedButtonBoxDecoration(
              backgroundColor: Colors.white),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(children: [
                Container(width: 30),
                _renderAvatar(user),
                Container(width: 30),
                _renderUserInfo(user)
              ]),
              GestureDetector(
                  onTap: () => _goToEditUser(),
                  child: Icon(
                    Icons.edit,
                    color: Colors.black,
                    size: 25,
                  ))
            ],
          ),
        );
      }
    } else {
      return Container();
    }
  }

  Widget _renderAvatar(User user) {
    if (user.avatarUrl != null) {
      return Container(
          height: MediaQuery.of(context).size.height * 0.15,
          width: MediaQuery.of(context).size.height * 0.15,
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(10000)),
              image: DecorationImage(
                  image: NetworkImage(user.avatarUrl!), fit: BoxFit.cover)));
    } else {
      return Container(
          height: MediaQuery.of(context).size.height * 0.15,
          width: MediaQuery.of(context).size.height * 0.15,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(10000)),
            gradient: LinearGradient(
              end: const Alignment(0.0, -1),
              begin: const Alignment(0.0, 0.9),
              colors: <Color>[Colors.pink, Colors.pinkAccent],
            ),
          ),
          child: Icon(Icons.person, color: Colors.white, size: 60));
    }
  }

  Widget _renderUserInfo(User user) {
    return Column(
      crossAxisAlignment:
          MediaQuery.of(context).orientation == Orientation.portrait
              ? CrossAxisAlignment.center
              : CrossAxisAlignment.start,
      children: [
        Text(
          user.fullName ?? '',
          style: Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 20),
        ),
        Text(
          '@${user.username}',
          style: Theme.of(context)
              .textTheme
              .bodyText1!
              .copyWith(fontSize: 18, fontWeight: FontWeight.w500),
        ),
        Text(
          user.email ?? '',
          style: Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 18),
        ),
        Text(
          user.phone,
          style: Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 18),
        ),
      ],
    );
  }

  Widget _renderLogoAndLogout() {
    final AuthenticationBloc authenticationBloc =
        BlocProvider.of<AuthenticationBloc>(context);
    return LayoutBuilder(builder: (context, constraints) {
      return Padding(
          padding: EdgeInsets.only(top: 35, left: 15, right: 15),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                MaterialButton(
                  child: Text('Logout'),
                  onPressed: () => authenticationBloc.add(LoggedOut()),
                )
              ]));
    });
  }

  void _goToEditUser() {
    Navigator.push(
      widget.context,
      MaterialPageRoute(
          builder: (context) => BlocProvider.value(
              value: BlocProvider.of<AuthenticationBloc>(widget.context),
              child: EditUserScreen())),
    );
  }
}
