import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../Widgets/main_drawer.dart';

class FiltersScreen extends StatefulWidget {
  static const routeName = '/filters';
  final Function saveFilters;
  final Map<String, bool> currentFilters;

  FiltersScreen(this.currentFilters, this.saveFilters);

  @override
  _FiltersScreenState createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  bool _glutenFree = false;
  bool _vegetarian = false;
  bool _vegan = false;
  bool _lactoseFree = false;

  @override
  initState() {
    _glutenFree = widget.currentFilters['gluten'];
    _vegetarian = widget.currentFilters['vegetarian'];
    _vegan = widget.currentFilters['vegan'];
    _lactoseFree = widget.currentFilters['lactose'];
    super.initState();
  }

  Widget _buildSwitchListTile(
      String title, String subtitle, bool currentValue, Function updateValue) {
    return SwitchListTile(
      value: currentValue,
      onChanged: updateValue,
      title: Text(title),
      subtitle: Text(subtitle),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Filters'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              final selectedFilters = {
                'gluten': _glutenFree,
                'vegetarian': _vegetarian,
                'vegan': _vegan,
                'lactose': _lactoseFree,
              };
              widget.saveFilters(selectedFilters);
            },
          )
        ],
      ),
      drawer: MainDrawer(),
      body: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(16),
            child: Text(
              'Adjust your meal selection',
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
          Expanded(
            child: ListView(
              children: <Widget>[
                _buildSwitchListTile(
                  'Gluten-free',
                  'Only choose gluten-free meals',
                  _glutenFree,
                  (value) {
                    setState(() {
                      _glutenFree = value;
                    });
                  },
                ),
                _buildSwitchListTile(
                  'Vegetarian',
                  'Only choose vegetarian meals',
                  _vegetarian,
                  (value) {
                    setState(() {
                      _vegetarian = value;
                    });
                  },
                ),
                _buildSwitchListTile(
                  'Vegan',
                  'Only choose vegan meals',
                  _vegan,
                  (value) {
                    setState(() {
                      _vegan = value;
                    });
                  },
                ),
                _buildSwitchListTile(
                  'Lactose-free',
                  'Only choose lactose-free meals',
                  _lactoseFree,
                  (value) {
                    setState(() {
                      _lactoseFree = value;
                    });
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
