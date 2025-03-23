import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';

import '../models/transaction_model.dart';

class TransactionImporterController {
  // Method to let the user pick a file and import transactions
  Future<List<Transaction>> importTransactions() async {
    try {
      // Let the user pick a JSON file
      FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.custom, allowedExtensions: ['json','txt']);

      if (result == null) {
        // User canceled the picker
        // print("No file selected.");
        return [];
      }

      // Get the picked file
      final filePath = result.files.single.path;
      if (filePath == null) {
        throw ArgumentError("Invalid file path");
      }

      // Read the file
      final file = File(filePath);
      final jsonString = await file.readAsString();

      // Decode JSON into a list of maps
      final List<dynamic> jsonList = jsonDecode(jsonString);

      // Convert each map to a Transaction object
      return jsonList.map((json) => Transaction.fromJson(json)).toList();
    } catch (e) {
      // Handle errors (e.g., invalid file, bad format)
      // print("Error importing transactions: $e");
      return [];
    }
  }
}