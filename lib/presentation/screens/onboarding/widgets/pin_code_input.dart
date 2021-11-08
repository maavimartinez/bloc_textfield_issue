// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:tablet_app/presentation/utils/custom_decorations.dart';
// import 'package:tablet_app/presentation/utils/palette.dart';

// class PinCodeInput extends StatefulWidget {
//   final String? lastPin;
//   final int fields;
//   final onSubmit;
//   final refreshParent;
//   final double fieldHeight;
//   final double? fontSize;
//   final bool isTextObscure;
//   final bool? showFieldAsBox;
//   final bool autofocus;

//   PinCodeInput(
//       {this.lastPin,
//       this.fields: 4,
//       this.refreshParent,
//       this.autofocus = false,
//       this.onSubmit,
//       required this.fieldHeight,
//       this.fontSize: 20.0,
//       this.isTextObscure: false,
//       this.showFieldAsBox: false})
//       : assert(fields > 0);

//   @override
//   _PinCodeInputState createState() => new _PinCodeInputState();
// }

// class _PinCodeInputState extends State<PinCodeInput> {
//   late List<FocusNode> _focusNodes;
//   late List<TextEditingController> _textControllers;
//   late List<String> _pin;

//   Widget textfields = Container();

//   @override
//   void initState() {
//     super.initState();
//     _pin = List<String>.filled(widget.fields, '');
//     _focusNodes = List.generate(widget.fields, (i) => FocusNode());
//     _textControllers =
//         List.generate(widget.fields, (i) => TextEditingController());
//     WidgetsBinding.instance!.addPostFrameCallback((_) {
//       setState(() {
//         if (widget.lastPin != null) {
//           for (var i = 0; i < widget.lastPin!.length; i++) {
//             _pin[i] = widget.lastPin![i];
//           }
//         }
//         textfields = generateTextFields(context);
//       });
//     });
//   }

//   @override
//   void dispose() {
//     _textControllers.forEach((TextEditingController t) => t.dispose());
//     super.dispose();
//   }

//   Widget generateTextFields(BuildContext context) {
//     List<Widget> textFields = List.generate(widget.fields, (int i) {
//       return buildTextField(i, context);
//     });

//     if (_pin.first != null) {
//       FocusScope.of(context).requestFocus(_focusNodes[0]);
//     }

//     return Row(
//         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//         verticalDirection: VerticalDirection.down,
//         children: textFields);
//   }

//   void clearTextFields() {
//     _textControllers.forEach(
//         (TextEditingController tEditController) => tEditController.clear());
//     _pin.clear();
//   }

//   Widget buildTextField(int i, BuildContext context) {
//     if (widget.lastPin != null) {
//       _textControllers[i].text = widget.lastPin![i];
//     }

//     _focusNodes[i].addListener(() {
//       if (_focusNodes[i].hasFocus) {}
//     });

//     final String lastDigit = _textControllers[i].text;

//     return Container(
//       width: widget.fieldHeight,
//       height: widget.fieldHeight,
//       margin: EdgeInsets.only(right: 0.0),
//       decoration: CustomDecorations.textFormField(),
//       child: RawKeyboardListener(
//           focusNode: FocusNode(), // or FocusNode()
//           onKey: (event) {
//             if (event.logicalKey == LogicalKeyboardKey.backspace &&
//                 lastDigit == '') {
//               if (i != 0) {
//                 _focusNodes[i - 1].requestFocus();
//               }
//             }
//           },
//           child: TextField(
//               autofocus: widget.autofocus,
//               keyboardType: TextInputType.number,
//               controller: _textControllers[i],
//               textAlign: TextAlign.center,
//               maxLength: 1,
//               style: TextStyle(
//                   fontFamily: 'OpenSans',
//                   fontWeight: FontWeight.w500,
//                   color: Palette.darkGrey,
//                   fontSize: widget.fontSize),
//               focusNode: _focusNodes[i],
//               obscureText: widget.isTextObscure,
//               decoration: InputDecoration(
//                   border: InputBorder.none,
//                   fillColor: Colors.white,
//                   focusColor: Colors.white,
//                   hoverColor: Colors.white,
//                   counterText: "",
//                   filled: false),
//               onChanged: (String str) {
//                 setState(() {
//                   _pin[i] = str;
//                 });
//                 if (i != widget.fields - 1 && i != 0) {
//                   if (i + 1 != widget.fields) {
//                     _focusNodes[i].unfocus();
//                     if (_pin[i] == '') {
//                       FocusScope.of(context).requestFocus(_focusNodes[i - 1]);
//                     } else {
//                       FocusScope.of(context).requestFocus(_focusNodes[i + 1]);
//                     }
//                   } else {
//                     _focusNodes[i].unfocus();
//                     if (_pin[i] == '') {
//                       FocusScope.of(context).requestFocus(_focusNodes[i - 1]);
//                     }
//                   }
//                 }
//                 widget.refreshParent(i, str);
//               })),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return textfields;
//   }
// }
