class UserModel {
  final int? userId;
  final String? userName;
  final String hashPassword;

  UserModel({this.userId, required this.userName, required this.hashPassword});

  Map<String, dynamic> toMap() {
    return {
      'user_id': userId,
      'user_name': userName,
      'password_hash': hashPassword,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      userId: map['user_id'] as int?,
      userName: map['user_name'] as String,
      hashPassword: map['password_hash'] as String,
    );
  }
}

class UserQuoteModel {
  final int? quoteId;
  final int? userId; // Foreign key to User
  final String? quoteText;
  final String? author;

  UserQuoteModel({
    this.quoteId,
    required this.userId,
    required this.quoteText,
    required this.author,
  });

  factory UserQuoteModel.fromMap(Map<String, dynamic> map) {
    return UserQuoteModel(
      quoteId: map['quote_id'] as int,
      userId: map['user_id'] as int,
      quoteText: map['quote_text'] as String,
      author: map['author'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'quote_id': quoteId,
      'user_id': userId,
      'quote_text': quoteText,
      'author': author,
    };
  }
}
