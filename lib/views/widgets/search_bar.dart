import 'package:flutter/material.dart';
import 'package:todo/utils/styles.dart';

class SearchBar extends StatelessWidget {
  const SearchBar({
    Key key,
    @required TextEditingController searchBarController,
    @required this.hideSearchBar,
  })  : _searchBarController = searchBarController,
        super(key: key);

  final TextEditingController _searchBarController;
  final VoidCallback hideSearchBar;

  @override
  Widget build(BuildContext context) {
    return TextField(
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
        ),
        contentPadding: EdgeInsets.only(left: 12),
        fillColor: Colors.grey.withOpacity(.3),
        filled: true,
        border: OutlineInputBorder(borderSide: BorderSide.none),
        hintText: "Search",
        hintStyle: TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }
}
