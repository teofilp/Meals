import 'package:flutter/material.dart';

import './../widgets/main_drawer.dart';

class FiltersScreen extends StatefulWidget {
  static const routeName = '/filters';

  final Function saveFilters;
  final Map<String, bool> currentFilters;

  FiltersScreen(this.saveFilters, this.currentFilters);

  @override
  _FiltersScreenState createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  bool _glutenFree = false;
  bool _vegetarian = false;
  bool _vegan = false;
  bool _lactoseFree = false;

  @override
  initState(){
    _glutenFree = widget.currentFilters['gluten'];
    _vegetarian = widget.currentFilters['vegetarian'];
    _vegan = widget.currentFilters['vegan'];
    _lactoseFree = widget.currentFilters['lactose'];
    super.initState();
  }

  Widget buildSwitchTile(title, subtitle, value, onChange) {
    return SwitchListTile.adaptive(
        title: Text(title),
        value: value,
        subtitle: Text(subtitle),
        onChanged: onChange);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your filters'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              final selectedFilters = {
                'gluten': _glutenFree,
                'lactose': _lactoseFree,
                'vegan': _vegan,
                'vegetarian': _vegetarian,
              };
              widget.saveFilters(selectedFilters);
            },
          )
        ],
      ),
      drawer: MainDrawer(),
      body: Column(children: [
        Container(
          padding: EdgeInsets.all(20),
          child: Text(
            'Adjust your meal selection',
            style: Theme.of(context).textTheme.title,
          ),
        ),
        Expanded(
          child: ListView(children: [
            buildSwitchTile(
                'Gluten Free', 'Only include gluten-free meals.', _glutenFree,
                (val) {
              setState(() {
                _glutenFree = val;
              });
            }),
            buildSwitchTile(
                'Vegetarian', 'Only include vegetarian meals.', _vegetarian,
                (val) {
              setState(() {
                _vegetarian = val;
              });
            }),
            buildSwitchTile('Vegan', 'Only include vegan meals.', _vegan,
                (val) {
              setState(() {
                _vegan = val;
              });
            }),
            buildSwitchTile(
                'Lactose Free', 'Only include vegan meals.', _lactoseFree,
                (val) {
              setState(() {
                _lactoseFree = val;
              });
            }),
          ]),
        ),
      ]),
    );
  }
}
