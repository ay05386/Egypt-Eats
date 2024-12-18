import 'package:flutter/material.dart';
import 'package:meals/Widget/main_drawer.dart';
// import 'package:meals/screens/tabs.dart';
import 'package:meals/providers/filters_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//enum Filters { glutenFree, lactoseFree, vegetarian, vegan }

class filtersScreen extends ConsumerStatefulWidget {
  const filtersScreen({super.key});

  @override
  ConsumerState<filtersScreen> createState() {
    return _filterScreenState();
  }
}

class _filterScreenState extends ConsumerState<filtersScreen> {
  @override
  var glutenFreeCheck = false;
  var lactoseFreeCheck = false;
  var vaeganCheck = false;
  var vegetarianCheck = false;
  @override
  void initState() {
    super.initState();
    final activeFilters = ref.read(filtersProvider);
    glutenFreeCheck = activeFilters[Filters.glutenFree]!;
    lactoseFreeCheck = activeFilters[Filters.lactoseFree]!;
    vegetarianCheck = activeFilters[Filters.vegetarian]!;
    vaeganCheck = activeFilters[Filters.vegan]!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Filters"),
      ),
      /*
      drawer: mainDrawer(onSelectScreen: (identifier) {
        Navigator.of(context).pop();
        if (identifier == 'meals') {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (ctx) => const tabsScreen()));
        }
      }),*/
      body: WillPopScope(
        onWillPop: () async {
          ref.read(filtersProvider.notifier).setFilters({
            Filters.glutenFree: glutenFreeCheck,
            Filters.lactoseFree: lactoseFreeCheck,
            Filters.vegetarian: vegetarianCheck,
            Filters.vegan: vaeganCheck
          });
          //  Navigator.of(context).pop();
          return true;
        },
        child: Column(
          children: [
            SwitchListTile(
              value: glutenFreeCheck,
              onChanged: (isChecked) {
                setState(() {
                  glutenFreeCheck = isChecked;
                });
              },
              title: Text(
                "Gluten-Free",
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground),
              ),
              subtitle: Text(
                'Only Include gluten free meals',
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground),
              ),
              activeColor: Theme.of(context).colorScheme.tertiary,
              contentPadding: const EdgeInsets.only(left: 34, right: 22),
            ),
            SwitchListTile(
              value: lactoseFreeCheck,
              onChanged: (isChecked) {
                setState(() {
                  lactoseFreeCheck = isChecked;
                });
              },
              title: Text(
                "Lactose-Free",
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground),
              ),
              subtitle: Text(
                'Only Include lactose free meals',
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground),
              ),
              activeColor: Theme.of(context).colorScheme.tertiary,
              contentPadding: const EdgeInsets.only(left: 34, right: 22),
            ),
            SwitchListTile(
              value: vegetarianCheck,
              onChanged: (isChecked) {
                setState(() {
                  vegetarianCheck = isChecked;
                });
              },
              title: Text(
                "Vegetarian",
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground),
              ),
              subtitle: Text(
                'Only Include Vegetarian meals',
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground),
              ),
              activeColor: Theme.of(context).colorScheme.tertiary,
              contentPadding: const EdgeInsets.only(left: 34, right: 22),
            ),
            SwitchListTile(
              value: vaeganCheck,
              onChanged: (isChecked) {
                setState(() {
                  vaeganCheck = isChecked;
                });
              },
              title: Text(
                "Vegan",
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground),
              ),
              subtitle: Text(
                'Only Include Vegan meals',
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground),
              ),
              activeColor: Theme.of(context).colorScheme.tertiary,
              contentPadding: const EdgeInsets.only(left: 34, right: 22),
            )
          ],
        ),
      ),
    );
  }
}
