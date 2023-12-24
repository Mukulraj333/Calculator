import 'package:calcu/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(const MaterialApp(
    home: CalculatorApp(),
    debugShowCheckedModeBanner: false,
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: CalculatorApp(),
      title: 'Calculator App',
      debugShowCheckedModeBanner: false,
    );
  }
}

class CalculatorApp extends StatefulWidget {
  const CalculatorApp({Key? key}) : super(key: key);

  @override
  State<CalculatorApp> createState() => _CalculatorAppState();
}

class _CalculatorAppState extends State<CalculatorApp> {
  double fir_N = 0.0;
  double sec_N = 0.0;
  var inp = '';
  var out = '';
  var operation = '';
  var hideInp = false;
  var outSize = 34.0;

  onButtonClick(value) {
    if (value == "AC") {
      inp = '';
      out = '';
    } else if (value == "<") {
      if (inp.isNotEmpty) {
        inp = inp.substring(0, inp.length - 1);
      }
    } else if (value == "=") {
      if (inp.isNotEmpty) {
        // Remove the following line:
        // inp = inp.substring(0, inp.length - 1);

        var userInp = inp;
        userInp = inp.replaceAll("x", "*");
        inp = inp.replaceAll("÷", "/");
        Parser P = Parser();
        Expression expression = P.parse(userInp);
        ContextModel cm = ContextModel();
        var finalValue = expression.evaluate(EvaluationType.REAL, cm);
        out = finalValue.toString();
        if (out.endsWith(".0")) {
          out = out.substring(0, out.length - 2);
        }
        inp = out;
        hideInp = true;
        outSize = 52;
      }
    } else {
      inp = inp + value;
      hideInp = false;
      outSize = 34;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Expanded(
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(10),
              // color: Colors.blue,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    hideInp ? '' : inp,
                    style: TextStyle(
                      fontSize: 48,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    out,
                    style: TextStyle(
                      fontSize: outSize,
                      color: Colors.white.withOpacity(0.7),
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                ],
              ),
            ),
          ),
          Row(
            children: [
              button(
                text: "AC",
                buttonBgColor: operatorColor,
                // tColor: orangeColor,
              ),
              button(
                text: "<",
                buttonBgColor: operatorColor,
                // tColor: orangeColor,
              ),
              button(
                text: "+/-",
                buttonBgColor: operatorColor,
                // tColor: orangeColor,
              ),
              button(
                text: "/",
                buttonBgColor: operatorColor,
                // tColor: orangeColor,
              ),
            ],
          ),
          Row(
            children: [
              button(text: "7"),
              button(text: "8"),
              button(text: "9"),
              button(
                text: "x",
                buttonBgColor: operatorColor,
                // tColor: orangeColor,
              ),
            ],
          ),
          Row(
            children: [
              button(text: "4"),
              button(text: "5"),
              button(text: "6"),
              button(
                text: "-",
                buttonBgColor: operatorColor,
                // tColor: orangeColor,
              ),
            ],
          ),
          Row(
            children: [
              button(text: "1"),
              button(text: "2"),
              button(text: "3"),
              button(
                text: "+",
                buttonBgColor: operatorColor,
                // tColor: orangeColor,
              ),
            ],
          ),
          Row(
            children: [
              button(
                text: "%",
                buttonBgColor: operatorColor,
                // tColor: orangeColor,
              ),
              button(text: "0"),
              button(
                text: ".",
                buttonBgColor: operatorColor,
                // tColor: orangeColor,
              ),
              button(
                text: "=",
                buttonBgColor: Colors.orange,
                // tColor: Colors.white,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget button({text, tColor = Colors.white, buttonBgColor = buttonColor}) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.all(8.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ), backgroundColor: buttonBgColor,
            padding: const EdgeInsets.all(22),
          ),
          onPressed: () => onButtonClick(text),
          child: Text(
            text,
            style: TextStyle(
              fontSize: 18,
              color: tColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
