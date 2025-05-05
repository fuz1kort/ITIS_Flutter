import 'package:flutter/material.dart';

class ExtraPage extends StatelessWidget {
  const ExtraPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Дополнительная страница')),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue),
              child: Text(
                'Меню',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            ListTile(
              title: Text('Главная страница'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  '/',
                  (route) => false, // Удаляем все предыдущие маршруты
                );
              },
            ),
            ListTile(
              title: Text('Доп. страница'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/extra'); // Закрываем меню
              },
            ),
          ],
        ),
      ),
      body: Center(
        child: Text(
          'Это текст-рыба для дополнительной страницы.',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
