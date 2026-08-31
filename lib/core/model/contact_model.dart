class ContactModel {
  final String icon;
  final String tooltip;
  final String url;
  ContactModel({required this.icon, required this.tooltip, required this.url});
}

List<ContactModel> contacts = [
  ContactModel(
    icon: 'assets/icons/github.webp',
    tooltip: 'GitHub',
    url: 'https://github.com/ThetHtooKyaw',
  ),
  ContactModel(
    icon: 'assets/icons/linkedin.webp',
    tooltip: 'LinkedIn',
    url: 'https://www.linkedin.com/in/tonyjohnsons/',
  ),
  ContactModel(
    icon: 'assets/icons/gmail.webp',
    tooltip: 'Gmail',
    url: 'mailto:2003tonyc123@gmail.com',
  ),
];
