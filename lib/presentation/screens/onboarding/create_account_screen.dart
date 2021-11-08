// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// import 'bloc/bloc.dart';

// class CreateAccountScreen extends StatefulWidget {
//   @override
//   _CreateAccountScreenState createState() => _CreateAccountScreenState();
// }

// class _CreateAccountScreenState extends State<CreateAccountScreen> {
//   final _formKey = GlobalKey<FormState>();
//   String? email;
//   //String? username;
//   String? fullName;
//   File? avatar;
//   String? emailError;
//   bool _checkingUsernameAvailability = false;
//   bool? usernameAvailable;
//   FocusNode usernameNode = FocusNode();
//   bool firstFocusUsername = false;
//   DateTime? birthdate;
//   final TextEditingController usernameController = TextEditingController();

//   @override
//   void initState() {
//     usernameNode.addListener(hasFocusUsername);
//     super.initState();
//   }

//   void hasFocusUsername() {
//     if (usernameNode.hasFocus) firstFocusUsername = true;
//   }

//   @override
//   Widget build(BuildContext context) {
//     final AuthenticationBloc authenticationBloc =
//         BlocProvider.of<AuthenticationBloc>(context);
//     return Scaffold(
//         resizeToAvoidBottomInset: true,
//         body: Container(
//             width: MediaQuery.of(context).size.width,
//             height: MediaQuery.of(context).size.height,
//             child: BlocProvider<LoginBloc>(
//                 create: (context) => LoginBloc(
//                     userRepository: GetIt.instance<UserRepository>(),
//                     authenticationBloc: authenticationBloc),
//                 child: BlocListener<LoginBloc, LoginState>(
//                     listener: (context, loginState) {
//                   if (loginState is LoginCompleteState) {
//                     Navigator.pushAndRemoveUntil(
//                         context,
//                         MaterialPageRoute(
//                             builder: (context) => BlocProvider.value(
//                                 value: authenticationBloc,
//                                 child: HomeScreen())),
//                         (route) => false);
//                   } else if (loginState is ExceptionState) {
//                     if (loginState.message.contains('email')) {
//                       setState(() {
//                         emailError = loginState.message;
//                       });
//                     }
//                   }
//                 }, child: BlocBuilder<LoginBloc, LoginState>(
//                         builder: (context, state) {
//                   return SingleChildScrollView(
//                       child: Column(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     children: [
//                       _renderLogo(),
//                       Center(child: _renderForm()),
//                       _renderButton(context, state)
//                     ],
//                   ));
//                 })))));
//   }

//   Widget _renderLogo() {
//     return Align(
//         alignment: Alignment.topLeft,
//         child: Padding(
//             padding: EdgeInsets.only(top: 35, left: 15),
//             child: Image.asset('assets/img/gradient-logo.png',
//                 height: Responsive.onboardingLogoHeight(context))));
//   }

//   Widget _renderForm() {
//     return SizedBox(
//         width: MediaQuery.of(context).orientation == Orientation.portrait
//             ? MediaQuery.of(context).size.width * 0.85
//             : MediaQuery.of(context).size.width * 0.4,
//         child: Form(
//             key: _formKey,
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.spaceAround,
//               children: [
//                 _renderAvatar(),
//                 Container(height: 20),
//                 _renderNameField(),
//                 Container(height: 20),
//                 _renderEmailField(),
//                 Container(height: 20),
//                 _renderUsernameField(),
//                 Container(height: 20),
//                 _renderBirthdateField(),
//                 Container(height: 40),
//               ],
//             )));
//   }

//   Widget _renderNameField() {
//     return Container(
//         decoration: CustomDecorations.textFormField(),
//         child: Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
//             child: TextFormField(
//               keyboardType: TextInputType.name,
//               textCapitalization: TextCapitalization.words,
//               cursorColor: Theme.of(context).primaryColor,
//               style: Theme.of(context)
//                   .textTheme
//                   .bodyText1!
//                   .copyWith(fontSize: Responsive.fontSize20(context)),
//               validator: (String? value) {
//                 if (value == null || value.isEmpty) {
//                   return 'Enter a valid name';
//                 }
//               },
//               autovalidateMode: AutovalidateMode.onUserInteraction,
//               autocorrect: false,
//               onChanged: (String? value) async {
//                 setState(() {
//                   fullName = value;
//                 });
//                 if (fullName != null && firstFocusUsername == false) {
//                   setState(() {
//                     usernameController.text =
//                         fullName?.replaceAll(' ', '').toLowerCase() ?? '';

//                     _checkingUsernameAvailability = true;
//                   });
//                   if (usernameController.text.length > 6) {
//                     usernameAvailable = await GetIt.instance<UserRepository>()
//                         .usernameAvailabilityCheck(
//                             username: usernameController.text);
//                   }
//                   setState(() {
//                     _checkingUsernameAvailability = false;
//                   });
//                 }
//               },
//               initialValue: fullName,
//               decoration: InputDecoration(
//                   errorStyle: Theme.of(context)
//                       .textTheme
//                       .caption!
//                       .copyWith(fontSize: Responsive.fontSize13(context)),
//                   border: InputBorder.none,
//                   hintStyle: Theme.of(context).textTheme.bodyText1!.copyWith(
//                       fontSize: Responsive.fontSize20(context),
//                       color: Palette.concrete),
//                   hintText: 'Full name'),
//             )));
//   }

//   Widget _renderEmailField() {
//     return Container(
//         decoration: CustomDecorations.textFormField(),
//         child: Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
//             child: TextFormField(
//               keyboardType: TextInputType.emailAddress,
//               textCapitalization: TextCapitalization.none,
//               cursorColor: Theme.of(context).primaryColor,
//               style: Theme.of(context)
//                   .textTheme
//                   .bodyText1!
//                   .copyWith(fontSize: Responsive.fontSize20(context)),
//               validator: (String? value) {
//                 if (emailError != null) {
//                   return emailError;
//                 } else if (!EmailValidator.validate(value ?? '')) {
//                   return 'Enter a valid email';
//                 }
//               },
//               initialValue: email,
//               onChanged: (String? value) {
//                 setState(() {
//                   email = value;
//                   emailError = null;
//                 });
//               },
//               autovalidateMode: AutovalidateMode.onUserInteraction,
//               autocorrect: false,
//               decoration: InputDecoration(
//                   errorStyle: Theme.of(context)
//                       .textTheme
//                       .caption!
//                       .copyWith(fontSize: Responsive.fontSize13(context)),
//                   border: InputBorder.none,
//                   hintStyle: Theme.of(context).textTheme.bodyText1!.copyWith(
//                       fontSize: Responsive.fontSize20(context),
//                       color: Palette.concrete),
//                   hintText: 'Email'),
//             )));
//   }

//   Widget _renderUsernameField() {
//     return Container(
//         decoration: CustomDecorations.textFormField(),
//         child: Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
//             child: TextFormField(
//               autovalidateMode: AutovalidateMode.onUserInteraction,
//               keyboardType: TextInputType.name,
//               cursorColor: Theme.of(context).primaryColor,
//               style: Theme.of(context)
//                   .textTheme
//                   .bodyText1!
//                   .copyWith(fontSize: Responsive.fontSize20(context)),
//               validator: (String? value) {
//                 if (value == null || value.isEmpty || value.length < 6) {
//                   return 'Username must be longer than 6 characters';
//                 } else if (usernameAvailable == false) {
//                   return 'Username already taken';
//                 }
//               },
//               controller: usernameController,
//               //autocorrect: false,
//               onChanged: (String? value) async {
//                 setState(() => _checkingUsernameAvailability = true);
//                 if (value != null && value.length > 6) {
//                   usernameAvailable = await GetIt.instance<UserRepository>()
//                       .usernameAvailabilityCheck(username: value);
//                 }
//                 setState(() {
//                   _checkingUsernameAvailability = false;
//                   usernameController.text = value ?? '';
//                 });
//               },
//               decoration: InputDecoration(
//                   errorStyle: Theme.of(context)
//                       .textTheme
//                       .caption!
//                       .copyWith(fontSize: Responsive.fontSize13(context)),
//                   border: InputBorder.none,
//                   suffixIcon: _checkingUsernameAvailability
//                       ? Container(
//                           child: Padding(
//                           padding: const EdgeInsets.all(8),
//                           child: CircularProgressIndicator(
//                             strokeWidth: 2,
//                           ),
//                         ))
//                       : usernameAvailable != null
//                           ? (usernameAvailable == true
//                               ? Icon(Icons.check_sharp, color: Colors.green)
//                               : Icon(Icons.cancel, color: Colors.red))
//                           : null,
//                   hintStyle: Theme.of(context).textTheme.bodyText1!.copyWith(
//                       fontSize: Responsive.fontSize20(context),
//                       color: Palette.concrete),
//                   hintText: 'Username'),
//             )));
//   }

//   Widget _renderBirthdateField() {
//     return Container(
//         decoration: CustomDecorations.textFormField(),
//         child: Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text('Birth date',
//                     style: Theme.of(context)
//                         .textTheme
//                         .bodyText1!
//                         .copyWith(fontSize: Responsive.fontSize20(context))),
//                 ClickableItem(
//                     onTap: () {
//                       _selectDate(context);
//                     },
//                     child: Text(
//                         birthdate == null
//                             ? 'MM/DD/YYYY'
//                             : DateFormat('MMM dd, yyyy').format(birthdate!),
//                         style: birthdate != null
//                             ? Theme.of(context).textTheme.bodyText1!.copyWith(
//                                 fontSize: Responsive.fontSize20(context))
//                             : Theme.of(context).textTheme.bodyText1!.copyWith(
//                                 fontSize: Responsive.fontSize20(context),
//                                 color: Palette.concrete)))
//               ],
//             )));
//   }

//   Future<void> _selectDate(BuildContext context) async {
//     final DateTime? picked = (await showDatePicker(
//         context: context,
//         initialDate: birthdate ?? DateTime.now(),
//         firstDate: DateTime(1900),
//         lastDate: DateTime.now(),
//         builder: (BuildContext context, Widget? child) {
//           return Theme(
//             data: ThemeData.light().copyWith(
//               colorScheme: ColorScheme.light(
//                 primary: Palette.orange1,
//                 onPrimary: Colors.white,
//                 surface: Colors.white,
//                 onSurface: Colors.black,
//               ),
//               dialogBackgroundColor: Colors.white,
//             ),
//             child: child ?? Container(),
//           );
//         }));
//     if (picked != null) {
//       setState(() {
//         birthdate = picked;
//       });
//     }
//   }

//   Widget _renderButton(BuildContext context, LoginState state) {
//     if (state is LoadingState) {
//       return Padding(
//           padding: EdgeInsets.only(bottom: 80),
//           child: CircularProgressIndicator());
//     } else {
//       return Padding(
//           padding: EdgeInsets.only(bottom: 80),
//           child: SolidButton(
//             isDisabled: false,
//             action: () => _updateUser(context),
//             backgroundColor: Palette.orange1,
//             color: Palette.white,
//             disabledColor: Palette.orange1.withOpacity(0.6),
//             elevation: true,
//             width: MediaQuery.of(context).orientation == Orientation.portrait
//                 ? MediaQuery.of(context).size.width * 0.85
//                 : MediaQuery.of(context).size.width * 0.3,
//             tallPadding: true,
//             text: 'Create Account',
//           ));
//     }
//   }

//   Widget _renderAvatar() {
//     Widget showAvatar;
//     final avatarSize = MediaQuery.of(context).size.height * 0.2;
//     if (avatar != null) {
//       showAvatar = Container(
//           height: avatarSize,
//           width: avatarSize,
//           decoration: BoxDecoration(
//               borderRadius: const BorderRadius.all(Radius.circular(10000)),
//               image: DecorationImage(
//                   image: FileImage(avatar!), fit: BoxFit.cover)));
//     } else {
//       showAvatar = Container(
//         decoration: BoxDecoration(
//             color: Palette.orange1,
//             border: Border.all(color: Colors.white, width: 5),
//             borderRadius: const BorderRadius.all(Radius.circular(1000))),
//         alignment: Alignment.centerLeft,
//       );
//     }
//     final child = Container(
//         height: avatarSize,
//         width: avatarSize,
//         alignment: Alignment.centerLeft,
//         child: Stack(children: [
//           showAvatar,
//           Container(
//             height: avatarSize,
//             width: avatarSize,
//             decoration:
//                 BoxDecoration(borderRadius: BorderRadius.circular(10000)),
//             child: Padding(
//                 padding: const EdgeInsets.all(40),
//                 child: Icon(Icons.camera_alt, size: 40, color: Colors.white)),
//           )
//         ]));
//     return CustomImagePicker(child, changeAvatar,
//         isBanner: false, shape: BoxShape.circle);
//   }

//   void changeAvatar(File file) async {
//     setState(() {
//       avatar = File(file.path);
//     });
//   }

//   void _updateUser(BuildContext context) {
//     if (_formKey.currentState?.validate() ?? false) {
//       BlocProvider.of<LoginBloc>(context).add(CreateAccountEvent(
//           birthdate: birthdate,
//           email: email ?? '',
//           avatar: avatar,
//           fullName: fullName ?? '',
//           username: usernameController.value.text));
//     }
//   }
// }
