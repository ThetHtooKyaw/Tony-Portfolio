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
    type: 'Horoscope website',
    labels: ['HTML5, CSS, JavaScript'],
    description:
        'A fun horoscope website that lets users uncover their zodiac related true self, strengths, weaknesses, and compatibility through a dynamic date-driven experience.',
    highlight: [
      'Interactive spinning wheel that responds dynamically to user input',
      'Custom-built scrollable date pickers with smooth step-by-step transitions'
    ],
    storeButtons: [
      {'name': 'Website', 'url': 'https://soulscompass.vercel.app/'},
      {
        'name': 'GitHub',
        'url': 'https://github.com/ThetHtooKyaw/Soul-Compass.git',
      },
    ],
  ),
];
