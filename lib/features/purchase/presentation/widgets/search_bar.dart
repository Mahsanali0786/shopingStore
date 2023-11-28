import 'package:flutter/material.dart';
import 'package:mobilestore/core/utils/typedef.dart';

class CustomSearchBar extends StatelessWidget {
  const CustomSearchBar(
      {super.key,
      required this.searchFieldController,
      required this.onChangeCallBack});

  final TextEditingController searchFieldController;
  final void Function(String) onChangeCallBack;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Padding(
        padding: const EdgeInsets.all(1.0),
        child: TextField(
          controller: searchFieldController,
          onChanged: onChangeCallBack,
          style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w800),
          decoration: InputDecoration(
            isDense: true,
            hintText: 'Search...',
            prefixIcon: const Icon(Icons.search, size: 20),
            focusColor: Colors.black,
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: const BorderSide(color: Colors.black, width: 1)),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: const BorderSide(color: Colors.black, width: 1)),
          ),
        ),
      ),
    );
  }
}
