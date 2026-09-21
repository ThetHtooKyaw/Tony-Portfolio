class ProjectModel {
  final String name;
  final String type;
  final int downloadCount;
  final List<String> labels;
  final List<String> images;
  final String description;
  final List<String> features;
  final List<String> learned;
  final String detail;
  final List<Map<String, dynamic>> storeButtons;

  const ProjectModel({
    required this.name,
    required this.type,
    required this.downloadCount,
    required this.labels,
    required this.images,
    required this.description,
    required this.features,
    required this.learned,
    required this.detail,
    required this.storeButtons,
  });
}

const List<ProjectModel> projects = [
  ProjectModel(
    name: 'Hash Gaming: Esports Network',
    downloadCount: 1,
    type: 'Esports & Gaming Community App',
    labels: [
      'Flutter, Dart, Koltin, Swift',
      'Clean Architecture, BloC/Cubic',
      'Android / iOS',
    ],
    images: ['assets/images/hash_1.webp', 'assets/images/hash_2.webp'],
    description:
        'Contributed to the existing project and successful publication as a Flutter Developer. Hash Gaming is a community platform focused on gamers to search for desired gaming shops and book sessions with the ability to choose the location, time, and PC/Console specs through time-sensitive information, promotions, and an interactive UI.',
    features: [
      'Secure Authentication',
      'Gaming Cafés search & discovery via integrated map UI',
      'Slot booking with specific hardware types & food ordering',
      'Detailed cafe profiles featuring available hardware specs, facilities, games, and food menus',
      'Time-sensitive information & live promotion tracking',
      'Interactive gaming community UI',
    ],
    learned: [
      'Flutter & Bloc state management at production scale',
      'Advanced animated widget creation',
      'Code optimization & feature-by-feature debugging',
      'Clean Architecture implementation & dependency injection with GetIt',
      'Google Play Store & Apple App Store publication',
    ],
    detail:
        'Working on an active community platform with a live user base taught me how to scale and optimize production-ready mobile apps. I gained deep experience in implementing Clean Architecture alongside GetIt for dependency injection, while mastering advanced animated widget creation to deliver a highly interactive UI. Since the application serves users across a wide range of mobile hardware, I focused heavily on code optimization and performance tuning to ensure smooth execution on low-end devices. Additionally, I learned how to isolate and debug complex features independently, maintain high code quality through rigorous feature testing, and manage the end-to-end process of publishing updates to both the Google Play Store and Apple App Store.',
    storeButtons: [
      {
        'name': 'Play Store',
        'url':
            'https://play.google.com/store/apps/details?id=com.hfg.hash&pcampaignid=web_share',
      },
      {
        'name': 'App Store',
        'url':
            'https://apps.apple.com/th/app/hash-gaming-esports-network/id6750488424',
      },
    ],
  ),
  ProjectModel(
    name: 'Eventee',
    downloadCount: 0,
    type: 'Event Marketplace App',
    labels: [
      'Flutter, Dart, Koltin',
      'Node.js, Firebase',
      'MVVM, Provider',
      'Android',
    ],
    images: ['assets/images/eventee_1.webp', 'assets/images/eventee_2.webp'],
    description:
        'Independently developed an event marketplace platform from scratch as a Flutter Developer. The platform is focused on enabling users to discover local events, manage creation workflows, and book tickets seamlessly with the ability to search via geo-location, process secure payments, track booking history, and receive automated updates through an interactive UI.',
    features: [
      'Secure Authentication',
      'Interactive onboarding experience',
      'Geo-location event discovery',
      'Event creation and scheduling workflows',
      'Ticket booking workflow',
      'Secure payment processing via Stripe API',
      'Automated push notifications',
      'Booking history and ticket tracking UI',
    ],
    learned: [
      'MVVM architecture & Provider state management',
      'Response-based push notifications for feature success/failure',
      'Native feature triggering integrations with Koltin',
      'End-to-end authentication & user onboarding implementation',
      'Booking & tracking logic implementation',
      'Node.js backend API integration',
      'Stripe API integration & full payment flows',
      'Geo-location services & native permission handling',
      'Google Play Store publication',
    ],
    detail:
        'Building this event marketplace platform independently taught me how to architect a complete, production-grade mobile product from scratch. I gained deep experience in implementing MVVM architecture with Provider for clean state management, alongside native Kotlin integrations to trigger device-specific hardware features. On the backend and cloud infrastructure side, I mastered Node.js API integration, full-lifecycle Stripe payment processing, and setting up response-based push notifications triggered by feature success or failure states. Additionally, I learned how to handle complex user flows like end-to-end authentication, multi-step booking and tracking logic, and geo-location services with native permission handling, ultimately managing the entire delivery process through to successful Google Play Store publication.',
    storeButtons: [
      {
        'name': 'Download APK',
        'url': 'https://github.com/ThetHtooKyaw/Eventee/releases/tag/v1.0.0',
      },
    ],
  ),
  ProjectModel(
    name: 'RUYI',
    downloadCount: 0,
    type: 'Restaurant Booking Website',
    labels: ['Flutter, Dart', 'Firebase', 'Web'],
    images: ['assets/images/ruyi_1.webp', 'assets/images/ruyi_2.webp'],
    description:
        'I independently built a restaurant reservation and pre-order platform from scratch as a Full-Stack Flutter Developer. The platform unifies real-time table selection with a dynamic e-commerce menu interface. This gives diners a smoother booking experience while giving the kitchen staff a clear, upfront look at exactly what they need to prep.',
    features: [
      'Multi-language support',
      'Seat booking with integrated menu selection',
      'Real-time price calculation based on menu selections',
      'Automated booking confirmation emails',
      'Administrative control dashboard',
      'Menu management (CRUD operations)',
      'Reservation date & availability scheduler',
    ],
    learned: [
      'Multi-language localization',
      'Table reservation & scheduling implementation',
      'Responsive UI across all devices',
      'Menu management & CRUD operations',
      'Admin dashboard setup & integration',
      'Automated booking confirmation emails integration',
    ],
    detail:
        'Developing this full-stack restaurant software from the ground up gave me a comprehensive understanding of how to plan, build, and deliver a production-ready web application independently. On the frontend, I gained significant expertise in implementing multi-language localization frameworks that dynamically translate content, while utilizing mobile-first design patterns to ensure intricate layouts remain completely responsive across all device screen sizes. Moving deeper into the backend architecture, I focused on constructing heavy operational logic—specifically engineering a thread-safe table reservation and scheduling engine capable of managing real-time inventory and preventing booking conflicts. Additionally, I learned how to orchestrate complex data flows by building a secure menu management system driven by robust CRUD pipelines, connecting automated booking confirmation email triggers using transactional mail servers, and unifying these separate components into a centralized administrative control dashboard for seamless restaurant management.',
    storeButtons: [
      {'name': 'Website', 'url': 'https://ruyibooking.netlify.app/'},
    ],
  ),
];
