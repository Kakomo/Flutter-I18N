import 'package:bytebank/components/localization.dart';
import 'package:bytebank/components/localization_lazy.dart';
import 'package:bytebank/screens/contacts_list.dart';
import 'package:bytebank/screens/name.dart';
import 'package:bytebank/screens/transactions_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DashboardContainer extends StatelessWidget {
  final String language;

  DashboardContainer(this.language);
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => NameCubit("Kako"),
      child: I18NLoadingContainer(
          (messages) => DashboardView(messages), language
      ),
    );
  }
}


class DashboardView extends StatelessWidget {
  final I18NMessages _messages;
  
  DashboardView(this._messages);

  @override
  Widget build(BuildContext context) {
    final i18n = DashboardViewi18N(context);
    return Scaffold(
      appBar: AppBar(
        title: BlocBuilder<NameCubit, String>(
          builder: (context, state) => Text("Welcome $state"),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset('images/bytebank_logo.png'),
          ),
          Container(
            height: 120,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                _FeatureItem(
                  _messages.get("transfer"),
                  Icons.monetization_on,
                  onClick: () {
                    _showContactsList(context);
                  },
                ),
                _FeatureItem(
                  _messages.get("transaction_feed"),
                  Icons.description,
                  onClick: () {
                    _showTransactionsList(context);
                  },
                ),
                _FeatureItem(
                  _messages.get("change_name"),
                  Icons.person_outline,
                  onClick: () {
                    _showChangeName(context);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showTransactionsList(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => TransactionsList(),
    ));
  }
}
void _showContactsList(BuildContext context){
  Navigator.of(context).push(MaterialPageRoute(
    builder: (context) => ContactsListContainer(),
  ));
}
void _showChangeName(BuildContext contextBloc){
  Navigator.of(contextBloc).push(MaterialPageRoute(
    builder: (context) => BlocProvider.value(
      value: BlocProvider.of<NameCubit>(contextBloc),
      child: NameContainer(),
    ),
  ));
}

class _FeatureItem extends StatelessWidget {
  final String name;
  final IconData icon;
  final Function onClick;

  _FeatureItem(this.name, this.icon, {@required this.onClick});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        color: Theme.of(context).primaryColor,
        child: InkWell(
          onTap: () {
            onClick();
          },
          child: Container(
            padding: EdgeInsets.all(8.0),
            height: 100,
            width: 150,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(
                  icon,
                  size: 24.0,
                  color: Colors.white,
                ),
                Text(
                  name,
                  style: TextStyle(fontSize: 16.0, color: Colors.white),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
