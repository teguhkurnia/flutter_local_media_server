import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SelectServerPage extends StatelessWidget {
  const SelectServerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Select Server')),
      body: Padding(
        padding: EdgeInsetsGeometry.all(5),
        child: GridView(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
          ),
          children: [
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
