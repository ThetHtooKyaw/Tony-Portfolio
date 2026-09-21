class MobileMenuItem {
  final String title;
  final String route;
  final Duration delay;

  const MobileMenuItem({
    required this.title,
    required this.route,
    required this.delay,
  });
}

class DesktopMenuItem {
  final String title;
  final String route;

  const DesktopMenuItem({required this.title, required this.route});
}

const List<MobileMenuItem> mobileMenuItems = [
  MobileMenuItem(title: 'Home', route: '/', delay: Duration(milliseconds: 150)),
  MobileMenuItem(
    title: 'Awards',
    route: '/awards',
    delay: Duration(milliseconds: 250),
  ),
  MobileMenuItem(
    title: 'Experiments',
    route: '/experiments',
    delay: Duration(milliseconds: 350),
  ),
  MobileMenuItem(
    title: 'Get in touch',
    route: '/contact',
    delay: Duration(milliseconds: 450),
  ),
];

const List<DesktopMenuItem> desktopMenuItems = [
  DesktopMenuItem(title: 'Home', route: '/'),
  DesktopMenuItem(title: 'Awards', route: '/awards'),
  DesktopMenuItem(title: 'Experiments', route: '/experiments'),
  // DesktopMenuItem(title: 'About', route: '/about'),
];
