import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meal_app/widgets/main_drawer.dart';

import '../dummy_data.dart';

class FiltersScreen extends StatefulWidget {
  static const routName = 'meal_filter';

  final Function saveFilters;
  final Map<String,bool> currentFilters;

  const FiltersScreen(this.saveFilters, this.currentFilters);

  @override
  _FiltersScreenState createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  bool _isGlutenFree = false;
  bool _isLactoseFree = false;
  bool _isVegan = false;
  bool _isVegetarian = false;

  @override
  initState(){
    setState(() {
      _isGlutenFree = widget.currentFilters['gluten'];
      _isLactoseFree = widget.currentFilters['lactose'];
      _isVegan = widget.currentFilters['vegan'];
      _isVegetarian = widget.currentFilters['vegetarian'];
    });

    super.initState();
  }

  Widget buildSwitchListTile(String title, bool currentValue,
      Function updateValue, String description) {
    return SwitchListTile(
      value: currentValue,
      onChanged: updateValue,
      title: Text(title),
      subtitle: Text(description),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Filters'),
        actions: [
          IconButton(
            onPressed: () {
             final Map<String, bool> selectedFilters = {
                'gluten': _isGlutenFree,
                'lactose': _isLactoseFree,
                'vegan': _isVegan,
                'vegetarian': _isVegetarian,
              };
               widget.saveFilters(selectedFilters);
            },
            icon: Icon(
              Icons.save,
            ),
          )
        ],
      ),
      body: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(20),
            child: Text(
              'Adjust your meal selection',
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
          Expanded(
            child: ListView(
              children: <Widget>[
                buildSwitchListTile('Gluten-free', _isGlutenFree, (newValue) {
                  setState(() {
                    _isGlutenFree = newValue;
                  });
                }, 'Only include gluten-free meals'),
                buildSwitchListTile('Lactose-free', _isLactoseFree, (newValue) {
                  setState(() {
                    _isLactoseFree = newValue;
                  });
                }, 'Only include Lactose-free meals'),
                buildSwitchListTile('Vegetarian', _isVegan, (newValue) {
                  setState(() {
                    _isVegan = newValue;
                  });
                }, 'Only include Vegetarian meals'),
                buildSwitchListTile('Vegan', _isVegetarian, (newValue) {
                  setState(() {
                    _isVegetarian = newValue;
                  });
                }, 'Only include Vegan meals'),
              ],
            ),
          ),
        ],
      ),
      drawer: MainDrawer(),
    );
  }
}
