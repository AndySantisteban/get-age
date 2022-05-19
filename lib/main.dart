import 'package:flutter/material.dart';

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
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Calculate of Age'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var _selectDate;
  var _timeNow = DateTime.now();
  var _age = 0;

  void callDatePicker() async {
    var selectedDate = await getDateWidget();
    // calculate age
    setState(() {
      _selectDate = selectedDate;
      _age = calculateAge(_selectDate);
    });
  }

  calculateAge(DateTime dateSelected) {
    var age = _timeNow.year - dateSelected.year;
    if (_timeNow.month < dateSelected.month ||
        (_timeNow.month == dateSelected.month &&
            _timeNow.day < dateSelected.day)) {
      age--;
    }
    return age;
  }

  Future<DateTime?> getDateWidget() {
    return showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1900),
        lastDate: DateTime(2023),
        builder: (BuildContext context, child) {
          return Theme(data: ThemeData.dark(), child: child!);
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Your age is: ${_age.toString()}',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: callDatePicker,
        tooltip: 'Increment',
        child: const Icon(Icons.calendar_month),
      ),
    );
  }
}
