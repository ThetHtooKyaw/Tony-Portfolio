class ExperimentProjectModel {
  final String name;
  final String type;
  final List<String> labels;
  final String description;
  final List<String> highlight;
  final List<Map<String, dynamic>> storeButtons;

  ExperimentProjectModel({
    required this.name,
    required this.type,
    required this.labels,
    required this.description,
    required this.highlight,
    required this.storeButtons,
  });
}

List<ExperimentProjectModel> experimentProjects = [
  ExperimentProjectModel(
    name: 'Souls Compass',
    type: 'Horoscope Website',
    labels: ['HTML5, CSS3, JavaScript'],
    description:
        'A fun horoscope website that lets users uncover their zodiac related true self, strengths, weaknesses, and compatibility through a dynamic date-driven experience.',
    highlight: [
      'Clean layout tailored for desktop, tablet, and mobile devices.',
      'Interactive spinning wheel that responds dynamically to user input',
      'Custom-built scrollable date pickers with smooth step-by-step transitions',
    ],
    storeButtons: [
      {'name': 'Website', 'url': 'https://soulscompass.vercel.app/'},
      {
        'name': 'GitHub',
        'url': 'https://github.com/ThetHtooKyaw/Soul-Compass.git',
      },
    ],
  ),
  ExperimentProjectModel(
    name: 'Flappy Bird Clone',
    type: 'Browser-Based Arcade Game',
    labels: ['Phaser.js', 'HTML5, CSS3, JavaScript'],
    description:
        'An addictive arcade-style Flappy Bird replica that challenges players to master precise flight mechanics, dodge dynamic obstacles, and push for the ultimate high score through a smooth web-based experience.',
    highlight: [
      'Fully responsive canvas scaling smoothly across desktop, tablet, and mobile devices.',
      'Multi-modal input system supporting keyboard, mouse clicks, and mobile touch interactions.',
      'Procedural obstacle generation with efficient object recycling for smooth, infinite gameplay.',
      'Immersive collision feedback featuring camera shake, visual flashes, and custom audio cues.',
      'Custom-rendered dynamic score displays with real-time digit tracking and best score management.',
    ],
    storeButtons: [
      {'name': 'Website', 'url': 'https://flappy-bird-by-tony.vercel.app/'},
      {
        'name': 'GitHub',
        'url': 'https://github.com/ThetHtooKyaw/Flappy-Bird-Clone.git',
      },
    ],
  ),
];
