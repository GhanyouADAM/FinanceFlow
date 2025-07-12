import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:the_app/core/provider/theme_provider.dart';
import 'package:the_app/core/theme/build_extension.dart';
import 'package:the_app/presentation/pages/category/widget/color_picker.dart';
import 'package:the_app/presentation/pages/home/widgets/title_widget.dart';
import 'package:the_app/presentation/pages/settings/widgets/a_propos_widget.dart';
import 'package:the_app/presentation/pages/settings/widgets/apparence_widget.dart';
import 'package:the_app/presentation/pages/settings/widgets/devise_widget.dart';

class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

// Available colors for selection
final colors = [
  Colors.red,
  Colors.pink,
  Colors.purple,
  Colors.deepPurple,
  Colors.indigo,
  Colors.blue,
  Colors.lightBlue,
  Colors.cyan,
  Colors.teal,
  Colors.green,
  Colors.lightGreen,
  Colors.lime,
  Colors.yellow,
  Colors.amber,
  Colors.orange,
  Colors.deepOrange,
  Colors.brown,
  Colors.grey,
  Colors.blueGrey,
];
class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
final selectedColor = ref.watch(colorProvider);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text('Paramètres'),
        titleTextStyle: context.textTheme.headlineSmall,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              //---------appearence------
              TitleWidget(title: 'Apparence'),
              SizedBox(height: 9,),
              ApparenceWidget(),

              SizedBox(height: 15,),
              //---------currencies----------

              TitleWidget(title: 'Devises'),
              SizedBox(height: 9,),
              DeviseWidget(),
              SizedBox(height: 15,),
            //----application color---
              TitleWidget(title: 'Couleur'),
              SizedBox(height: 9,),
              ColorPicker(colors: colors, selectedColor: selectedColor, onSelectedColor: (color)=> ref.read(colorProvider.notifier).changeColor(color)),
              // Après votre ColorPicker
              SizedBox(height: 15),
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Mini AppBar
                    Container(
                      height: 40,
                      decoration: BoxDecoration(
                        color: selectedColor,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(12),
                          topRight: Radius.circular(12),
                        ),
                      ),
                      child: Row(
                        children: [
                          SizedBox(width: 8),
                          Icon(Icons.menu, color: Colors.white, size: 18),
                          SizedBox(width: 12),
                          Text('Budget Buddy',
                              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                          Spacer(),
                          Icon(Icons.more_vert, color: Colors.white, size: 18),
                          SizedBox(width: 8),
                        ],
                      ),
                    ),

                    // Mini Content
                    Container(
                      padding: EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Mini card
                          Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Theme.of(context).cardColor,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: Colors.grey.shade300),
                            ),
                            child: Row(
                              children: [
                                Icon(Icons.shopping_cart, color: selectedColor, size: 20),
                                SizedBox(width: 8),
                                Text('Courses', style: TextStyle(fontSize: 12)),
                                Spacer(),
                                Text('150 €', style: TextStyle(
                                  color: selectedColor,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                )),
                              ],
                            ),
                          ),

                          SizedBox(height: 10),

                          // Mini button
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: selectedColor,
                                  minimumSize: Size(150, 30),
                                  padding: EdgeInsets.zero,
                                ),
                                child: Text('Ajouter', style: TextStyle(
                                    color: Colors.white, fontSize: 12
                                )),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    // Mini Bottom Navigation
                    Container(
                      height: 40,
                      decoration: BoxDecoration(
                        color: Theme.of(context).cardColor,
                        border: Border(top: BorderSide(color: Colors.grey.shade300)),
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(12),
                          bottomRight: Radius.circular(12),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Icon(Icons.home, color: selectedColor, size: 18),
                          Icon(Icons.history, color: Colors.grey, size: 18),
                          Icon(Icons.add_circle, color: selectedColor, size: 24),
                          Icon(Icons.pie_chart, color: Colors.grey, size: 18),
                          Icon(Icons.settings, color: Colors.grey, size: 18),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              //-----about us-------
              TitleWidget(title: 'A propos'),
              SizedBox(height: 9,),
              AProposWidget()
            ],
          ),
        ),
      )
    );
  }
}
