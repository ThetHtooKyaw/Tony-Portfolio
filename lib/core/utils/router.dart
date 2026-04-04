import 'package:go_router/go_router.dart';
import 'package:tony_portfolio/src/award/views/award_view.dart';
import 'package:tony_portfolio/src/home/views/home_view.dart';
import 'package:tony_portfolio/src/widgets/animated_screen_transition.dart';

final GoRouter router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      pageBuilder: (context, state) => AnimatedScreenTransition(
        newScreen: const HomeView(),
        key: state.pageKey,
      ),
    ),
    GoRoute(
      path: '/awards',
      pageBuilder: (context, state) => AnimatedScreenTransition(
        newScreen: const AwardView(),
        key: state.pageKey,
      ),
    ),
  ],
);
