import 'package:bytebank/models/transfer.dart';
import 'package:bytebank/screens/transfers/form.dart';
import 'package:flutter/material.dart';

const _appBarTitle = 'Transferências';

class TransfersList extends StatefulWidget {
  TransfersList({
    Key? key,
  }) : super(key: key);

  final List<Transfer> _transferList = [];

  @override
  State<TransfersList> createState() => _TransfersListState();
}

class _TransfersListState extends State<TransfersList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: widget._transferList.length,
        itemBuilder: (context, index) {
          final transfer = widget._transferList[index];
          return TransferItem(transfer);
        },
      ),
      appBar: AppBar(
        title: const Text(_appBarTitle),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(
          Icons.add,
        ),
        onPressed: () {
          final Future<Transfer?> future = Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return const TransferForm();
              },
            ),
          );

          future.then(
            (transferReceived) => _updateList(transferReceived),
          );
        },
      ),
    );
  }

  void _updateList(Transfer? transferReceived) {
    if (transferReceived != null) {
      setState(() {
        widget._transferList.add(transferReceived);
      });
    }
  }
}

class TransferItem extends StatelessWidget {
  final Transfer _transfer;

  const TransferItem(this._transfer, {Key? key}) : super(key: key);

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
