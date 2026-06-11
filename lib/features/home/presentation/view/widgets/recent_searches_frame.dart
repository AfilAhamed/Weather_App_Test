import 'package:flutter/material.dart';

class RecentSearchesDropdownFrame extends StatelessWidget {
  final List<String> recentSearches;
  final ValueChanged<String> onCitySelected;

  const RecentSearchesDropdownFrame({
    super.key,
    required this.recentSearches,
    required this.onCitySelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 5),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: recentSearches.length,
        itemBuilder: (context, index) {
          return ListTile(
            dense: true,

            leading: const Icon(Icons.history),
            title: Text(recentSearches[index]),
            onTap: () => onCitySelected(recentSearches[index]),
          );
        },
        separatorBuilder: (_, _) => const Divider(height: 1),
      ),
    );
  }
}