import 'package:flutter/material.dart';
import 'package:togu_currency_convert/togu_currency_convert.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _fromCurrency = TextEditingController();
  final TextEditingController _toCurrency = TextEditingController();
  final TextEditingController _amountCurrency = TextEditingController();

  double _convertResult = 0.0;

  String _valFrom = '';
  String _valTo = '';

  List<String> _from = <String>[];
  List<String> _to = <String>[];

  @override
  void initState() {
    _from = CurrencyConverter().getCurrency();
    _to = CurrencyConverter().getCurrency();

    _valFrom = _from[0];
    _valTo = _from[0];

    super.initState();
  }

  void convert() async {
    double? result = await CurrencyConverter().convert(
      from: _valFrom,
      to: _valTo
      amount: double.parse(_amountCurrency.text),
    );

    setState(() {
      _convertResult = result!;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // TextField(
              //   controller: _fromCurrency,
              //   decoration: const InputDecoration(
              //     filled: true,
              //     fillColor: Colors.grey,
              //     label: Text("From Currency"),
              //   ),
              // ),
              DropdownButton(
                hint: const Text("From currency"),
                value: _valFrom,
                items: _from.map((value) {
                  return DropdownMenuItem(
                    child: Text(value),
                    value: value,
                  );
                }).toList(),
                onChanged: (String? value) {
                  setState(() {
                    _valFrom = value!;
                  });
                },
              ),

              DropdownButton(
                hint: const Text("To currency"),
                value: _valTo,
                items: _to.map((value) {
                  return DropdownMenuItem(
                    child: Text(value),
                    value: value,
                  );
                }).toList(),
                onChanged: (String? value) {
                  setState(() {
                    _valTo = value!;
                  });
                },
              ),
              TextField(
                controller: _amountCurrency,
                decoration: const InputDecoration(
                  filled: true,
                  fillColor: Colors.grey,
                  label: Text("Amount"),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                "Result : $_convertResult",
                style: const TextStyle(fontSize: 20),
              ),
              const SizedBox(
                height: 20,
              ),
              TextButton(
                onPressed: () => convert(),
                style: TextButton.styleFrom(
                  backgroundColor: Colors.blue,
                ),
                child: const Text(
                  "Convert",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
