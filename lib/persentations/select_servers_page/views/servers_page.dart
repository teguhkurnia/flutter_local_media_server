import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:local_media_server/domain/entities/server.dart';
import 'package:local_media_server/persentations/select_servers_page/bloc/servers_page_bloc.dart';

class SelectServerPage extends StatelessWidget {
  const SelectServerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Select Server')),
      body: Padding(
        padding: EdgeInsetsGeometry.all(10),
        child: SelectServerView(),
      ),
    );
  }
}

class SelectServerView extends StatelessWidget {
  const SelectServerView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ServersPageBloc, ServersPageState>(
      builder: (context, state) {
        switch (state.status) {
          case ServersPageStatus.initial:
          case ServersPageStatus.loading:
            return const Center(child: CircularProgressIndicator());
          case ServersPageStatus.loaded:
            return const _Content();
          case ServersPageStatus.error:
            return Center(child: Text('Error: ${state.errorMessage}'));
        }
      },
    );
  }
}

class _Content extends StatelessWidget {
  const _Content({super.key});

  void _onServerSelected(BuildContext context, Server server) {
    context.read<ServersPageBloc>().add(SelectServerEvent(server));
    context.go('/home');
  }

  @override
  Widget build(BuildContext context) {
    List<Server> servers = context.read<ServersPageBloc>().state.servers;

    return Padding(
      padding: EdgeInsetsGeometry.all(10),
      child: GridView(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
        children: [
          ...servers.map((server) {
            return InkWell(
              onTap: () {
                _onServerSelected(context, server);
              },
              child: Column(
                children: [
                  Expanded(
                    child: Card(
                      elevation: 0,
                      child: Center(child: Text(server.id.toString())),
                    ),
                  ),
                  SizedBox(height: 5),
                  Text("${server.ipAddress}:${server.port}"),
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
    );
  }
}
