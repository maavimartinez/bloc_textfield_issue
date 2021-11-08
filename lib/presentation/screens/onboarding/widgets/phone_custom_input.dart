import 'package:bloc_textfield_issue/presentation/utils/custom_decorations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PhoneCustomInput extends StatefulWidget {
  final String? phoneNumber;
  final onSubmit;
  final refreshParent;
  final double fieldHeight;
  final double? fontSize;
  final bool isTextObscure;
  final bool? showFieldAsBox;
  final bool autofocus;
  final BoxConstraints constraints;

  PhoneCustomInput(
      {this.phoneNumber,
      this.refreshParent,
      required this.constraints,
      this.autofocus = false,
      this.onSubmit,
      required this.fieldHeight,
      this.fontSize: 20.0,
      this.isTextObscure: false,
      this.showFieldAsBox: false});

  @override
  _PhoneCustomInputState createState() => new _PhoneCustomInputState();
}

class _PhoneCustomInputState extends State<PhoneCustomInput> {
  late List<FocusNode> _focusNodes;
  TextEditingController controller1 = TextEditingController();
  TextEditingController controller2 = TextEditingController();
  TextEditingController controller3 = TextEditingController();
  late TextStyle hintStyle;
  late TextStyle style;

  @override
  void initState() {
    super.initState();
    hintStyle = TextStyle(
        fontFamily: 'OpenSans',
        fontWeight: FontWeight.w500,
        color: Colors.black,
        fontSize: widget.fontSize);
    style = TextStyle(
        fontFamily: 'OpenSans',
        fontWeight: FontWeight.w500,
        color: Colors.grey,
        fontSize: widget.fontSize);
    _focusNodes = List.generate(3, (i) => FocusNode());
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      setState(() {
        print(widget.phoneNumber);
        if (widget.phoneNumber != null) {
          for (var phoneDigitPos = 0;
              phoneDigitPos < widget.phoneNumber!.length;
              phoneDigitPos++) {
            if (phoneDigitPos < 3) {
              controller1.text =
                  controller1.text + widget.phoneNumber![phoneDigitPos];
              controller1.selection = TextSelection.fromPosition(
                  TextPosition(offset: controller1.text.length));
            } else if (phoneDigitPos >= 3 && phoneDigitPos <= 5) {
              controller2.text =
                  controller2.text + widget.phoneNumber![phoneDigitPos];
              controller2.selection = TextSelection.fromPosition(
                  TextPosition(offset: controller2.text.length));
            } else {
              controller3.text =
                  controller3.text + widget.phoneNumber![phoneDigitPos];
              controller3.selection = TextSelection.fromPosition(
                  TextPosition(offset: controller3.text.length));
            }
          }
        }
      });
    });
    _focusNodes[0].requestFocus();
  }

  @override
  void dispose() {
    controller1.dispose();
    controller2.dispose();
    controller3.dispose();
    super.dispose();
  }

  void clearTextFields() {
    controller1.clear();
    controller2.clear();
    controller3.clear();
  }

  Widget _firstTextFormField() {
    _focusNodes[0].addListener(() {
      if (_focusNodes[0].hasFocus) {}
    });

    return Container(
        width: widget.constraints.maxWidth * 0.2,
        margin: EdgeInsets.only(right: 0.0),
        child: TextField(
            autofocus: widget.autofocus,
            controller: controller1,
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
            maxLength: 3,
            style: style,
            focusNode: _focusNodes[0],
            decoration: InputDecoration(
                border: InputBorder.none,
                hintText: '000',
                fillColor: Colors.white,
                focusColor: Colors.white,
                hoverColor: Colors.white,
                hintStyle: hintStyle,
                counterText: "",
                filled: false),
            onChanged: (String str) {
              setState(() {
                controller1.text = str;
                controller1.selection = TextSelection.fromPosition(
                    TextPosition(offset: controller1.text.length));
              });
              if (controller1.text.length == 3) {
                _focusNodes[0].unfocus();
                FocusScope.of(context).requestFocus(_focusNodes[1]);
              }
              final text =
                  '${controller1.text}${controller2.text}${controller3.text}';
              widget.refreshParent(text);
            }));
  }

  Widget _secondTextFormField() {
    _focusNodes[1].addListener(() {
      if (_focusNodes[1].hasFocus) {}
    });

    return Container(
        width: widget.constraints.maxWidth * 0.2,
        margin: EdgeInsets.only(right: 0.0),
        child: RawKeyboardListener(
            focusNode: FocusNode(),
            onKey: (event) {
              if (event.logicalKey == LogicalKeyboardKey.backspace &&
                  controller2.text == '') {
                _focusNodes[0].requestFocus();
              }
            },
            child: TextField(
                autofocus: widget.autofocus,
                controller: controller2,
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                maxLength: 3,
                style: style,
                focusNode: _focusNodes[1],
                decoration: InputDecoration(
                    border: InputBorder.none,
                    fillColor: Colors.white,
                    hintText: '000',
                    hintStyle: hintStyle,
                    focusColor: Colors.white,
                    hoverColor: Colors.white,
                    counterText: "",
                    filled: false),
                onChanged: (String str) {
                  setState(() {
                    controller2.text = str;
                    controller2.selection = TextSelection.fromPosition(
                        TextPosition(offset: controller2.text.length));
                  });
                  if (controller2.text.length == 3) {
                    _focusNodes[1].unfocus();
                    FocusScope.of(context).requestFocus(_focusNodes[2]);
                  }
                  final text =
                      '${controller1.text}${controller2.text}${controller3.text}';
                  widget.refreshParent(text);
                })));
  }

  Widget _thirdTextFormField() {
    _focusNodes[2].addListener(() {
      if (_focusNodes[2].hasFocus) {}
    });

    return Container(
        width: widget.constraints.maxWidth * 0.4,
        margin: EdgeInsets.only(right: 0.0),
        child: RawKeyboardListener(
            focusNode: FocusNode(),
            onKey: (event) {
              if (event.logicalKey == LogicalKeyboardKey.backspace &&
                  controller3.text == '') {
                _focusNodes[1].requestFocus();
              }
            },
            child: TextField(
                autofocus: widget.autofocus,
                controller: controller3,
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                maxLength: 4,
                style: style,
                focusNode: _focusNodes[2],
                decoration: InputDecoration(
                    border: InputBorder.none,
                    fillColor: Colors.white,
                    focusColor: Colors.white,
                    hoverColor: Colors.white,
                    hintText: '0000',
                    hintStyle: hintStyle,
                    counterText: "",
                    filled: false),
                onChanged: (String str) {
                  setState(() {
                    controller3.text = str;
                    controller3.selection = TextSelection.fromPosition(
                        TextPosition(offset: controller3.text.length));
                  });
                  final text =
                      '${controller1.text}${controller2.text}${controller3.text}';
                  widget.refreshParent(text);
                })));
  }

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Text('(',
          style: TextStyle(
              fontFamily: 'OpenSans',
              fontWeight: FontWeight.w500,
              color: Colors.black,
              fontSize: widget.fontSize)),
      _firstTextFormField(),
      Text(')',
          style: TextStyle(
              fontFamily: 'OpenSans',
              fontWeight: FontWeight.w500,
              color: Colors.black,
              fontSize: widget.fontSize)),
      _secondTextFormField(),
      Text('-',
          style: TextStyle(
              fontFamily: 'OpenSans',
              fontWeight: FontWeight.w500,
              color: Colors.black,
              fontSize: widget.fontSize)),
      _thirdTextFormField()
    ]);
  }
}
