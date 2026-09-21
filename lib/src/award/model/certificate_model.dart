class MinorCertificateModel {
  final String image;
  final String title;
  final bool haveCollection;
  final List<MinorCertificateModel>? certificates;

  MinorCertificateModel({
    required this.image,
    required this.title,
    required this.haveCollection,
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

List<MinorCertificateModel> minorCertificates = [
  MinorCertificateModel(
    image: 'assets/images/dart_1.webp',
    title: 'Dart Language Certificates',
    haveCollection: true,
    certificates: dartCertificates,
  ),
  MinorCertificateModel(
    image: 'assets/images/kotlin_1.webp',
    title: 'Kotlin Language Certificates',
    haveCollection: true,
    certificates: kotlinCertificates,
  ),
  MinorCertificateModel(
    image: 'assets/images/flutter_1.webp',
    title: 'Flutter Development Certificate',
    haveCollection: false,
  ),
  MinorCertificateModel(
    image: 'assets/images/java_1.webp',
    title: 'Java Programming Language Certificate',
    haveCollection: false,
  ),
];

List<MinorCertificateModel> dartCertificates = [
  MinorCertificateModel(
    image: 'assets/images/dart_1.webp',
    title: 'Dart Programming for Beginners Certificate',
    haveCollection: false,
  ),
  MinorCertificateModel(
    image: 'assets/images/dart_2.webp',
    title: 'Dart Foundations Certificate',
    haveCollection: false,
  ),
  MinorCertificateModel(
    image: 'assets/images/dart_3.webp',
    title: 'Data Structures in Dart Certificate',
    haveCollection: false,
  ),
  MinorCertificateModel(
    image: 'assets/images/dart_4.webp',
    title: 'Iterations & Loops in Dart Certificate',
    haveCollection: false,
  ),
  MinorCertificateModel(
    image: 'assets/images/dart_5.webp',
    title: 'Functions in Dart Certificate',
    haveCollection: false,
  ),
  MinorCertificateModel(
    image: 'assets/images/dart_6.webp',
    title: 'Object-Oriented Programming in Dart Certificate',
    haveCollection: false,
  ),
];

List<MinorCertificateModel> kotlinCertificates = [
  MinorCertificateModel(
    image: 'assets/images/kotlin_1.webp',
    title: 'Kotlin Programming for Beginners Certificate',
    haveCollection: false,
  ),
  MinorCertificateModel(
    image: 'assets/images/kotlin_2.webp',
    title: 'Kotlin Foundations Certificate',
    haveCollection: false,
  ),
  MinorCertificateModel(
    image: 'assets/images/kotlin_3.webp',
    title: 'Data Structures in Kotlin Certificate',
    haveCollection: false,
  ),
  MinorCertificateModel(
    image: 'assets/images/kotlin_4.webp',
    title: 'Iterations & Loops in Kotlin Certificate',
    haveCollection: false,
  ),
  MinorCertificateModel(
    image: 'assets/images/kotlin_5.webp',
    title: 'Functions in Kotlin Certificate',
    haveCollection: false,
  ),
  MinorCertificateModel(
    image: 'assets/images/kotlin_6.webp',
    title: 'Object-Oriented Programming in Kotlin Certificate',
    haveCollection: false,
  ),
];
