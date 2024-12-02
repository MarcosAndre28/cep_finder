import 'package:cep_finder/core/services/injection_container.dart';
import 'package:cep_finder/core/utils/transition_page.dart';
import 'package:cep_finder/src/booklet/presentation/views/passbook_page.dart';
import 'package:cep_finder/src/home/presentation/views/splash_page.dart';
import 'package:cep_finder/src/map/data/model/address_model.dart';
import 'package:cep_finder/src/map/presentation/bloc/on_map_bloc.dart';
import 'package:cep_finder/src/map/presentation/views/map_page.dart';
import 'package:cep_finder/src/map/presentation/views/revision_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/splash',
  routes: [
    GoRoute(
      path: '/splash',
      builder: (context, state) => const SplashPage(),
    ),
    GoRoute(
      path: '/revision',
      pageBuilder: (context, state) {
        final address = state.extra! as AddressModel;
        return CustomTransitionPageWrapper(
          key: state.pageKey,
          child: BlocProvider(
            create: (_) => sl<OnMapBloc>(),
            child:  RevisionPage(addressModel: address),
          ),
        );
      },
    ),

    GoRoute(
      path: '/map',
      pageBuilder: (context, state) {
        return CustomTransitionPageWrapper(
          key: state.pageKey,
          child: BlocProvider(
            create: (_) => sl<OnMapBloc>(),
            child: const MapPage(),
          ),
        );
      },
    ),

    // Rota Booklet
    GoRoute(
      path: '/booklet',
      pageBuilder: (context, state){
        return CustomTransitionPageWrapper(
          key: state.pageKey,
          child: BlocProvider(
            create: (_) => sl<OnMapBloc>(),
            child: const BookletPage(),
          ),
        );
      },
    ),
  ],
);
