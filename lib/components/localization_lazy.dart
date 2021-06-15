import 'package:bytebank/components/progress.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class I18NMessagesState {
  const I18NMessagesState();
}

class InitI18NMessagesState extends I18NMessagesState {
  const InitI18NMessagesState();
}

class LoadingI18NMessagesState extends I18NMessagesState {
  const LoadingI18NMessagesState();
}

class LoadedI18NMessagesState extends I18NMessagesState {
  final List<I18NMessages> _messages;

  const LoadedI18NMessagesState(this._messages);
}

class FatalErrorI18NMessagesState extends I18NMessagesState {
  const FatalErrorI18NMessagesState();
}

class I18NMessages{
  final Map<String, String> _messages;
  I18NMessages(this._messages);

  String get(String key){
    assert(key != null);
    assert(_messages.containsKey(key));
    return _messages[key];
  }
}

class I18NLoadingView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<I18NMessagesCubit, I18NMessagesState>(builder: (context,state){
      if(state is InitI18NMessagesState || state is LoadingI18NMessagesState){
        return Progress();
      }
      if(state is LoadedI18NMessagesState){
        return View;
      }
      return Text('Error');
    });
  }
}
