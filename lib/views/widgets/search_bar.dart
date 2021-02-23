import 'package:flutter/material.dart';
import 'package:todo/utils/styles.dart';

class SearchBar extends StatelessWidget {
  const SearchBar({
    Key key,
    @required TextEditingController searchBarController,
    @required this.hideSearchBar,
    @required this.onChanged,
  })  : _searchBarController = searchBarController,
        super(key: key);

  final TextEditingController _searchBarController;
  final VoidCallback hideSearchBar;
  final void Function(String) onChanged;

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: this.onChanged,
      autofocus: true,
      style: TextStyle(color: TodoColors.accent),
      cursorColor: TodoColors.accent,
      controller: _searchBarController,
      decoration: InputDecoration(
        suffixIcon: IconButton(
          icon: Icon(Icons.cancel, color: TodoColors.accent, size: 24),
          onPressed: this.hideSearchBar,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50),
          borderSide: BorderSide.none,
        ),
        contentPadding: EdgeInsets.only(left: 12),
        fillColor: Colors.white.withOpacity(0.125),
        filled: true,
        border: OutlineInputBorder(borderSide: BorderSide.none),
        hintText: "Search task",
        hintStyle: TextStyle(color: Colors.grey),
      ),
    );
  }
}
