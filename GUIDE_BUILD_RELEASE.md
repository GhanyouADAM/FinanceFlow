# Guide rapide : Générer un APK release signé pour Android

1. **Vérifie la présence des fichiers nécessaires**
   - `android/key.properties` (avec les bons mots de passe et chemins)
   - `android/app/financeflow-release-key.jks` (ton keystore)

2. **Structure recommandée**

```
the_app/
  android/
    key.properties
    app/
      financeflow-release-key.jks
      build.gradle.kts
```

3. **Exemple de contenu pour `key.properties`**

```
storePassword=tonMotDePasse
keyPassword=tonMotDePasse
keyAlias=tonAlias
storeFile=financeflow-release-key.jks
```

4. **Commande pour générer l’APK release**

Dans le dossier racine du projet (là où il y a `pubspec.yaml`) :

```powershell
flutter build apk --release --no-tree-shake-icons
```

5. **APK généré**

Le fichier APK se trouvera dans :
```
build/app/outputs/flutter-apk/app-release.apk
```

6. **Conseils**
- Si tu changes de machine, copie aussi le fichier `.jks` et le fichier `key.properties`.
- Ne partage jamais ton keystore publiquement.
- Pour automatiser : tu peux créer un script PowerShell `build-release.ps1` avec :

```powershell
flutter clean
flutter pub get
flutter build apk --release --no-tree-shake-icons
```

---

**Besoin d’un script ou d’un guide plus détaillé ?**
Dis-moi ce que tu veux automatiser ou documenter !
