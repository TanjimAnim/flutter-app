import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/network/api_endpoints.dart';
import 'package:flutter_application_1/features/category/data/category_model.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({super.key});
  @override
  State<StatefulWidget> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  late Future<List<CategoryItem>> _categories;
  @override
  void initState() {
    super.initState();
    _categories = _fetchCategories();
  }

  Future<List<CategoryItem>> _fetchCategories() async {
    // getCategory expects two positional arguments: params and context
    final response = await getCategory({});
    final list = response['data'] as List;
    return list.map((e) => CategoryItem.fromJson(e)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Categories')),
      body: FutureBuilder<List<CategoryItem>>(
        future: _categories,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          final items = snapshot.data ?? [];
          return ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) {
              final item = items[index];
              return ListTile(title: Text(item.title));
            },
          );
        },
      ),
    );
  }
}
