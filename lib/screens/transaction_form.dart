import 'dart:async';

import 'package:bytebank/components/progress.dart';
import 'package:bytebank/components/response_dialog.dart';
import 'package:bytebank/components/transaction_auth_dialog.dart';
import 'package:bytebank/http/webclient.dart';
import 'package:bytebank/http/webclients/transactions_webclient.dart';
import 'package:bytebank/model/contact.dart';
import 'package:bytebank/model/transactions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

abstract class TransactionFormState {
  const TransactionFormState();
}

class InitTransactionFormState extends TransactionFormState {
  const InitTransactionFormState();
}

class LoadingTransactionFormState extends TransactionFormState {
  const LoadingTransactionFormState();
}



class TransactionFormCubit extends Cubit<TransactionFormState>{
  TransactionFormCubit() : super(InitTransactionFormState());

  Future _showSuccessfulMessage(BuildContext context) async {
    await showDialog(
        context: context,
        builder: (contextDialog) {
          return SuccessDialog('Successful Transaction');
        });
  }



  void _showFailureMessage(BuildContext context,{String message = 'Unknown Error'}) {
    showDialog(
        context: context,
        builder: (contextDialog) {
          return FailureDialog(message);
        });
  }

  void save(Transaction transactionCreated, String password,
      BuildContext context) async {
    emit(LoadingTransactionFormState());
    Transaction transaction = await _send(transactionCreated, password, context);
    if (transaction != null) {
      await _showSuccessfulMessage(context);
      Navigator.pop(context);
    }
  }
  Future<Transaction> _send(Transaction transactionCreated, String password, BuildContext context) async {

    final Transaction transaction =
    await TransactionsWebClient().save(transactionCreated, password).catchError((error) {
      _showFailureMessage(context,message: error.message);
    }, test: (error) => error is HttpException).catchError((error){
      _showFailureMessage(context,message: 'I could not talk to the server');
    },test: (error) => error is TimeoutException).catchError((error){
      _showFailureMessage(context);
    },test: (error) => error is Exception);

    return transaction;
  }

}

class TransactionFormContainer extends StatelessWidget {
  final Contact _contact;
  TransactionFormContainer(this._contact);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<TransactionFormCubit>(
      create: (_) => TransactionFormCubit(),
      child: TransactionFormView(_contact),
    );
  }
}




class TransactionFormView extends StatelessWidget {
  final TextEditingController _valueController = TextEditingController();
  final TransactionsWebClient _webClient = TransactionsWebClient();
  final String transactionId = Uuid().v4();

  final Contact _contact;
  TransactionFormView(this._contact);

  @override
  Widget build(BuildContext context) {
    print('The Transacton UUID is: $transactionId');
    return Scaffold(
      appBar: AppBar(
        title: Text('New transaction'),
      ),
      body: BlocBuilder<TransactionFormCubit, TransactionFormState>(
        builder: (context, state){
          if(state is InitTransactionFormState){
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      _contact.name,
                      style: TextStyle(
                        fontSize: 24.0,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 16.0),
                      child: Text(
                        _contact.accountNumber.toString(),
                        style: TextStyle(
                          fontSize: 32.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 16.0),
                      child: TextField(
                        controller: _valueController,
                        style: TextStyle(fontSize: 24.0),
                        decoration: InputDecoration(labelText: 'Value'),
                        keyboardType: TextInputType.numberWithOptions(decimal: true),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 16.0),
                      child: SizedBox(
                        width: double.maxFinite,
                        child: RaisedButton(
                          child: Text('Transfer'),
                          onPressed: () {
                            final double value =
                            double.tryParse(_valueController.text);
                            final transactionCreated =
                            Transaction(transactionId,value, _contact);
                            showDialog(
                                context: context,
                                builder: (contextDialog) {
                                  return TransactionsAuthDialog(
                                    onConfirm: (String password) {
                                      BlocProvider.of<TransactionFormCubit>(context).save(transactionCreated, password, context);
                                    },
                                  );
                                });
                          },
                        ),
                      ),
                    )
                  ],
                ),
              ),
            );
          }
          if(state is LoadingTransactionFormState){
            return Progress();
          }
          return Text("Unknown Error");
        },
      ),
    );
  }
}
