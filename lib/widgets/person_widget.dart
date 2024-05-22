import 'package:flutter/material.dart';
import 'package:gov/models/Person.dart';

class PersonWidget extends StatelessWidget {
  const PersonWidget(this.person, {this.reverse = false, super.key,  this.onTap});

  final Person person;

  final bool reverse;

  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    final list = [
      /*if (person.image == null)
        CircleAvatar(child: Icon(Icons.person))
      else
        CircleAvatar(
          backgroundImage: NetworkImage(person.image!),
        ),
      SizedBox(width: 5),*/
      Text(person.name, style: Theme.of(context).textTheme.titleMedium),
    ];
    return TextButton(
      onPressed: onTap,
      child: Row(
          mainAxisSize: MainAxisSize.min,
          children: reverse ? list.reversed.toList(growable: false) : list),
    );
  }
}
