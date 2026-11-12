import 'package:go_router/go_router.dart';

import '../../src/award/model/certificate_model.dart';
import '../../src/award/views/award_view.dart';
import '../../src/award/views/certificate_detail_view.dart';
import '../../src/contact/views/contact_view.dart';
import '../../src/experiments/views/experiment_view.dart';
import '../../src/home/views/home_view.dart';
import '../../src/not_found_view.dart';
import '../../src/projects/views/project_detail_view.dart';
import '../../src/projects/views/project_view.dart';
import '../model/project_model.dart';
import '../widgets/animated_screen_transition.dart';

final GoRouter router = GoRouter(
  errorPageBuilder: (context, state) => AnimatedScreenTransition(
    newScreen: NotFoundView(routeName: state.uri.path),
    key: state.pageKey,
  ),
  routes: [
    GoRoute(
      path: '/',
      pageBuilder: (context, state) => AnimatedScreenTransition(
        newScreen: const HomeView(),
        key: state.pageKey,
      ),
    ),
    GoRoute(
      path: '/project_detail',
      pageBuilder: (context, state) => AnimatedScreenTransition(
        newScreen: ProjectDetailView(project: state.extra as ProjectModel),
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
    GoRoute(
      path: '/certificates',
      pageBuilder: (context, state) {
        final extra = state.extra as Map<String, dynamic>;

        return AnimatedScreenTransition(
          newScreen: CertificateDetailView(
            title: extra['title'] as String,
            certificates: extra['certificates'] as List<MinorCertificateModel>,
          ),
          key: state.pageKey,
        );
      },
    ),
    GoRoute(
      path: '/projects',
      pageBuilder: (context, state) => AnimatedScreenTransition(
        newScreen: const ProjectView(),
        key: state.pageKey,
      ),
    ),
    GoRoute(
      path: '/experiments',
      pageBuilder: (context, state) => AnimatedScreenTransition(
        newScreen: const ExperimentView(),
        key: state.pageKey,
      ),
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
