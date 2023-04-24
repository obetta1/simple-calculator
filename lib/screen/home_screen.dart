
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class SimpleCalculator extends StatefulWidget {
  const SimpleCalculator({super.key});

  @override
  State<SimpleCalculator> createState() => _SimpleCalculatorState();
}

class _SimpleCalculatorState extends State<SimpleCalculator> {

  String equation = "0";
  String result = "0";
  String expression = "";
  double equationFontSize = 38.0;
  double resultFontSize = 48.0;

  void buttonPress(String buttonText){
    setState(() {
      if (buttonText == "C"){
        equation = "0";
        result = "0";
        equationFontSize = 38.0;
        resultFontSize = 48.0;
      }else if (buttonText == "⌫"){
        equationFontSize = 48.0;
        resultFontSize = 38.0;
        equation = equation.substring(0, equation.length -1);
        if (equation == ""){
          equationFontSize = 38.0;
          resultFontSize = 48.0;
          equation = "0";
        }
      }else if (buttonText == "="){
        expression = equation;
        expression = expression.replaceAll("x", "*");
        expression = expression.replaceAll("÷", "/");
        try{
          Parser p = Parser();
          Expression exp = p.parse(expression);
          ContextModel cm = ContextModel();

          double  re = exp.evaluate(EvaluationType.REAL, cm);
          if ((re *10) % 10 == 0){
            result = '${re.toInt()}';
          }else {
           var  res = re.toString();
            var sp = res.split(".");
            if(sp[1].length > 8){
              result = "${sp[0]}.${sp[1].substring(0, 8)}";
            }else{
              result = res;
            }
          }
        }catch(e){
          result = 'Error';
        }
      }else{
        if(equation == "0"){
          equation = buttonText;
        }else{
          equation += buttonText;
        }
      }
    });
  }

  Widget buildButton(String buttonText, double buttonHeight, Color buttonColor){

    return Container(
        height: MediaQuery.of(context).size.height * 0.1 * buttonHeight,
        decoration: BoxDecoration(
          color: buttonColor,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(0.4),
          border: Border.all(
              color: Colors.white,
              width: 1,
              style: BorderStyle.solid
          ),
        ),

        child: TextButton(
          onPressed: ()=> buttonPress(buttonText),
          child: Text(
            buttonText,
            style:const TextStyle(
                fontSize: 30.0,
                fontWeight: FontWeight.normal,
                color: Colors.white
            ) ,),
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('bn',
          style: TextStyle(color: Colors.blue),),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
            child: Text( equation, style: TextStyle(fontSize: equationFontSize),),
          ),

          Container(
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.fromLTRB(10, 30, 10, 0),
            child: Text(result,style: TextStyle(fontSize: resultFontSize),),
          ),

          const Expanded(
            child: Divider(),
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                width: MediaQuery.of(context).size.width * .75,
                child: Table(
                  children: [
                    TableRow(
                        children: [
                          buildButton('C', 1, Colors.redAccent),
                          buildButton('⌫', 1, Colors.blue),
                          buildButton('÷', 1, Colors.blue),
                        ]
                    ),

                    TableRow(
                        children: [
                          buildButton('1', 1, Colors.black54),
                          buildButton('2', 1, Colors.black54),
                          buildButton('3', 1, Colors.black54),
                        ]
                    ),

                    TableRow(
                        children: [
                          buildButton('4', 1, Colors.black54),
                          buildButton('5', 1, Colors.black54),
                          buildButton('6', 1, Colors.black54),
                        ]
                    ),

                    TableRow(
                        children: [
                          buildButton('7', 1, Colors.black54),
                          buildButton('8', 1, Colors.black54),
                          buildButton('9', 1, Colors.black54),
                        ]
                    ),

                    TableRow(
                        children: [
                          buildButton('.', 1, Colors.black54),
                          buildButton('0', 1, Colors.black54),
                          buildButton('00', 1, Colors.black54),
                        ]
                    )
                  ],
                ),
              ),

              SizedBox(
                width: MediaQuery.of(context).size.width * 0.25,
                child: Table(
                  children: [
                    TableRow(
                      children: [
                        buildButton('x', 1, Colors.blue),
                      ],
                    ),

                    TableRow(
                      children: [
                        buildButton('+', 1, Colors.blue),
                      ],
                    ),

                    TableRow(
                      children: [
                        buildButton('-', 1, Colors.blue),
                      ],
                    ),

                    TableRow(
                      children: [
                        buildButton('=', 2, Colors.redAccent),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}