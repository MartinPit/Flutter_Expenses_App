import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  @override
  final List<Transaction> _transactions;
  final void Function(String) _transactionDeletionHandeler;

  TransactionList(this._transactions, this._transactionDeletionHandeler);

  Widget build(BuildContext context) {
    return _transactions.isEmpty
        ? LayoutBuilder(builder: (ctx, contraints) {
      return Column(
        children: [
          Text(
            'No Transactions!',
            style: Theme
                .of(context)
                .textTheme
                .titleMedium,
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            height: contraints.maxHeight * 0.6,
            child: Image.asset(
              'assets/images/waiting.png',
              fit: BoxFit.cover,
            ),
          )
        ],
      );
    })
        : ListView.builder(
      itemBuilder: (ctx, index) {
        return Card(
          margin: EdgeInsets.symmetric(vertical: 8, horizontal: 20),
          elevation: 5,
          child: ListTile(
            leading: Container(
              height: double.infinity,
              width: 56,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Theme
                    .of(context)
                    .colorScheme
                    .primary,
              ),
              child: Padding(
                padding: const EdgeInsets.all(6.0),
                child: FittedBox(
                  child: Text(
                    '\$${_transactions[index].amount.toStringAsFixed(1)}',
                    style: TextStyle(
                      color: Theme
                          .of(context)
                          .colorScheme
                          .onPrimary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            title: Text(
              _transactions[index].title,
              style: Theme
                  .of(context)
                  .textTheme
                  .titleMedium,
            ),
            subtitle: Text(
              DateFormat.yMMMd().format(_transactions[index].date),
              style: TextStyle(
                color: Theme
                    .of(context)
                    .textTheme
                    .titleSmall!
                    .color,
              ),
            ),
            trailing: MediaQuery
                .of(context)
                .size
                .width > 600
                ? TextButton.icon(
              onPressed: () =>
                  _transactionDeletionHandeler(
                      _transactions[index].id),
              icon: Icon(Icons.delete),
              label: Text('Delete'),
            )
                : IconButton(
              icon: Icon(Icons.delete),
              onPressed: () =>
                  _transactionDeletionHandeler(
                      _transactions[index].id),
            ),
          ),
        );
      },
      itemCount: _transactions.length,
    );
  }
}
