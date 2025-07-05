import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final _servers = [
  {'name': 'Server 1', 'ipAddress': '192.168.1.118', 'port': '8000'},
];

class SelectServerPage extends StatelessWidget {
  const SelectServerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Select Server')),
      body: Padding(
        padding: EdgeInsetsGeometry.all(10),
        child: GridView(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
          ),
          children: [
            ..._servers.map((server) {
              return InkWell(
                onTap: () {
                  context.go('/home');
                },
                child: Column(
                  children: [
                    Expanded(
                      child: Card(
                        elevation: 0,
                        child: Center(child: Text(server['name'] ?? '')),
                      ),
                    ),
                    SizedBox(height: 5),
                    Text("${server['ipAddress']}:${server['port']}"),
                  ],
                ),
              );
            }),

            InkWell(
              onTap: () {
                context.go('/add-server');
              },
              child: Column(
                children: [
                  Expanded(
                    child: Card(
                      elevation: 0,
                      child: Center(child: Icon(Icons.add_circle_outline)),
                    ),
                  ),
                  SizedBox(height: 5),
                  Text("Add Server"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
