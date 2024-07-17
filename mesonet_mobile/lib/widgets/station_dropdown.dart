// import 'package:flutter/material.dart';

// Widget renderStationDropdown(List<dynamic> data) {
//   if (data.isEmpty) {
//     return const CircularProgressIndicator();
//   } else {
//     return DropdownButton<String>(
//                         hint: const Text('Select Station'),
//                         value: _selectedItem,
//                         items: data.map<DropdownMenuItem<String>>((item) {
//                             return DropdownMenuItem<String>(
//                                 value: '${item['station']}: ${item['name']}',
//                                 child: Text('${item['station']}: ${item['name']}'),
//                             );
//                         }).toList(),
//                         onChanged: (String? newValue) {
//                             setState(() {
//                                 _selectedItem = newValue;
//                             });
//                         },
//                     )
//   }
// }


