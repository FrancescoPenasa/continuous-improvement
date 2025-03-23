import 'dart:convert';

enum TransactionType { income, outcome }

class Transaction {
  final String id;
  final double amount;
  final String description;
  final DateTime timestamp;
  final TransactionType type;

  Transaction({
    required this.id,
    required this.amount,
    required this.description,
    required this.timestamp,
    required this.type,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      id: json['id'],
      amount: json['amount'].toDouble(),
      // Ensure the amount is a double
      description: json['description'],
      timestamp: DateTime.parse(json['timestamp']),
      // Parse the timestamp string to DateTime
      type: _stringToTransactionType(json['type']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'amount': amount,
      'description': description,
      'timestamp': timestamp.toIso8601String(),
      // Convert DateTime to ISO 8601 string
      'type': _transactionTypeToString(type),
    };
  }

  // Helper method to create a Transaction object from a JSON string
  static Transaction fromJsonString(String jsonString) {
    final Map<String, dynamic> json = jsonDecode(jsonString);
    return Transaction.fromJson(json);
  }

  // Helper method to convert a Transaction object into a JSON string
  String toJsonString() {
    final Map<String, dynamic> json = toJson();
    return jsonEncode(json);
  }

  // Helper methods for enum conversion
  static TransactionType _stringToTransactionType(String value) {
    switch (value) {
      case 'income':
        return TransactionType.income;
      case 'outcome':
        return TransactionType.outcome;
      default:
        throw ArgumentError('Invalid transaction type: $value');
    }
  }

  static String _transactionTypeToString(TransactionType type) {
    return type == TransactionType.income ? 'income' : 'outcome';
  }
}
