import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Read JSON',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List _items = [];
  // Map<String, dynamic>? _data;

  Future<void> readJson() async {
    final String response = await rootBundle.loadString('assets/data.json');
    final data = await json.decode(response);
    setState(() {
      _items = data['items'];
      // _data = data;
    });
  }

  @override
  void initState() {
    readJson();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Items'),
      ),
      body: Column(
        children: [
          // for (final item in _data!['items']!)
          //   ListTile(
          //     leading: Text(item['id']),
          //     title: Text(item['name']),
          //     subtitle: Text(item['description']),
          //   )

          _items.isNotEmpty
              ? Expanded(
                  child: ListView.builder(
                    itemCount: _items.length,
                    itemBuilder: (ctx, index) {
                      return ListTile(
                        leading: Text(_items[index]['id']),
                        title: Text(_items[index]['name']),
                        subtitle: Text(_items[index]['description']),
                      );
                    },
                  ),
                )
              : const Center(
                  child: Text('No items found'),
                )
        ],
      ),
    );
  }
}
