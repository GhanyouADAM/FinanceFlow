import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:the_app/data/datasource/tables_properties/account_properties.dart';
import 'package:the_app/data/datasource/tables_properties/budget_properties.dart';
import 'package:the_app/data/datasource/tables_properties/category_properties.dart';
import 'package:the_app/data/datasource/tables_properties/transaction_properties.dart';
import 'package:the_app/data/models/account_model.dart';
import 'package:the_app/data/models/category_model.dart';
import 'package:the_app/data/models/transaction_model.dart';

abstract class LocalDataSource {
  //------account section --------------

  Future<AccountModel?> getAccount();

  Future<int> addAccount(AccountModel account);

  Future<int> updateAccount(AccountModel account);

  Future<int> deleteAccount(int id);

  //---------category section--------
  Future<List<CategoryModel>> getCategories();
  Future<List<CategoryModel>> getCategoriesByType(String type);

  Future<CategoryModel?> getCategoryById(int id);

  Future<int> addCategory(CategoryModel category);
  Future<int> updateCategory(CategoryModel category);

  Future<int> deleteCategory(int id);

  //-------------transaction section ----------


  Future<List<TransactionModel>> getTransactions();

  Future<List<TransactionModel>> getTransactionsByCategory(
    int categoryId,
  );

  Future<List<TransactionModel>> getTransactionByMonth(
    int year,
    int month,
  );

  Future<List<TransactionModel>> getTransactionByName(
    String name,
  );

  Future<int> addTransaction(TransactionModel transaction);

  Future<int> updateTransaction(TransactionModel transaction);

  Future<TransactionModel?> getTransactionById(int? id);

  Future<int> deleteTransaction(int id);

  Future<Map<String, double>> getSummary(int accountID);
  Future<Map<String, double>> getSummaryByCategory(int accountID);
}

//Database
class DatabaseHelper implements LocalDataSource {
  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('finance.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
      onConfigure: (db) async {
        // Activate foreign keys
        await db.execute('PRAGMA foreign_keys = ON');

        // Ensure foreign keys initialisation
        if (kDebugMode) {
          final List<Map<String, dynamic>> result = await db.rawQuery(
            'PRAGMA foreign_keys',
          );
          final bool isEnabled = result.first.values.first == 1;
          print('Foreign keys enabled: $isEnabled');
        }
      },
    );
  }

  Future _createDB(Database db, int version) async {
    // Creation of account table
    await db.execute('''
    CREATE TABLE $accountTable (
      $accId INTEGER PRIMARY KEY AUTOINCREMENT,
      $accName TEXT NOT NULL,
      $accAmount REAL NOT NULL
    )
  ''');

    // Creation of category table
    await db.execute('''
    CREATE TABLE $categoryTable (
      $catId INTEGER PRIMARY KEY AUTOINCREMENT,
      $catAccountId INTEGER NOT NULL,
      $catType TEXT NOT NULL,
      $catName TEXT NOT NULL,
      $catIcon TEXT NOT NULL,
      $catColor TEXT NOT NULL,
      FOREIGN KEY ($catAccountId) REFERENCES $accountTable($accId) ON DELETE CASCADE
    )
  ''');

    // Creation of transaction table
    await db.execute('''
CREATE TABLE $transactionTable (
  $transacId INTEGER PRIMARY KEY AUTOINCREMENT,
  $tCategoryId INTEGER NOT NULL,
  $tAccountId INTEGER NOT NULL,
  $transacAmount REAL NOT NULL,
  $transacDate TEXT NOT NULL,
  $transacNote TEXT,
  FOREIGN KEY ($tCategoryId) REFERENCES $categoryTable($catId) ON DELETE CASCADE,
  FOREIGN KEY ($tAccountId) REFERENCES $accountTable($accId) ON DELETE CASCADE
)
''');

    // creation of budget table
    await db.execute('''
CREATE TABLE $budgetTable (
  $budgetId INTEGER PRIMARY KEY AUTOINCREMENT,
  $budCategoryId INTEGER NOT NULL,
  $budgetAmount REAL NOT NULL,
  $budgetMonth TEXT NOT NULL,
  FOREIGN KEY ($budCategoryId) REFERENCES $categoryTable($catId) ON DELETE CASCADE
)
''');
  }

  //----------account section implementation ---------------
  @override
  Future<int> addAccount(AccountModel account) async {
    final db = await database;
    try {
      final accountId = await db.insert(
        accountTable,
        account.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      if (kDebugMode) print('account successfully added with id : $accountId');
      return accountId;
    } catch (e) {
      if (kDebugMode) print(" Error while adding account :$e");
      rethrow;
    }
  }

  @override
  Future<int> deleteAccount(int id) async {
    final db = await database;
    try {
      final deletedLines = await db.delete(
        accountTable,
        where: '$accId = ?',
        whereArgs: [id],
      );
      if (kDebugMode) print('$deletedLines lines deleted');
      return deletedLines;
    } catch (e) {
      if (kDebugMode) print("Error while deleting :$e");
      rethrow;
    }
  }


  @override
  Future<AccountModel?> getAccount() async {
    final db = await database;
    try {
      final maps = await db.query(
        accountTable,
        limit: 1,
      );
      if (maps.isNotEmpty) {
        if (kDebugMode) print('account found');
        return AccountModel.fromMap(maps.first);
      } else {
        if (kDebugMode) print('no account found');
        return null;
      }
    } catch (e) {
      if (kDebugMode) print(" Error while fetching the account :$e");
      rethrow;
    }
  }

  @override
  Future<int> updateAccount(AccountModel account) async {
    final db = await database;
    try {
      final updatedLines = await db.update(
        accountTable,
        account.toMap(),
        where: '$accId = ?',
        whereArgs: [account.mAccountId],
      );
      if (kDebugMode) print("$updatedLines lines updated successfully");
      return updatedLines;
    } catch (e) {
      if (kDebugMode) print("Error while updating the account :$e");
      rethrow;
    }
  }

  //-----------end of section -----------------

  //-----------category implementation section
  @override
  Future<int> addCategory(CategoryModel category) async {
    final db = await database;
    try {
    
      final categoryId = await db.insert(
        categoryTable,
        category.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      if (kDebugMode) print('category added successfully  id : $categoryId');
      return categoryId;
    } catch (e) {
      if (kDebugMode) print("Error while adding category :$e");
      rethrow;
    }
  }

  @override
  Future<int> deleteCategory(int id) async {
    final db = await database;
    try {
     
      final deletedLines = await db.delete(
        categoryTable,
        where: '$catId = ?',
        whereArgs: [id],
      );
      if (kDebugMode) print('$deletedLines lines deleted successfully from category');
      return deletedLines;
    } catch (e) {
      if (kDebugMode) print("Error while deleting category :$e");
      rethrow;
    }
  }

  @override
  Future<List<CategoryModel>> getCategories({int? accountId}) async {
    final db = await database;
    try {
      final maps = await db.query(
        categoryTable,
        where: accountId != null ? '$catAccountId = ?' : null,
        whereArgs: accountId != null ? [accountId] : null,
      );
      if (maps.isEmpty) {
        if (kDebugMode) print("Nothing found in category for this account");
        return [];
      } else {
        if (kDebugMode) print("${maps.length} categories found");
        return maps.map((map) => CategoryModel.fromMap(map)).toList();
      }
    } catch (e) {
      if (kDebugMode) print("Error while retrieving the categories:$e");
      rethrow;
    }
  }

  @override
  Future<List<CategoryModel>> getCategoriesByType(String type, {int? accountId}) async {
    final db = await database;
    try {
      final maps = await db.query(
        categoryTable,
        where: accountId != null ? '$catType = ? AND $catAccountId = ?' : '$catType = ?',
        whereArgs: accountId != null ? [type, accountId] : [type],
      );
      if (maps.isEmpty) {
        if (kDebugMode) print("Nothing found in category for this type/account");
        return [];
      } else {
        if (kDebugMode) print("${maps.length} categories found for type/account");
        return maps.map((map) => CategoryModel.fromMap(map)).toList();
      }
    } catch (e) {
      if (kDebugMode) print("Error while retrieving the categories by type/account:$e");
      rethrow;
    }
  }

  //-------transaction implementation section--------
  //to add a new transaction
  @override
  Future<int> addTransaction(TransactionModel transaction) async {
    final db = await database;
    try {
      //check if account exist before transaction
      final account = await getAccount();
      if (account == null) {
        throw Exception('account does not exist');
      }
      final CategoryModel? categoryExist = await getCategoryById(
        transaction.mTransactionCategoryId,
      );
      //check weather the category in which we are adding a new transaction exist or not
      if (categoryExist == null) throw Exception('category does not exist');
      final transactionId = await db.insert(
        transactionTable,
        transaction.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      //upate initial balance based on transaction type
      if(categoryExist.mCategoryType == 'income'){
        final updatedAccount = account.copyWith(mAccountAmount: (account.mAccountAmount + transaction.mTransactionAmount));
        await updateAccount(updatedAccount);
      }else if(categoryExist.mCategoryType == 'expense'){
        final updatedAccount = account.copyWith(mAccountAmount: (account.mAccountAmount - transaction.mTransactionAmount));
        await updateAccount(updatedAccount);
      }
      if (kDebugMode) print("transaction added successfully with id : $transactionId");
      return transactionId;
    } catch (e) {
      if (kDebugMode) print("Error while adding new transaction:$e");
      rethrow;
    }
  }

  //to delete a transaction
  @override
  Future<int> deleteTransaction(int id) async {
    final db = await database;
    try {
      //get the account
      final accountExist = await getAccount();
      if (accountExist == null) {
        throw Exception("Account does not Exist");
      }

      //get the transaction who about to be deleted
    final transaction = await getTransactionById(id);
      if(transaction == null){
       throw Exception('Account does not Exist');
      }

      // and finally the transactiion's category
       final CategoryModel? categoryExist = await getCategoryById(
        transaction.mTransactionCategoryId,
      );
      if (categoryExist == null) {
        throw Exception('category does not exist');
      }
      //update the initial balance based on deletion
      if(categoryExist.mCategoryType == 'income'){
        final updatedAccount = accountExist.copyWith(mAccountAmount: (accountExist.mAccountAmount + transaction.mTransactionAmount));
        await updateAccount(updatedAccount);
      }else if(categoryExist.mCategoryType == 'expense'){
        final updatedAccount = accountExist.copyWith(mAccountAmount: (accountExist.mAccountAmount - transaction.mTransactionAmount));
        await updateAccount(updatedAccount);
      }
      final deleteLines = await db.delete(
        transactionTable,
        where: "$transacId = ? ",
        whereArgs: [id],
      );

      if (kDebugMode) print("$deleteLines lines deleted from transactions");
      return deleteLines;
    } catch (e) {
      if (kDebugMode) print("Error while deleting transaction :$e");
      rethrow;
    }
  }

  @override
  Future<List<TransactionModel>> getTransactionByMonth(
    
    int year,
    int month,
  ) async {
    final String formattedMonth = month.toString().padLeft(
      2,
      '0',
    ); // allow to convert something like this : 1 for january to 01
    final searchingMonth =
        '%$year-$formattedMonth%'; // format for the query YYYY-MM
    final db = await database;
    try {
  
      final maps = await db.query(
        transactionTable,
        where: '$transacDate LIKE ?',
        whereArgs: [searchingMonth],
      );
      if (maps.isEmpty) {
        if (kDebugMode) print("No transactions found for this month : $searchingMonth");
        return [];
      } else {
        final transactions =
            maps.map((map) => TransactionModel.fromMap(map)).toList();
        if (kDebugMode) print("${transactions.length} transactions found for month: $searchingMonth",);
        return transactions;
      }
    } catch (e) {
      if (kDebugMode) print("Error while retrieving transactions for this date :$e");
      rethrow;
    }
  }

  // get the transactions by name entered by the user for searching purposes
  @override
  Future<List<TransactionModel>> getTransactionByName(
    String name,
  ) async {
    final searchTerm = '%$name%';
    final db = await database;

    try {
      final account = await getAccount();
      if (account == null) {
        throw Exception('account does not exist');
      }
      // Jointure avec la table catégorie pour filtrer sur la note ou le nom de la catégorie
      final maps = await db.rawQuery('''
        SELECT t.* FROM $transactionTable t
        INNER JOIN $categoryTable c ON t.$tCategoryId = c.$catId
        WHERE t.$transacNote LIKE ? OR c.$catName LIKE ?
      ''', [searchTerm, searchTerm]);
      if (maps.isEmpty) {
        if (kDebugMode) print("No transactions found for this term : $name");
        return [];
      } else {
        final transactions =
            maps.map((map) => TransactionModel.fromMap(map)).toList();
        if (kDebugMode) print("${transactions.length} transactions found for this term: $name",);
        return transactions;
      }
    } catch (e) {
      if (kDebugMode) print("Error while retrieving transactions for this term :$e");
      rethrow;
    }
  }

  //--fetch ALL transactions for an account
  @override
  Future<List<TransactionModel>> getTransactions() async {
    final db = await database;
    try {
  
      final maps = await db.query(
        transactionTable,
        orderBy: '$transacDate ASC',
      );
      if (maps.isEmpty) {
        if (kDebugMode) print("No transactions found for this account ");
        return [];
      } else {
        final transactions =
            maps.map((map) => TransactionModel.fromMap(map)).toList();
        if (kDebugMode) print("${transactions.length} transactions found for this account ",);
        return transactions;
      }
    } catch (e) {
      if (kDebugMode) print("Error while fetching all transactions for this account:$e");
      rethrow;
    }
  }

  // --fetch transaction by category
  @override
  Future<List<TransactionModel>> getTransactionsByCategory(
    int categoryId,
  ) async {
    final db = await database;
    try {
      
      final CategoryModel? categoryExist = await getCategoryById(categoryId);
      if (categoryExist == null) throw Exception('category does not exist');
      final maps = await db.query(
        transactionTable,
        where: '$tCategoryId = ?',
        whereArgs: [categoryId],
      );
      if (maps.isEmpty) {
        if (kDebugMode) print("No transactions found for this category");
        return [];
      } else {
        final transactions =
            maps.map((map) => TransactionModel.fromMap(map)).toList();
        if (kDebugMode) print("${transactions.length} transactions found for this category");
        return transactions;
      }
    } catch (e) {
      if (kDebugMode) print("Error while retrieving transactions for this category :$e");
      rethrow;
    }
  }

  // -- transaction update
  @override
  Future<int> updateTransaction(TransactionModel transaction) async {
    final db = await database;
    try {

      // check if account exist
      final accountExist = await getAccount(
      );
      if (accountExist == null) {
        throw Exception("Account does not Exist");
      }
      //now we check for the transaction
      final transactionExist = await getTransactionById(
        transaction.mTransactionId
      );
      if (transactionExist == null) {
        throw Exception("Transaction does not Exist");
      }

      //finally we check for the category
      final category = await getCategoryById(transaction.mTransactionCategoryId);
      if (category == null) {
        throw Exception('Category does not exist');
      }

      if(category.mCategoryType == 'income'){
        final updatedAccount = accountExist.copyWith(mAccountAmount: (accountExist.mAccountAmount + transactionExist.mTransactionAmount));
        await updateAccount(updatedAccount);
      }else if(category.mCategoryType == 'expense'){
        final updatedAccount = accountExist.copyWith(mAccountAmount: (accountExist.mAccountAmount - transactionExist.mTransactionAmount));
        await updateAccount(updatedAccount);
      }
      final updatedLines = await db.update(
        transactionTable,
        transaction.toMap(),
        where: '$transacId = ?',
        whereArgs: [
          transaction.mTransactionId,
        ],
      );
      if (kDebugMode) print('$updatedLines lines updated successfully');
      return updatedLines;
    } catch (e) {
      if (kDebugMode) print("Error while updating transaction :$e");
      rethrow;
    }
  }

  //--fetch transaction by his id and the account one
  @override
  Future<TransactionModel?> getTransactionById(int? id) async {
    final db = await database;
    try {
   
      final map = await db.query(
        transactionTable,
        where: '$transacId = ?',
        whereArgs: [id],
      );
      if (map.isEmpty) {
        return null;
      } else {
        return TransactionModel.fromMap(map.first);
      }
    } catch (e) {
      if (kDebugMode) print("Error while retrieving specific transaction:$e");
      rethrow;
    }
  }
  
  // @override
  // Future<List<CategoryModel>> getCategoriesByType(String type) async{
  //  final db = await database;

  //  try {
  //    final result = await db.query(categoryTable, where: '$catType = ?', whereArgs: [type]);
  //    if (result.isEmpty) {
  //      return [];
  //    }else{
  //       final models = result.map((element)=> CategoryModel.fromMap(element)).toList(); 
  //       return models;
  //    }
  //  } catch (e) {
  //    if(kDebugMode) print('Error while fetching categories for this type : $e');
  //    rethrow;
  //  }
  // }
  
  @override
  Future<CategoryModel?> getCategoryById(int id) async {
    final db = await database;
    try {
      final maps = await db.query(
        categoryTable,
        where: '$catId = ?',
        whereArgs: [id],
        limit: 1,
      );
      if (maps.isNotEmpty) {
        if (kDebugMode) print('Category found');
        return CategoryModel.fromMap(maps.first);
      } else {
        if (kDebugMode) print('No category found');
        return null;
      }
    } catch (e) {
      if (kDebugMode) print("Error while retrieving category: $e");
      rethrow;
    }
  }
  
  @override
  Future<Map<String, double>> getSummary(int accountID) async {
    final db = await database;
    try {
      // Récupérer toutes les transactions de ce compte
      final transactions = await db.query(
        transactionTable,
        where: '$tAccountId = ?',
        whereArgs: [accountID],
      );
      double totalIncome = 0;
      double totalExpense = 0;
      for (final tx in transactions) {
        // On récupère la catégorie pour savoir si c'est un revenu ou une dépense
        final categoryId = tx[tCategoryId] as int;
        final category = await getCategoryById(categoryId);
        if (category != null) {
          final amount = (tx[transacAmount] as num).toDouble();
          if (category.mCategoryType == 'income') {
            totalIncome += amount;
          } else if (category.mCategoryType == 'expense') {
            totalExpense += amount;
          }
        }
      }
      return {
        'income': totalIncome,
        'expense': totalExpense,
      };
    } catch (e) {
      if(kDebugMode) print('Error while calculating summary: $e');
      rethrow;
    }
  }

  @override
  Future<Map<String, double>> getSummaryByCategory(int accountID) async {
    final db = await database;
    try {
      // Récupérer toutes les transactions de ce compte
      final transactions = await db.query(
        transactionTable,
        where: '$tAccountId = ?',
        whereArgs: [accountID],
      );
      final Map<String, double> summary = {};
      for (final tx in transactions) {
        final categoryId = tx[tCategoryId] as int;
        final category = await getCategoryById(categoryId);
        if (category != null) {
          final categoryName = category.mCategoryName;
          final amount = (tx[transacAmount] as num).toDouble();
          summary[categoryName] = (summary[categoryName] ?? 0) + amount;
        }
      }
      return summary;
    } catch (e) {
      if (kDebugMode) print('Error while calculating summary by category: $e');
      rethrow;
    }
  }
  
  @override
  Future<int> updateCategory(CategoryModel category) async {
    final db = await database;

    try {
      final id = await db.update(categoryTable, category.toMap(),
        where: '$catId = ?',
        whereArgs: [category.mCategoryId]
      );
    
      return id;
    } catch (e) {
      if(kDebugMode) print('Error while updating the category : ${e.toString()}');
      rethrow;
    }
  }


  //-----------end of section ---------------
}
