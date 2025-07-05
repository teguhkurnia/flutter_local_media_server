import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:local_media_server/layers/persentations/select_servers_page/views/add_new_server_page.dart';
import 'package:local_media_server/layers/persentations/select_servers_page/views/servers_page.dart';

void main() {
  runApp(const MyApp());
}

final GoRouter _router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const SelectServerPage();
      },
      routes: [
        GoRoute(
          path: 'add-server',
          builder: (BuildContext context, GoRouterState state) {
            return const AddNewServerPage();
          },
        ),
      ],
    ),
  ],
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _router,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.grey),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
