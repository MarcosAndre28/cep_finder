import 'package:cep_finder/core/common/widgets/bottom_navigation_bar.dart';
import 'package:cep_finder/src/booklet/presentation/views/passbook.dart';
import 'package:cep_finder/src/map/presentation/views/map_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  static const routeName = '/home';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int bottomSelectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Home Page")),
      body: _buildPageView(context),
      bottomNavigationBar: BottomNavigationBarWidget(
        currentIndex: bottomSelectedIndex,
      ),
    );
  }

  // Método para renderizar o conteúdo da página dependendo da navegação
  Widget _buildPageView(BuildContext context) {
    return Navigator(
      onGenerateRoute: (settings) {
        // Gerenciar as páginas dentro da HomePage
        if (settings.name == '/map') {
          return MaterialPageRoute(
            builder: (_) {
              return const MapPage();  // Aqui, o MapPage recebe a injeção
            },
          );
        } else if (settings.name == '/booklet') {
          return MaterialPageRoute(
            builder: (_) => const BookletPage(),
          );
        }
        return MaterialPageRoute(builder: (_) => const SizedBox.shrink());
      },
    );
  }

  // Método para navegação do BottomNavigationBar
  void _bottomTapped(int index) {
    setState(() {
      bottomSelectedIndex = index;
      if (index == 0) {
        context.go('/home/map');  // Vai navegar para /home/map sem sair da HomePage
      } else if (index == 1) {
        context.go('/home/booklet');  // Vai navegar para /home/booklet
      }
    });
  }
}
