import 'package:flutter/material.dart';

class WelcomeDialog extends StatelessWidget {
  const WelcomeDialog({Key? key, required this.isFirstLaunch, required this.appVersion}) : super(key: key);
final bool isFirstLaunch;
final String appVersion;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(isFirstLaunch ? 'Bienvenue sur FinanceFlow' : 'Mise à jour vers la version $appVersion'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if(isFirstLaunch) ...[
              Text('Merci d\'avoir installé FinanceFlow'),
              SizedBox(height: 8,),
              Text('Voici quelques fonctionnalités que vous pouvez utiliser :'),
              _buildFeatureItem('Gérer vos finances facilement a travers l\'ajout de transactions'),
              _buildFeatureItem('Créer vos propres catégories a souhait'),
              _buildFeatureItem('Filtrer vos transactions'),
              _buildFeatureItem('Analyser vos habitudes financières au fil du temps'),
              Text('Mode d\'emploi :'),
              _buildFeatureItem('Avant toute l\'ajout de toutes transactions, vous dever créer les catégorie auxquelles vont appartenir ces transactions'),
              _buildFeatureItem('Une fois sur la page des categorie vous avez deux types de categories'),
              _buildFeatureItem('Vous avez les depenses qui va représenter les trnasactions qui font baisser votre solde(vos fonds) tels que : déplacement, logement,...'),
             _buildFeatureItem('Et revenu qui représentes vos sources de revenus tels que: salaire, cadeaux,...'),
             _buildFeatureItem('Une fois fait vous pouver selectionner ses derniers dans l\'ecran d\'ajout de transaction et vous êtes ok'),
            _buildFeatureItem('Swiper vers la gauche sur une transaction pour la supprimer'),
            ] else ...[
              Text('Nouveautés dans cette version'),
              _buildFeatureItem('Corrections de bugs mineures'),
              _buildFeatureItem('Optimisation de l\'interface'),
              _buildFeatureItem('Personalisation du theme principal de l application'),
            ]
          ],
        ),
      ),
      actions: [
        TextButton(onPressed: ()=> Navigator.of(context).pop(), child: Text('Compris')),
      ],
    );
  }
}

Widget _buildFeatureItem(String text){
  return Padding(
    padding: const EdgeInsets.only(top: 8),
    child: Row(
  children: [
    Icon(Icons.check_circle, size: 16, color: Colors.green,),
    SizedBox(width: 8),
    Expanded(child: Text(text)),
    ],
  ),
  );
}
