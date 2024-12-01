import 'package:cep_finder/core/services/injection_container.dart';
import 'package:cep_finder/src/booklet/presentation/views/passbook.dart';
import 'package:cep_finder/src/home/presentation/views/splash_page.dart';
import 'package:cep_finder/src/map/presentation/bloc/on_map_bloc.dart';
import 'package:cep_finder/src/map/presentation/views/map_page.dart';
import 'package:cep_finder/src/map/presentation/views/revision_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/Map',
  routes: [
    // GoRoute(
    //   path: '/home',
    //   builder: (context, state) => const HomePage(),
    // ),
    GoRoute(
      path: '/revision',
      builder: (context, state) => const RevisionPage(),
    ),

    GoRoute(
      path: '/map',
      builder: (context, state) {
        return BlocProvider(
          create: (_) => sl<OnMapBloc>(),
          child: const MapPage(),
        );
      },
    ),

    // Rota Booklet
    GoRoute(
      path: '/booklet',
      builder: (context, state) => const BookletPage(),
    ),
  ],
);
