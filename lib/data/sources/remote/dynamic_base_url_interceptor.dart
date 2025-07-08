import 'package:dio/dio.dart';
import 'package:local_media_server/persentations/select_servers_page/bloc/servers_page_bloc.dart';

class DynamicBaseUrlInterceptor extends Interceptor {
  final ServersPageBloc serverPageBloc;

  DynamicBaseUrlInterceptor(this.serverPageBloc);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // watch the server selection state

    print('INTERCEPTOR - Bloc hashCode: ${serverPageBloc.hashCode}');

    final state = serverPageBloc.state;

    print(
      "DynamicBaseUrlInterceptor: Intercepting request...${state.selectedServer}",
    );

    // Check if a server has been selected
    if (state.selectedServer != null) {
      print(
        "Using server: ${state.selectedServer!.ipAddress}:${state.selectedServer!.port}",
      );
      // Dynamically set the baseUrl for the request
      options.baseUrl = state.selectedServerUrl;
    } else {
      // Optional: handle the case where no server is selected.
      // You could throw an error, use a default URL, or queue the request.
      // For this example, we'll let it fail if the endpoint is relative.
      print(
        "Warning: No server selected. Request might fail if path is not a full URL.",
      );
    }

    // Continue with the request
    super.onRequest(options, handler);
  }
}
