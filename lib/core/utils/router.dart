import 'package:go_router/go_router.dart';
import 'package:tony_portfolio/src/award/views/award_view.dart';
import 'package:tony_portfolio/src/award/views/certificate_detail_view.dart';
import 'package:tony_portfolio/src/contact/views/contact_view.dart';
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
      routes: [
        GoRoute(
          path: 'certificates',
          pageBuilder: (context, state) {
            return AnimatedScreenTransition(
              newScreen: CertificateDetailView(
                certificates: state.extra as List<Map<String, dynamic>>,
              ),
              key: state.pageKey,
            );
          },
        ),
      ],
    ),
    GoRoute(
      path: '/contact',
      pageBuilder: (context, state) => AnimatedScreenTransition(
        newScreen: const ContactView(),
        key: state.pageKey,
      ),
    ),
  ],
);
