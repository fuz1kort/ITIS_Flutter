import 'package:flutter/material.dart';
import '../models/data_model.dart';
import '../data/static_data.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Главная страница'),
        bottom: TabBar(
          controller: _tabController,
          tabs: [Tab(text: 'Таб 1'), Tab(text: 'Таб 2')],
        ),
      ),
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
              },
            ),
            ListTile(
              title: Text('Доп. страница'),
              onTap: () {
                Navigator.pushNamed(context, '/extra');
              },
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [FirstTab(), SecondTab()],
      ),
    );
  }
}

class FirstTab extends StatelessWidget {
  final List<Item> items = StaticData.items;

  FirstTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        return ListTile(
          title: Text(item.title),
          trailing: ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => DetailPage(item: item)),
              );
            },
            child: Text('Перейти'),
          ),
        );
      },
    );
  }
}

class SecondTab extends StatelessWidget {
  const SecondTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (context) {
              return Container(
                padding: EdgeInsets.all(16),
                child: Text(
                  'Это текст-рыба для нижнего меню.',
                  style: TextStyle(fontSize: 18),
                ),
              );
            },
          );
        },
        child: Text('Показать нижнее меню'),
      ),
    );
  }
}

class DetailPage extends StatelessWidget {
  final Item item;

  const DetailPage({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Детали элемента')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Заголовок: ${item.title}', style: TextStyle(fontSize: 20)),
            SizedBox(height: 16),
            Text(
              'Описание: ${item.description}',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
