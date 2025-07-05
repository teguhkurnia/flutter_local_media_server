import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:local_media_server/domain/entities/media.dart';
import 'package:local_media_server/persentations/medias/bloc/media_page_bloc.dart';

class MediasPage extends StatelessWidget {
  const MediasPage({super.key});

  @override
  Widget build(BuildContext context) {
    final String libraryId = GoRouterState.of(context).extra as String;

    print('Library ID: $libraryId');
    return Scaffold(
      appBar: AppBar(title: const Text('Medias')),
      body: BlocProvider(
        create:
            (_) =>
                GetIt.instance<MediaPageBloc>()
                  ..add(FetchMediasEvent(libraryId: libraryId, page: 1)),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: const MediasView(),
        ),
      ),
    );
  }
}

class MediasView extends StatelessWidget {
  const MediasView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MediaPageBloc, MediaPageState>(
      builder: (context, state) {
        switch (state.status) {
          case MediaPageStatus.initial:
          case MediaPageStatus.loading:
            return const Center(child: CircularProgressIndicator());
          case MediaPageStatus.loaded:
            return _Content();
          case MediaPageStatus.error:
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
  MediaPageBloc get pageBloc => context.read<MediaPageBloc>();

  @override
  void initState() {
    super.initState();
    // You can add any initial setup here if needed
  }

  @override
  Widget build(BuildContext context) {
    List<Media> medias = context.select(
      (MediaPageBloc bloc) => bloc.state.medias,
    );
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.6,
        mainAxisSpacing: 20,
        crossAxisSpacing: 10,
      ),
      itemCount: medias.length,
      itemBuilder: (context, index) {
        final media = medias[index];
        return InkWell(
          onTap: () {
            context.push("/play", extra: media);
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buiildThumbnail(media),
              const SizedBox(height: 10),
              Text(
                media.title,
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buiildThumbnail(Media media) {
    return Expanded(
      child: Container(
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
        child:
            media.thumbnailUrl == ""
                ? const Icon(Icons.image_not_supported, size: 100)
                : Image.network(
                  'http://192.168.0.118:8000${media.thumbnailUrl}',
                  fit: BoxFit.cover,
                  width: double.infinity,
                  errorBuilder: (context, error, stackTrace) {
                    return const Icon(Icons.image_not_supported, size: 100);
                  },
                ),
      ),
    );
  }
}
