import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addTx;

  const NewTransaction(this.addTx, {super.key});

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _selectedDate;

  void _submitData() {
    if (_amountController.text.isEmpty) {
      return;
    }
    final enteredTitle = _titleController.text;
    final enteredAmount = double.parse(_amountController.text);
    if (enteredTitle.isEmpty || enteredAmount <= 0 || _selectedDate == null) {
      return;
    }
    widget.addTx(enteredTitle, enteredAmount, _selectedDate);
    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2021),
            lastDate: DateTime.now())
        .then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        child: Container(
          padding: EdgeInsets.only(
              left: 10,
              right: 10,
              top: 10,
              bottom: MediaQuery.of(context).viewInsets.bottom + 10
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextField(
                decoration: const InputDecoration(labelText: 'খরচের বর্ণনা'),
                // onChanged: (val){
                //   titleInput = val;
                // },
                controller: _titleController,
                onSubmitted: (_) => _submitData(),
              ),
              TextField(
                decoration: const InputDecoration(labelText: 'টাকা'),
                // onChanged: (val){
                //   amountInput = val;
                // },
                keyboardType: TextInputType.number,
                controller: _amountController,
                onSubmitted: (_) => _submitData(),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  children: [
                    Expanded(
                        child: Text(
                      _selectedDate == null
                          ? 'তারিখ নির্বাচন হইনি !'
                          : 'নির্বাচিত তারিখ: ${DateFormat.yMd().format(_selectedDate!)}',
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    )),
                    const SizedBox(
                      width: 10,
                    ),
                    ElevatedButton(
                      onPressed: _presentDatePicker,
                      style:
                          ElevatedButton.styleFrom(backgroundColor: Colors.white),
                      child: const Text(
                        'তারিখ নির্বাচন',
                        style: TextStyle(
                            color: Colors.purple, fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ),
              ),
              ElevatedButton(
                  onPressed: _submitData,
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.purple),
                  child: const Text(
                    'খরচ যোগ করুন',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
