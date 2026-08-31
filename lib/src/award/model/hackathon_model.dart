class HackathonModel {
  final String url;
  final String award;
  final String eventName;
  final String projectName;
  final List<String> image;
  final List<String> icons;
  final String description;

  HackathonModel({
    required this.url,
    required this.award,
    required this.eventName,
    required this.projectName,
    required this.image,
    required this.icons,
    required this.description,
  });
}

List<HackathonModel> hackathons = [
  HackathonModel(
    url: 'https://github.com/ThetHtooKyaw/Stepout-Customer-Support.git',
    award: 'Winner',
    eventName: 'Hack The Zodiac (2024)',
    projectName: 'Onyx',
    image: ['assets/images/onyx.webp'],
    icons: [
      'assets/icons/flutter_color.webp',
      'assets/icons/dart_color.webp',
      'assets/icons/gemini_color.webp',
    ],
    description:
        'Designed for eco-conscious businesses and consumers, this AI-powered platform transforms traditional customer support into a proactive green initiative. By integrating Gemini AI for automated assistance and smart recommendations, the app seamlessly guides users through verified trade-in services to minimize electronic waste. Through its unique green tax system, the platform empowers users to contribute to environmental conservation with every digital interaction.',
  ),
];
