class MinorCertificateModel {
  final String image;
  final String title;
  final bool detail;
  final List<MinorCertificateModel>? certificates;

  MinorCertificateModel({
    required this.image,
    required this.title,
    required this.detail,
    this.certificates,
  });
}

const List<String> majorCertificates = [
  'assets/images/internship_1.webp',
  'assets/images/internship_2.webp',
  'assets/images/workshop_1.webp',
  'assets/images/workshop_2.webp',
  'assets/images/webinar_1.webp',
  'assets/images/webinar_2.webp',
];

List<MinorCertificateModel> dartCertificates = [
  MinorCertificateModel(
    image: 'assets/images/dart_1.webp',
    title: 'Dart Programming for Beginners Certificate',
    detail: false,
  ),
  MinorCertificateModel(
    image: 'assets/images/dart_2.webp',
    title: 'Dart Foundations Certificate',
    detail: false,
  ),
  MinorCertificateModel(
    image: 'assets/images/dart_3.webp',
    title: 'Data Structures in Dart Certificate',
    detail: false,
  ),
  MinorCertificateModel(
    image: 'assets/images/dart_4.webp',
    title: 'Iterations & Loops in Dart Certificate',
    detail: false,
  ),
  MinorCertificateModel(
    image: 'assets/images/dart_5.webp',
    title: 'Functions in Dart Certificate',
    detail: false,
  ),
  MinorCertificateModel(
    image: 'assets/images/dart_6.webp',
    title: 'Object-Oriented Programming in Dart Certificate',
    detail: false,
  ),
];

List<MinorCertificateModel> kotlinCertificates = [
  MinorCertificateModel(
    image: 'assets/images/kotlin_1.webp',
    title: 'Kotlin Programming for Beginners Certificate',
    detail: false,
  ),
  MinorCertificateModel(
    image: 'assets/images/kotlin_2.webp',
    title: 'Kotlin Foundations Certificate',
    detail: false,
  ),
  MinorCertificateModel(
    image: 'assets/images/kotlin_3.webp',
    title: 'Data Structures in Kotlin Certificate',
    detail: false,
  ),
  MinorCertificateModel(
    image: 'assets/images/kotlin_4.webp',
    title: 'Iterations & Loops in Kotlin Certificate',
    detail: false,
  ),
  MinorCertificateModel(
    image: 'assets/images/kotlin_5.webp',
    title: 'Functions in Kotlin Certificate',
    detail: false,
  ),
  MinorCertificateModel(
    image: 'assets/images/kotlin_6.webp',
    title: 'Object-Oriented Programming in Kotlin Certificate',
    detail: false,
  ),
];

List<MinorCertificateModel> minorCertificates = [
  MinorCertificateModel(
    image: 'assets/images/dart_1.webp',
    title: 'Dart Programming Language Certificates',
    detail: true,
    certificates: dartCertificates,
  ),
  MinorCertificateModel(
    image: 'assets/images/kotlin_1.webp',
    title: 'Kotlin Programming Language Certificates',
    detail: true,
    certificates: kotlinCertificates,
  ),
  MinorCertificateModel(
    image: 'assets/images/flutter_1.webp',
    title: 'Flutter Development Certificate',
    detail: false,
  ),
  MinorCertificateModel(
    image: 'assets/images/java_1.webp',
    title: 'Java Programming Language Certificate',
    detail: false,
  ),
];
