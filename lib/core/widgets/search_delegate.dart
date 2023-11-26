// import 'package:flutter/material.dart';
// import 'package:mobilestore/features/purchase/data/models/product_model.dart';
// import 'package:mobilestore/features/purchase/presentation/views/product_screen.dart';
//
// class SearchWidget extends SearchDelegate<ProductModel> {
//   @override
//   List<Widget> buildActions(BuildContext context) {
//     return [
//       IconButton(
//         icon: const Icon(Icons.clear),
//         onPressed: () {
//           query = '';
//         },
//       ),
//     ];
//   }
//
//   @override
//   Widget buildLeading(BuildContext context) {
//     return IconButton(
//       icon: const Icon(Icons.arrow_back),
//       onPressed: () {
//         Navigator.pop(context); // for closing the search page and going back
//       },
//     );
//   }
//
//   @override
//   Widget buildResults(BuildContext context) {
//     return ProductScreen();
//   }
//
//   @override
//   Widget buildSuggestions(BuildContext context) {
//     List<String> suggestions = ['task 1', 'task 2'];
//
//     return ListView.builder(
//         itemCount: suggestions.length,
//         itemBuilder: (context, index) {
//           final suggestion = suggestions[index];
//           return ListTile(
//             title: Text(suggestion),
//             onTap: () {
//               query = suggestion;
//               showResults(context);
//             },
//           );
//         });
//   }
// }
