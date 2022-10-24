import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTx;
  const TransactionList(this.transactions, this.deleteTx, {super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 450,
      child: transactions.isEmpty
          ? Column(
              children: [
                Text(
                  'এখনও কোন খরচ যোগ করা হয়নি!',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: 250,
                  child: Image.asset(
                    'assets/images/wating.png',
                    fit: BoxFit.cover,
                  ),
                )
              ],
            )
          : ListView.builder(
              itemBuilder: (context, indext) {
                return Card(
                  elevation: 6,
                  margin:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                  child: ListTile(
                      leading: CircleAvatar(
                        radius: 30,
                        child: Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: FittedBox(
                            child: Text(
                                '\$${transactions[indext].amount!.toStringAsFixed(2)}'),
                          ),
                        ),
                      ),
                      title: Text(transactions[indext].title.toString(),
                          style: const TextStyle(fontWeight: FontWeight.bold)),
                      subtitle: Text(
                        DateFormat.yMMMMEEEEd()
                            .format(transactions[indext].date!),
                      ),
                    trailing: IconButton(onPressed: () => deleteTx(transactions[indext].id), icon: const Icon(Icons.delete),
                    color: Theme.of(context).errorColor,),
                  ),
                );
              },
              itemCount: transactions.length,
            ),
    );
  }
}
