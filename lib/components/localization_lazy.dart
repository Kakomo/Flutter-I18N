import 'package:bytebank/components/progress.dart';
import 'package:flutter/cupertino.dart';
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
  final I18NMessages _messages;

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

class I18NMessagesCubit extends Cubit<I18NMessagesState>{
  I18NMessagesCubit() : super(InitI18NMessagesState());

  reload(){
    emit(LoadingI18NMessagesState());
    //TODO
    emit(LoadedI18NMessagesState(I18NMessages({"key":"value"})));
  }
}

class I18NLoadingContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (context){
      final cubit = I18NMessagesCubit();
      cubit.reload();
      return cubit;
    },
    child: I18NLoadingView(),
    );
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
        final messages = state._messages;
        return View;
      }
      return Text('Error');
    });
  }
}
