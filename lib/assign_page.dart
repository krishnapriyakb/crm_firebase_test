// import 'package:crm_firebase_test/modals/customer_modal.dart';
// import 'package:crm_firebase_test/modals/designer_modal.dart';
// import 'package:crm_firebase_test/services/apis.dart';
// import 'package:flutter/material.dart';

// class AssignPage extends StatefulWidget {
//   const AssignPage({Key? key}) : super(key: key);

//   @override
//   State<AssignPage> createState() => _AssignPageState();
// }

// class _AssignPageState extends State<AssignPage> {
//   DesignerModal? selectedDesigner;
//   CustomerModal? selectedCustomer;
//   late List<CustomerModal> customers;
//   late List<DesignerModal> designers;

//   @override
//   void initState() {
//     super.initState();
//     fetchCustomersAndDesigners();
//   }

//   void fetchCustomersAndDesigners() async {
//     customers = await ApiServices().fetchAllCustomers();
//     designers = await ApiServices().fetchAllDesigners();
//     setState(() {});
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Dropdown and Button Example'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             if (designers != null && designers.isNotEmpty)
//               DropdownButtonFormField<DesignerModal>(
//                 decoration: const InputDecoration(
//                   labelText: 'Select Designer',
//                   border: OutlineInputBorder(),
//                 ),
//                 value: selectedDesigner,
//                 items: designers.map((DesignerModal designer) {
//                   return DropdownMenuItem<DesignerModal>(
//                     value: designer,
//                     child: Text(designer.cEmail),
//                   );
//                 }).toList(),
//                 onChanged: (newValue) {
//                   setState(() {
//                     selectedDesigner = newValue;
//                   });
//                 },
//               ),
//             const SizedBox(height: 16),
//             if (customers != null && customers.isNotEmpty)
//               DropdownButtonFormField<CustomerModal>(
//                 decoration: const InputDecoration(
//                   labelText: 'Select Customer',
//                   border: OutlineInputBorder(),
//                 ),
//                 value: selectedCustomer,
//                 items: customers.map((CustomerModal customer) {
//                   return DropdownMenuItem<CustomerModal>(
//                     value: customer,
//                     child: Text(customer.cEmail),
//                   );
//                 }).toList(),
//                 onChanged: (newValue) {
//                   setState(() {
//                     selectedCustomer = newValue;
//                   });
//                 },
//               ),
//             const SizedBox(height: 16),
//             ElevatedButton(
//               onPressed: () async {
//                 if (selectedDesigner != null && selectedCustomer != null) {
//                   await ApiServices().assignDesignerToCustomer(
//                       selectedDesigner!.nId, selectedCustomer!.id);
//                   ScaffoldMessenger.of(context).showSnackBar(
//                     SnackBar(
//                       content: Text(
//                         'Assigned Designer: ${selectedDesigner!.cEmail}\nAssigned Customer: ${selectedCustomer!.cEmail}',
//                       ),
//                     ),
//                   );
//                 } else {
//                   ScaffoldMessenger.of(context).showSnackBar(
//                     const SnackBar(
//                       content: Text('Please select both designer and customer'),
//                     ),
//                   );
//                 }
//               },
//               child: const Text('Assign'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
