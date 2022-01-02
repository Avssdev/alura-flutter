import 'package:flutter/material.dart';

void main() {
  runApp(const ByteBankApp());
}

class ByteBankApp extends StatelessWidget {
  const ByteBankApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: TransfersList(),
    );
  }
}

class TransferForm extends StatelessWidget {
  TransferForm({Key? key}) : super(key: key);

  final TextEditingController _controllerAccountField = TextEditingController();
  final TextEditingController _controllerValueField = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nova transferencia'),
      ),
      body: Column(
        children: [
          EditedField(
            controller: _controllerAccountField,
            label: 'Numero da conta',
            hint: '0000',
          ),
          EditedField(
            controller: _controllerAccountField,
            label: 'Numero da conta',
            hint: '0000',
            iconData: Icons.monetization_on,
          ),
          ElevatedButton(
            onPressed: () => _createTransfer(context),
            child: const Text('Confirmar'),
          ),
        ],
      ),
    );
  }

  void _createTransfer(BuildContext context) {
    final int? accountNumber = int.tryParse(_controllerAccountField.text);
    final double? value = double.tryParse(_controllerValueField.text);

    if (accountNumber != null && value != null) {
      final newTransfer = Transfer(value, accountNumber);
      Navigator.pop(context, newTransfer);
    }
  }
}

class EditedField extends StatelessWidget {
  const EditedField({
    this.label,
    this.hint,
    this.controller,
    this.iconData,
    Key? key,
  }) : super(key: key);

  final TextEditingController? controller;
  final String? label;
  final String? hint;
  final IconData? iconData;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        controller: controller,
        style: const TextStyle(
          fontSize: 24.0,
        ),
        decoration: InputDecoration(
          icon: iconData != null ? Icon(iconData) : null,
          labelText: label,
          hintText: hint,
        ),
        keyboardType: TextInputType.number,
      ),
    );
  }
}

class TransfersList extends StatelessWidget {
  const TransfersList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          TransferItem(Transfer(100.0, 1000)),
          TransferItem(Transfer(200.0, 2000)),
          TransferItem(Transfer(300.0, 3000)),
        ],
      ),
      appBar: AppBar(
        title: const Text('Transferencias'),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(
          Icons.add,
        ),
        onPressed: () {
          final Future future =
              Navigator.push(context, MaterialPageRoute(builder: (context) {
            return TransferForm();
          }));

          future.then((transferReceived) {});
        },
      ),
    );
  }
}

class TransferItem extends StatelessWidget {
  final Transfer _transfer;

  const TransferItem(
    this._transfer, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: const Icon(
          Icons.monetization_on,
        ),
        title: Text(_transfer.value.toString()),
        subtitle: Text(_transfer.account.toString()),
      ),
    );
  }
}

class Transfer {
  final double value;
  final int account;

  Transfer(this.value, this.account);

  @override
  String toString() {
    return 'Transfer {value: $value, account: $account}';
  }
}
