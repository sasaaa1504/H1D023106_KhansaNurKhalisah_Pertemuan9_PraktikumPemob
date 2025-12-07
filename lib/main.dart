import 'package:flutter/material.dart';
import 'package:h1d023106_tugas7/login_page.dart';
import 'package:h1d023106_tugas7/gallery_page.dart';
import 'package:h1d023106_tugas7/services_page.dart';
import 'package:h1d023106_tugas7/contact_page.dart';
import 'package:h1d023106_tugas7/profile_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Router Flutter',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const LoginPage(),
      routes: {
        '/gallery': (context) => const GalleryPage(),
        '/services': (context) => const ServicesPage(),
        '/contact': (context) => const ContactPage(),
        '/profile': (context) => const ProfilePage(),
      },
    );
  }
}
