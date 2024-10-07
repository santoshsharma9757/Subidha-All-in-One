import 'package:flutter/material.dart';
import 'package:hamro_smart_life/utils/widgets/reusable_appbar.dart';

class MultiplicationTablePage extends StatefulWidget {
  const MultiplicationTablePage({super.key});

  @override
  State<MultiplicationTablePage> createState() =>
      _MultiplicationTablePageState();
}

class _MultiplicationTablePageState extends State<MultiplicationTablePage> {
  final TextEditingController _controller = TextEditingController();
  List<String> _results = [];

  void _generateTable() {
    final int? number = int.tryParse(_controller.text);
    if (number != null) {
      setState(() {
        _results = List.generate(
            10, (i) => '$number x ${i + 1} = ${number * (i + 1)}');
      });
      // Dismiss the keyboard
      FocusScope.of(context).unfocus(); // <-- Add this line
    } else {
      setState(() {
        _results = [];
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a valid number')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const ReusableAppBar(
        title: "Multiplication Table",
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.3,
                  height: 50,
                  child: TextField(
                    controller: _controller,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      hintText: 'Number',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                ElevatedButton(
                  onPressed: _generateTable,
                  child: const Text('Generate Table'),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: _results.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    child: Center(
                      child: Container(
                        padding: const EdgeInsets.all(8.0),
                        width: MediaQuery.of(context).size.width * 0.8,
                        decoration: BoxDecoration(
                          color: Colors.blue[50],
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(color: Colors.black, width: 1),
                        ),
                        child: Text(
                          _results[index],
                          textAlign: TextAlign.center,
                          style: const TextStyle(fontSize: 18),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
