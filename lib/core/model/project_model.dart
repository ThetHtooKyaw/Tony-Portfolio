class ProjectModel {
  // Categories: Hackathon, Production, Experiment
  final List<String> categories;

  // Core fields
  final String name;
  final String type;
  final int? downloadCount;
  final int? playCount;
  final List<String> techStack;
  final List<String> images;
  final String teamOverview;
  final String description;
  final List<String> features;
  final List<String> learned;
  final List<String> platformIcons;
  final List<Map<String, dynamic>> storeButtons;

  // Hackathon-specific fields
  final List<String>? overviewImage;
  final String? eventName;
  final String? teamName;
  final String? award;
  final String? presentation;

  const ProjectModel({
    required this.categories,

    required this.name,
    required this.type,
    this.downloadCount,
    this.playCount,
    required this.techStack,
    required this.images,
    required this.teamOverview,
    required this.description,
    required this.features,
    this.learned = const [],
    required this.platformIcons,
    required this.storeButtons,

    this.overviewImage = const [],
    this.eventName,
    this.teamName,
    this.award,
    this.presentation,
  });
}

final List<ProjectModel> allProjects = [
  // 1. Onyx (Hackathon)
  ProjectModel(
    categories: ['Hackathon'],

    name: 'Onyx',
    type: 'AI-Powered Support Platform',
    downloadCount: 0,
    techStack: ['Flutter', 'Dart', 'Gemini AI'],
    eventName: 'Rangsit University - Hack The Zodiac (2024)',
    teamName: 'Geminators',
    award: 'Winner',
    presentation:
        'https://drive.google.com/file/d/1t-1QHrUsPkNCaKwpSO8ROeQJALerU3xy/view?usp=drive_link',
    overviewImage: [
      'assets/images/projects/HTZ_Winner.webp',
      'assets/images/projects/HTZ_Finalist.webp',
    ],
    images: ['assets/images/projects/HTZ_Winner.webp'],
    teamOverview:
        'Developed alongside three other friends as a four-person team, Geminators, for Hack The Zodiac.',
    description:
        'Designed for eco-conscious businesses and consumers, this AI-powered platform transforms traditional customer support into a proactive green initiative. By integrating Gemini AI for automated assistance and smart recommendations, the app seamlessly guides users through verified trade-in services to minimize electronic waste. Through its unique green tax system, the platform empowers users to contribute to environmental conservation with every digital interaction.',
    features: [
      'Automated assistance and smart recommendations using Gemini AI.',
      'Verified trade-in services to minimize electronic waste.',
    ],
    platformIcons: ['assets/icons/android.webp'],
    storeButtons: [
      {
        'name': 'GitHub',
        'icon': 'assets/icons/github.webp',
        'url': 'https://github.com/ThetHtooKyaw/Stepout-Customer-Support.git',
      },
    ],
  ),

  // 2. Card Htet Kya Soh! (Game Jam)
  ProjectModel(
    categories: ['Hackathon', 'Production'],
    name: 'Card Htet Kya Soh!',
    type: '2D Card Battler WebGL Game',
    playCount: 1000,
    techStack: ['Unity 6', 'C#', 'WebGL'],
    eventName: 'Digit7s Jam (2026)',
    teamName: 'APEX',
    award: 'Best Creative Concept Award',
    presentation:
        'https://drive.google.com/file/d/16A8crdvGvdHUbB7PjKhBQP00YPubBQOP/view?usp=drive_link',
    overviewImage: [
      'assets/images/projects/CHKS_BCCA.webp',
      'assets/images/projects/CHKS_BCCA_Art.webp',
      'assets/images/projects/CHKS_Finalist.webp',
    ],
    images: [
      'assets/images/projects/CHKS1.webp',
      'assets/images/projects/CHKS2.webp',
      'assets/images/projects/CHKS3.webp',
      'assets/images/projects/CHKS4.webp',
      'assets/images/projects/CHKS5.webp',
      'assets/images/projects/CHKS6.webp',
      'assets/images/projects/CHKS7.webp',
    ],
    teamOverview:
        'Developed alongside two friends as part of our three-person team, APEX, for the Digit7s Jam.',
    description:
        'Designed around immersive cultural storytelling and strategic depth, this Myanmar-themed 2D card battler transforms traditional card gaming into an engaging campaign journey. By integrating smooth WebGL performance with interactive mechanics, the game seamlessly guides players through tactical board battles, dynamic opponent dialogues, and collection systems. Through its unique card pack drops and minigames, the platform empowers players to master deck-building and progress across a multi-tier adventure.',
    features: [
      'Smooth Unity WebGL experience built with responsive scaling across mobile, tablet, and PC screen sizes.',
      'Campaign ladder allowing players to unlock and progress through 4 distinct difficulty levels on an interactive map.',
      'Myanmar-themed card packs featuring unique cultural cards (1★–3★) obtained through weighted rarity pack drops.',
      'Tactical board battles where players swipe to play cards, trigger category matching, use strategic artifacts, and win or lose cards based on the battle outcome.',
      'Interactive Memory Match and Rock-Paper-Scissors minigames to earn extra coins.',
      'Collection book that automatically tracks every card unlocked from packs or discovered during gameplay.',
      'Opponent dialogue system offering interactive choices during fights that dynamically alter match conditions.',
      'Dynamic audio and SFX featuring scene-specific music, custom boss battle themes, and responsive card and UI sound effects.',
      'Seamless data persistence saving unlocked cards, owned cards, coins, artifacts, and settings via PlayerPrefs.',
    ],
    platformIcons: ['assets/icons/website.webp'],
    storeButtons: [
      {
        'name': 'Website',
        'icon': 'assets/icons/website.webp',
        'url': 'https://cardhtetkyasoh.vercel.app/',
      },
      {
        'name': 'GitHub',
        'icon': 'assets/icons/github.webp',
        'url': 'https://github.com/Akito101/SchoolCardFight.git',
      },
    ],
  ),

  // 3. Hash Gaming: Esports Network
  ProjectModel(
    categories: ['Production'],
    name: 'Hash Gaming: Esports Network',
    type: 'Esports & Gaming Community App',
    downloadCount: 1000,
    techStack: [
      'Flutter',
      'Dart, Koltin, Swift',
      'Clean Architecture, BloC/Cubic',
    ],
    images: [
      'assets/images/projects/HFG1.webp',
      'assets/images/projects/HFG2.webp',
      'assets/images/projects/HFG3.webp',
      'assets/images/projects/HFG4.webp',
      'assets/images/projects/HFG5.webp',
      'assets/images/projects/HFG6.webp',
      'assets/images/projects/HFG7.webp',
    ],
    teamOverview:
        'Contributed as a Flutter Mobile & Desktop Developer to an existing company project.',
    description:
        'Designed for modern gamers and community enthusiasts, this robust platform transforms traditional gaming venue discovery into a streamlined digital experience. By integrating real-time availability and hardware specs, the app seamlessly guides users through finding preferred gaming shops and securing equipment bookings. Through its interactive community UI and time-sensitive promotions, the platform empowers users to connect and coordinate their gaming sessions effortlessly.',
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
    platformIcons: ['assets/icons/android.webp', 'assets/icons/ios.webp'],
    storeButtons: [
      {
        'name': 'Play Store',
        'icon': 'assets/icons/playstore.webp',
        'url':
            'https://play.google.com/store/apps/details?id=com.hfg.hash&pcampaignid=web_share',
      },
      {
        'name': 'App Store',
        'icon': 'assets/icons/appstore.webp',
        'url':
            'https://apps.apple.com/th/app/hash-gaming-esports-network/id6750488424',
      },
    ],
  ),

  // 4. RUYI
  ProjectModel(
    categories: ['Production'],
    name: 'RUYI',
    type: 'Restaurant Booking Website',
    playCount: 500,
    techStack: ['Flutter', 'Dart', 'Firebase', 'Provider'],
    images: [
      'assets/images/projects/ruyi_1.webp',
      'assets/images/projects/ruyi_2.webp',
    ],
    teamOverview: 'Independently developed as a solo project.',
    description:
        'Designed for diners and restaurant staff alike, this digital reservation platform transforms traditional table booking into a cohesive dining workflow. By integrating real-time table selection with a dynamic e-commerce menu interface, the web app seamlessly guides users through customized food pre-ordering. Through its automated management system, the platform empowers restaurants to optimize kitchen prep while delivering a frictionless reservation experience.',
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
    platformIcons: ['assets/icons/website.webp'],
    storeButtons: [
      {
        'name': 'Website',
        'icon': 'assets/icons/website.webp',
        'url': 'https://ruyibooking.netlify.app/',
      },
      {
        'name': 'GitHub',
        'icon': 'assets/icons/github.webp',
        'url': 'https://github.com/ThetHtooKyaw/RUYI-Booking-Website.git',
      },
    ],
  ),

  // 5. Eventee
  ProjectModel(
    categories: ['Experiment'],
    name: 'Eventee',
    type: 'Event Marketplace App',
    downloadCount: 0,
    techStack: [
      'Flutter',
      'Dart, Koltin',
      'Node.js, Firebase',
      'MVVM, Provider',
    ],
    images: [
      'assets/images/projects/Eventee1.webp',
      'assets/images/projects/Eventee2.webp',
      'assets/images/projects/Eventee3.webp',
      'assets/images/projects/Eventee4.webp',
      'assets/images/projects/Eventee5.webp',
      'assets/images/projects/Eventee6.webp',
      'assets/images/projects/Eventee7.webp',
    ],
    teamOverview: 'Independently developed as a solo project.',
    description:
        'Designed for event organizers and local attendees, this marketplace platform transforms traditional event discovery into an interactive digital ecosystem. By integrating geo-location services and secure payment processing, the app seamlessly guides users through browsing local happenings and securing ticket purchases. Through its automated notification system, the platform empowers users to stay updated on their booking history and upcoming schedules.',
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
      'Native feature triggering integrations with Kotlin',
      'End-to-end authentication & user onboarding implementation',
      'Booking & tracking logic implementation',
      'Node.js backend API integration',
      'Stripe API integration & full payment flows',
      'Geo-location services & native permission handling',
      'Google Play Store publication',
    ],
    platformIcons: ['assets/icons/android.webp'],
    storeButtons: [
      {
        'name': 'Download APK',
        'icon': 'assets/icons/android.webp',
        'url': 'https://github.com/ThetHtooKyaw/Eventee/releases/tag/v1.0.0',
      },
      {
        'name': 'GitHub',
        'icon': 'assets/icons/github.webp',
        'url': 'https://github.com/ThetHtooKyaw/Eventee.git',
      },
    ],
  ),

  // 6. Souls Compass
  ProjectModel(
    categories: ['Experiment'],
    name: 'Souls Compass',
    type: 'Horoscope Website',
    playCount: 100,
    techStack: ['HTML5, CSS3, JavaScript'],
    images: [
      'assets/images/projects/SC1.webp',
      'assets/images/projects/SC2.webp',
    ],
    teamOverview: 'Independently developed as a solo project.',
    description:
        'Designed for astrology enthusiasts and curious explorers, this interactive web platform transforms traditional horoscope reading into an engaging self-discovery journey. By integrating dynamic date-driven logic and responsive layouts, the site seamlessly guides users through exploring zodiac traits and compatibility metrics. Through its interactive spinning wheel and smooth transitions, the platform empowers users to uncover deeper personal insights with every click.',
    features: [
      'Clean layout tailored for desktop, tablet, and mobile devices.',
      'Interactive spinning wheel that responds dynamically to user input',
      'Custom-built scrollable date pickers with smooth step-by-step transitions',
    ],
    platformIcons: ['assets/icons/website.webp'],
    storeButtons: [
      {
        'name': 'Website',
        'icon': 'assets/icons/website.webp',
        'url': 'https://soulscompass.vercel.app/',
      },
      {
        'name': 'GitHub',
        'icon': 'assets/icons/github.webp',
        'url': 'https://github.com/ThetHtooKyaw/Soul-Compass.git',
      },
    ],
  ),

  // 7. Flappy Bird Clone
  ProjectModel(
    categories: ['Experiment'],
    name: 'Flappy Bird Clone',
    type: 'Browser-Based Arcade Game',
    playCount: 150,
    techStack: ['Phaser.js', 'HTML5, CSS3, JavaScript'],
    images: [
      'assets/images/projects/FB1.webp',
      'assets/images/projects/FB2.webp',
      'assets/images/projects/FB3.webp',
      'assets/images/projects/FB4.webp',
    ],
    teamOverview: 'Independently developed as a solo project.',
    description:
        'Designed for arcade gaming enthusiasts, this browser-based platform transforms a classic retro concept into a polished, responsive web experience. By integrating multi-modal input tracking and procedural obstacle generation, the game seamlessly challenges players to master precise flight controls. Through its dynamic collision feedback and real-time score tracking, the platform empowers users to continually push for their ultimate high score.',
    features: [
      'Fully responsive canvas scaling smoothly across desktop, tablet, and mobile devices.',
      'Multi-modal input system supporting keyboard, mouse clicks, and mobile touch interactions.',
      'Procedural obstacle generation with efficient object recycling for smooth, infinite gameplay.',
      'Immersive collision feedback featuring camera shake, visual flashes, and custom audio cues.',
      'Custom-rendered dynamic score displays with real-time digit tracking and best score management.',
    ],
    platformIcons: ['assets/icons/website.webp'],
    storeButtons: [
      {
        'name': 'Website',
        'icon': 'assets/icons/website.webp',
        'url': 'https://flappy-bird-by-tony.vercel.app/',
      },
      {
        'name': 'GitHub',
        'icon': 'assets/icons/github.webp',
        'url': 'https://github.com/ThetHtooKyaw/Flappy-Bird-Clone.git',
      },
    ],
  ),
];
