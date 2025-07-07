import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:local_media_server/di/injection.dart';
import 'package:local_media_server/persentations/home/views/home_page.dart';
import 'package:local_media_server/persentations/medias/views/medias_page.dart';
import 'package:local_media_server/persentations/play/views/play_page.dart';
import 'package:local_media_server/persentations/select_servers_page/views/add_new_server_page.dart';
import 'package:local_media_server/persentations/select_servers_page/views/servers_page.dart';

void main() {
  setupDependencies();
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
        GoRoute(
          path: 'home',
          builder: (BuildContext context, GoRouterState state) {
            return const HomePage();
          },
        ),
        GoRoute(
          path: 'medias',
          builder: (BuildContext context, GoRouterState state) {
            return const MediasPage();
          },
        ),
        GoRoute(
          path: 'play',
          builder: (BuildContext context, GoRouterState state) {
            return const PlayPage();
          },
        ),
      ],
    ),
  ],
);

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _router,
      title: 'Local Media Server',
      theme: ThemeData.dark(),
      themeMode: ThemeMode.dark,
      debugShowCheckedModeBanner: false,
    );
  }
}
