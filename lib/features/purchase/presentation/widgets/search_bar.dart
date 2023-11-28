import 'package:flutter/material.dart';
import 'package:mobilestore/core/utils/typedef.dart';

class CustomSearchBar extends StatelessWidget {
  const CustomSearchBar({super.key, required this.searchFieldController, required this.onChangeCallBack});

  final TextEditingController searchFieldController;
  final void Function(String) onChangeCallBack;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Padding(
        padding: const EdgeInsets.all(0.0),
        child: TextField(
          controller: searchFieldController,
          onChanged: onChangeCallBack,
          decoration: InputDecoration(
            isDense: true ,
            hintText: 'Search...',
            prefixIcon: IconButton(
              icon: const Icon(Icons.search),
              onPressed: (){},
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: const BorderSide(color: Colors.black,width: 1.5)
            ),

          ),
        ),
      ),
    );
  }
}
