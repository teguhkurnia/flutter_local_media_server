import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:local_media_server/persentations/home/bloc/home_page_bloc.dart';
import 'package:local_media_server/persentations/select_servers_page/bloc/servers_page_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          GetIt.instance<HomePageBloc>()..add(const FetchLibrariesEvent()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Home Page'),
          actions: [
            IconButton(
              icon: const Icon(Icons.refresh),
              onPressed: () {
                context.read<HomePageBloc>().add(const FetchLibrariesEvent());
              },
            ),
          ],
        ),
        body: const HomeView(),
      ),
    );
  }
}

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomePageBloc, HomePageState>(
      builder: (context, state) {
        switch (state.status) {
          case HomePageStatus.initial:
          case HomePageStatus.loading:
            return const Center(child: CircularProgressIndicator());
          case HomePageStatus.loaded:
            return const _Content();
          case HomePageStatus.error:
            return Center(child: Text('Error: ${state.errorMessage}'));
        }
      },
    );
  }
}

class _Content extends StatefulWidget {
  const _Content();

  @override
  State<_Content> createState() => _ContentState();
}

class _ContentState extends State<_Content> {
  HomePageBloc get pageBloc => context.read<HomePageBloc>();

  @override
  Widget build(BuildContext context) {
    final list = context.select((HomePageBloc b) => b.state.libraries);
    final selectedServerHost = context.select(
      (ServersPageBloc b) => b.state.selectedServerHost,
    );

    return Padding(
      padding: const EdgeInsets.all(10),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1.2,
          crossAxisSpacing: 10,
        ),
        itemCount: list.length,
        itemBuilder: (context, index) {
          final library = list[index];
          return SizedBox(
            height: 300,

            child: InkWell(
              onTap: () {
                context.push('/medias', extra: library.id);
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // renders 3 images from the library
                  Container(
                    clipBehavior: Clip.hardEdge,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      children: library.medias.take(3).map((media) {
                        if (media.thumbnailUrl == "") {
                          return const SizedBox.shrink();
                        }

                        return Expanded(
                          child: Image.network(
                            '$selectedServerHost${media.thumbnailUrl}',
                            fit: BoxFit.cover,
                            height: 120,
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                  Text(library.name),
                  const SizedBox(height: 5),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
