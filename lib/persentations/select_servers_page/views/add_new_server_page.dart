import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:local_media_server/domain/entities/server.dart';
import 'package:local_media_server/persentations/select_servers_page/bloc/servers_page_bloc.dart';

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
      body: BlocProvider(
        create: (_) => GetIt.instance<ServersPageBloc>(),
        child: BlocBuilder<ServersPageBloc, ServersPageState>(
          builder: (context, state) {
            return _Content();
          },
        ),
      ),
    );
  }
}

class _Content extends StatefulWidget {
  const _Content({super.key});

  @override
  State<_Content> createState() => _ContentState();
}

class _ContentState extends State<_Content> {
  final TextEditingController _ipController = TextEditingController();

  final TextEditingController _portController = TextEditingController();

  void _onSubmit() async {
    final ip = _ipController.text.trim();
    final port = _portController.text.trim();

    if (ip.isEmpty || port.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in all fields')),
      );
      return;
    }

    // Validate IP address format
    final ipRegex = RegExp(r'^(\d{1,3}\.){3}\d{1,3}$');

    if (!ipRegex.hasMatch(ip)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Invalid IP address format')),
      );
      return;
    }

    // Validate port number
    final portNumber = int.tryParse(port);
    if (portNumber == null || portNumber < 1 || portNumber > 65535) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Port must be a number between 1 and 65535'),
        ),
      );
      return;
    }

    // Add the server using the Bloc
    Server newServer = Server(ipAddress: ip, port: portNumber);
    context.read<ServersPageBloc>().add(AddServerEvent(newServer));

    Navigator.of(context).pop(); // Close the page after adding the server
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.s,
        children: <Widget>[
          TextField(
            controller: _ipController,
            decoration: InputDecoration(
              labelText: 'IP Address',
              hintText: 'Enter the server IP address',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 10),
          TextField(
            controller: _portController,
            decoration: InputDecoration(
              labelText: 'Port',
              hintText: 'Enter the server port',
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: 10),
          FilledButton(onPressed: _onSubmit, child: const Text('Add Server')),
        ],
      ),
    );
  }
}
