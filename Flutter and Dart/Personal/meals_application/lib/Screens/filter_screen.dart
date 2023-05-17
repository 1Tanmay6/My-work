import 'package:flutter/material.dart';

import '../Widgets/main_drawer.dart';

class FilterScreen extends StatefulWidget {
  static const routeName = '/filters';
  Function filterSetter;
  final Map<String, bool> currentfilters;
  FilterScreen(this.filterSetter, this.currentfilters);

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  bool _glutenFree = false;
  bool _vegetarian = false;
  bool _vegan = false;
  bool _lactoseFree = false;
  @override
  void initState() {
    _glutenFree = widget.currentfilters['gluten'] as bool;
    _vegan = widget.currentfilters['vegan'] as bool;
    _lactoseFree = widget.currentfilters['lactose'] as bool;
    _vegetarian = widget.currentfilters['lactose'] as bool;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool newval = false;

    return Scaffold(
      appBar: AppBar(
        title: Text('Filters'),
        actions: [
          IconButton(
              onPressed: () {
                final selectedFilters = {
                  'gluten': _glutenFree,
                  'vegan': _vegan,
                  'lactose': _lactoseFree,
                  'vegetarian': _vegetarian
                };

                widget.filterSetter(selectedFilters);
              },
              icon: Icon(Icons.task_alt_sharp))
        ],
      ),
      drawer: MainDrawer(),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(20),
            child: Text(
              'Adjust Your Meal Selection',
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
          Expanded(
              child: ListView(
            children: [
              SwitchListTile(
                value: _glutenFree,
                onChanged: (newValue) {
                  setState(() {
                    _glutenFree = newValue;
                  });
                },
                title: Text('Gluten free meals'),
                subtitle: Text('Only includes Gluten Free Meals'),
              ),
              SwitchListTile(
                value: _vegetarian,
                onChanged: (newValue) {
                  setState(() {
                    _vegetarian = newValue;
                  });
                },
                title: Text('Vegetarian meals'),
                subtitle: Text('Only includes Vegetarian meals.'),
              ),
              SwitchListTile(
                value: _vegan,
                onChanged: (newValue) {
                  setState(() {
                    _vegan = newValue;
                  });
                },
                title: Text('Vegan meals'),
                subtitle: Text('Only includes Vegan meals.'),
              ),
              SwitchListTile(
                value: _lactoseFree,
                onChanged: (newValueLactose) {
                  setState(() {
                    _lactoseFree = newValueLactose;
                    newval = newValueLactose;
                  });
                },
                title: Text('Lactose free'),
                subtitle: Text('Only includes Lactose free meals.'),
              )
            ],
          )),
        ],
      ),
    );
  }
}
