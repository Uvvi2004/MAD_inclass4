import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Stateful Lab',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const CounterWidget(),
    );
  }
}

class CounterWidget extends StatefulWidget {
  const CounterWidget({super.key});

  @override
  _CounterWidgetState createState() => _CounterWidgetState();
}

class _CounterWidgetState extends State<CounterWidget> {
  int _counter = 0;

  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Interactive Counter')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

          Center(
            child: Container(
              color: Colors.blue.shade100,
              padding: const EdgeInsets.all(20),
              child: Text(
                '$_counter',
                style: TextStyle(
                  fontSize: 50.0,
                  color: _counter == 0
                      ? Colors.red
                      : _counter > 50
                          ? Colors.green
                          : Colors.black,
                ),
              ),
            ),
          ),

          const SizedBox(height: 20),

          Slider(
            min: 0,
            max: 100,
            value: _counter.toDouble(),
            onChanged: (double value) {
              setState(() {
                _counter = value.toInt();
              });
            },
          ),

          const SizedBox(height: 20),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              ElevatedButton(
                onPressed: () {
                  setState(() {
                    if (_counter > 0) {
                      _counter--;
                    }
                  });
                },
                child: const Text('-'),
              ),

              const SizedBox(width: 20),

              ElevatedButton(
                onPressed: () {
                  setState(() {
                    if (_counter < 100) {
                      _counter++;
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Limit Reached!')),
                      );
                    }
                  });
                },
                child: const Text('+'),
              ),

              const SizedBox(width: 20),

              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _counter = 0;
                  });
                },
                child: const Text('Reset'),
              ),
            ],
          ),

          const SizedBox(height: 20),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: TextField(
              controller: _controller,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Enter a number",
              ),
            ),
          ),

          const SizedBox(height: 20),

          ElevatedButton(
            onPressed: () {
              setState(() {
                int? value = int.tryParse(_controller.text);

                if (value != null) {
                  if (value <= 100 && value >= 0) {
                    _counter = value;
                    _controller.clear();
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Limit Reached!')),
                    );
                  }
                }
              });
            },
            child: const Text('Set Value'),
          ),

        ],
      ),
    );
  }
}
