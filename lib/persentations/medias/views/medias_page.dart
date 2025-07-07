import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:local_media_server/domain/entities/media.dart';
import 'package:local_media_server/persentations/medias/bloc/media_page_bloc.dart';
import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:http/http.dart' as http;

class MediasPage extends StatelessWidget {
  const MediasPage({super.key});

  @override
  Widget build(BuildContext context) {
    final String libraryId = GoRouterState.of(context).extra as String;

    print('Library ID: $libraryId');
    return Scaffold(
      appBar: AppBar(title: const Text('Medias')),
      body: BlocProvider(
        create: (_) =>
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
          case MediaPageStatus.fetchMore:
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
  final _scrollController = ScrollController();

  void _onScroll() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      // Trigger fetch more when reaching the end of the list
      final currentPage =
          pageBloc.state.medias.length ~/ 20 + 1; // Assuming 20 items per page
      pageBloc.add(
        FetchMoreMediasEvent(
          libraryId: GoRouterState.of(context).extra as String,
          page: currentPage,
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<Media> medias = context.select(
      (MediaPageBloc bloc) => bloc.state.medias,
    );

    MediaPageStatus status = context.select(
      (MediaPageBloc bloc) => bloc.state.status,
    );

    return MasonryGridView.builder(
      controller: _scrollController,
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      gridDelegate: const SliverSimpleGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
      itemCount: status == MediaPageStatus.fetchMore
          ? medias.length + 1
          : medias.length,
      itemBuilder: (context, index) {
        if (status == MediaPageStatus.fetchMore && index == medias.length) {
          // Show loading indicator at the end of the list
          return const Center(child: CircularProgressIndicator());
        }

        final media = medias[index];

        return AspectRatio(
          aspectRatio: media.aspectRatio,
          child: InkWell(
            onTap: () {
              context.push("/play", extra: media);
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildThumbnail(media),
                // const SizedBox(height: 10),
                // Text(
                //   media.title,
                //   textAlign: TextAlign.center,
                //   maxLines: 1,
                //   overflow: TextOverflow.ellipsis,
                // ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildThumbnail(Media media) {
    return Expanded(
      child: Container(
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
        child: media.thumbnailUrl == ""
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
