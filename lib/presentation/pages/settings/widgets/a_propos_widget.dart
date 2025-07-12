import 'package:flutter/material.dart';
import 'package:the_app/core/theme/build_extension.dart';

class AProposWidget extends StatelessWidget {
  const AProposWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(9),
      decoration: BoxDecoration(
        color: context.colorScheme.surface,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            spreadRadius: 2,
            color: Colors.grey.shade300,
            offset: Offset(1, 2)
          )
        ]
      ),
      child: Column(
        children: [
          ListTile(
            leading: Icon(Icons.info_outline_rounded),
            title: Text('Version'),
            subtitle: Text('1.2.0'),
          ),
          const Divider(),
          ListTile(
            leading: Icon(Icons.code_outlined),
            title: Text('Développeur'),
            subtitle: Text('Abdoul-ghanyou ADAM'),
          ), 
          const Divider(),
          ListTile(
            leading: Icon(Icons.star),
            title: Text('Noter l\'application '),
          ),
          SizedBox(height: 7,),
          ListTile(
            leading: Icon(Icons.perm_device_information),
            title: Text('Politique de confidentialité'),
          ),
          SizedBox(height: 7,),
          ListTile(
            leading: Icon(Icons.comment),
            title: Text('Envoyer un commentaire'),
          )
        ],
      ),
    );
  }
}