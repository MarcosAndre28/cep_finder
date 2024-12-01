import 'package:cep_finder/core/common/widgets/bottom_navigation_bar.dart';
import 'package:flutter/material.dart';

class BookletPage extends StatefulWidget {
  const BookletPage({super.key});

  static const routeName = 'BookletPage';
  @override
  State<BookletPage> createState() => _BookletPageState();
}

class _BookletPageState extends State<BookletPage> {
  @override
  Widget build(BuildContext context) {
    return  const Scaffold(
      bottomNavigationBar:  BottomNavigationBarWidget(
        currentIndex: 1,
      ),
    );
  }
}
