import 'package:flutter/material.dart';
import '../../data/mock_grocery_repository.dart';
import '../groceries/grocery_list.dart';

class GroceryFilter extends StatefulWidget {
  const GroceryFilter({super.key});

  @override
  State<GroceryFilter> createState() => _GroceryFilterState();
}

class _GroceryFilterState extends State<GroceryFilter> {
  String searchText = '';

  @override
  Widget build(BuildContext context) {
    final filteredGroceries = dummyGroceryItems.where((grocery) {
      return grocery.name.toLowerCase().startsWith(searchText.toLowerCase());
    }).toList();

    return Scaffold(
      appBar: AppBar(title: const Text('Search Groceries')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search grocery...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onChanged: (value) {
                setState(() {
                  searchText = value;
                });
              },
            ),
          ),

          Expanded(
            child: filteredGroceries.isEmpty
                ? const Center(child: Text('No groceries found'))
                : ListView.builder(
                    itemCount: filteredGroceries.length,
                    itemBuilder: (context, index) {
                      final grocery = filteredGroceries[index];
                      return ListTile(
                        leading: Container(
                          width: 15,
                          height: 15,
                          color: grocery.category.color,
                        ),
                        title: Text(grocery.name),
                        trailing: Text(grocery.quantity.toString()),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
