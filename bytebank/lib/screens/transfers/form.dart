import 'package:bytebank/models/transfer.dart';
import 'package:flutter/material.dart';
import 'package:bytebank/components/edit_field.dart';

const _appBarTitle = 'Nova transferencia';

const _labelAccountField = 'Numero da conta';
const _hintAccountField = '0000';

const _labelValueField = 'Valor';
const _hintValueField = '00.00';

const _labelSubmitButton = 'Confirmar';

class TransferForm extends StatefulWidget {
  const TransferForm({Key? key}) : super(key: key);

  @override
  State<TransferForm> createState() => _TransferFormState();
}

class _TransferFormState extends State<TransferForm> {
  final TextEditingController _controllerAccountField = TextEditingController();
  final TextEditingController _controllerValueField = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(_appBarTitle),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            EditField(
              controller: _controllerAccountField,
              label: _labelAccountField,
              hint: _hintAccountField,
            ),
            EditField(
              controller: _controllerValueField,
              label: _labelValueField,
              hint: _hintValueField,
              iconData: Icons.monetization_on,
            ),
            ElevatedButton(
              onPressed: () => _createTransfer(context),
              child: const Text(_labelSubmitButton),
            ),
          ],
        ),
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
