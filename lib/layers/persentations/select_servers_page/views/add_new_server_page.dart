import 'package:flutter/material.dart';

class AddNewServerPage extends StatelessWidget {
  const AddNewServerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Server'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.s,
          children: <Widget>[
            TextField(
              decoration: InputDecoration(
                labelText: 'IP Address',
                hintText: 'Enter the server IP address',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              decoration: InputDecoration(
                labelText: 'Port',
                hintText: 'Enter the server port',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 10),
            FilledButton(onPressed: () {}, child: const Text('Add Server')),
          ],
        ),
      ),
    );
  }
}
