import 'package:flutter/material.dart';

class ConversorView extends StatefulWidget {
  ConversorView({Key key}) : super(key: key);

  @override
  _ConversorViewState createState() => _ConversorViewState();
}

class _ConversorViewState extends State<ConversorView> {
  TextEditingController realcontroller = new TextEditingController();
  TextEditingController quotationcontroller = new TextEditingController();
  String result = '0,00';
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());
      },
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.black,
            title: Text(
              "Conversor de Moeda",
              style: TextStyle(fontSize: 16),
            ),
          ),
          body: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.all(15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.only(bottom: 40),
                    child: Column(
                      children: [
                        textInput(
                            controller: realcontroller,
                            hintText: 'Valor em real'),
                        textInput(
                            controller: quotationcontroller,
                            hintText: 'Cotação'),
                      ],
                    ),
                  ),
                  button(
                      title: 'Limprar',
                      onpressed: () {
                        setState(() {
                          realcontroller.clear();
                          quotationcontroller.clear();
                          setState(() {
                            result = calculate(
                                real: realcontroller.text,
                                quotation: quotationcontroller.text);
                          });
                        });
                      },
                      color: Colors.white,
                      textcolor: Colors.black),
                  button(
                      title: 'Calcular',
                      color: Colors.black,
                      onpressed: () {
                        setState(() {
                          result = calculate(
                              real: realcontroller.text,
                              quotation: quotationcontroller.text);
                        });
                      }),
                  Container(
                    margin: EdgeInsets.only(top: 40),
                    child: Text("Conversão em dolar: R\$$result"),
                  )
                ],
              ),
            ),
          )),
    );
  }

  Widget textInput({
    @required TextEditingController controller,
    @required String hintText,
  }) {
    return Container(
        margin: EdgeInsets.only(top: 20),
        child: TextFormField(
          controller: controller,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
              hintText: hintText,
              labelText: hintText,
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black))),
        ));
  }

  Widget button(
      {@required title, Color color, VoidCallback onpressed, Color textcolor}) {
    return Container(
      width: double.maxFinite,
      child: ElevatedButton(
        child:
            Text(title, style: TextStyle(color: textcolor, letterSpacing: 0.5)),
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(color),
        ),
        onPressed: onpressed,
      ),
    );
  }

  String calculate({@required String real, @required String quotation}) {
    try {
      return (double.tryParse(real.replaceAll(",", ".")) /
              double.tryParse(quotation.replaceAll(",", ".")))
          .toStringAsFixed(2);
    } catch (error) {
      return "0,00";
    }
  }
}
