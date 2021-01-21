import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'provider.dart';

class DateListWidget extends HookWidget {
  const DateListWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext _) {
    final days = useProvider(daysProvider);
    return ListView.builder(
      reverse: true,
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        final date = index.asDate;
        final label = Text('${date.day}/${date.month}');
        if (index == days.value) {
          return RaisedButton(
            color: Theme.of(context).accentColor,
            onPressed: () {},
            child: label,
          );
        } else {
          return FlatButton(
            onPressed: () => days.value = index,
            child: label,
          );
        }
      },
    );
  }
}
