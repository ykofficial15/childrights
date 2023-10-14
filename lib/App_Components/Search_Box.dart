import 'package:flutter/material.dart';

class SearchBox extends StatefulWidget {
  const SearchBox({super.key});

  @override
  State<SearchBox> createState() => _SearchBoxState();
}

class _SearchBoxState extends State<SearchBox> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      cursorColor: Colors.purple,
      decoration: InputDecoration(
        hintText: 'Search...',
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.purple),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.purpleAccent),
        ),
        prefixIcon: Icon(Icons.search, color: Colors.purple),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.purple),
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }
}
